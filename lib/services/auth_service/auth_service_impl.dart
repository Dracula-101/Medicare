import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medicare/data/models/user/user.dart';
import 'package:medicare/services/data_storage_service/data_storage_service.dart';
import 'package:medicare/services/log_service/log_service.dart';

import 'auth_service.dart';

class AuthServiceImpl implements AuthService {
  AuthServiceImpl({
    required this.firebaseAuth,
    required this.googleSignInClient,
    required this.storage,
    required this.logger,
  });
  User? authUser;
  final auth.FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignInClient;
  final LogService logger;
  final DataStorageService storage;

  @override
  User? get currentUser => authUser;

  @override
  Stream<User?> get onAuthStateChanged =>
      firebaseAuth.authStateChanges().asyncMap(
        (auth.User? user) async {
          if (user == null) {
            return null;
          }
          if (authUser?.id == user.uid) {
            return authUser;
          } else {
            authUser = await storage.getUser(id: user.uid);
          }
          return authUser;
        },
      );

  @override
  Future<User> registerUser(User user, String password) async {
    try {
      authUser = user;
      auth.UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: user.email, password: password);
      // get photo url
      user = user.copyWith(
        id: userCredential.user!.uid,
        avatar: userCredential.user!.photoURL ??
            'https://api.dicebear.com/7.x/micah/svg?seed=${user.name}',
      );
      await storage.setUser(user: user);
      await userCredential.user?.updateDisplayName(user.name);
      return user;
    } catch (e) {
      authUser = null;
      logger.e('AuthService registerUser failed', e, StackTrace.current);
      rethrow;
    }
  }

  @override
  Future<User> signInWithEmail(String email, String password) async {
    try {
      auth.UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      authUser = await storage.getUser(id: userCredential.user!.uid);
      return authUser!;
    } catch (e) {
      logger.e('AuthService signInWithEmail failed', e, StackTrace.current);
      rethrow;
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    try {
      GoogleSignInAccount? signInAccount = await googleSignInClient.signIn();
      if (signInAccount == null) {
        throw Exception('Google sign in cancelled');
      }
      GoogleSignInAuthentication signInAuthentication =
          await signInAccount.authentication;
      auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
        accessToken: signInAuthentication.accessToken,
        idToken: signInAuthentication.idToken,
      );
      Map<String, dynamic>? userMap =
          await storage.getData(path: 'users/${signInAccount.id}');
      if (userMap == null) {
        bool isGoogleConnected =
            (userMap?.containsKey('isGoogleConnected') ?? false)
                ? userMap!['isGoogleConnected']
                : false;
        if (!isGoogleConnected) {
          throw Exception(
              'Connect your google account first with email in settings');
        }
      }
      auth.UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);
      authUser = await storage.getUser(id: userCredential.user?.uid);
      return authUser!;
    } catch (e) {
      logger.e('AuthService signInWithGoogle failed', e, StackTrace.current);
      rethrow;
    }
  }

  @override
  Future<void> signOut() {
    try {
      return Future.wait([
        firebaseAuth.signOut(),
        googleSignInClient.signOut(),
      ]);
    } catch (e) {
      logger.e('AuthService signOut failed', e, StackTrace.current);
      rethrow;
    }
  }
}
