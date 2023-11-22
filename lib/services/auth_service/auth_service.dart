import 'package:medicare/data/models/user/user.dart';

abstract class AuthService {
  Future<User> signInWithEmail(String email, String password);
  Future<User> registerUser(User user, String password);
  Future<User> signInWithGoogle();
  Stream<User?> get onAuthStateChanged;
  Future<void> signOut();
  User? get currentUser;
}
