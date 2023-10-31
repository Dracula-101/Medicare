import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthException implements Exception {
  final String message;
  final String code;

  AuthException({required this.message, required this.code});

  AuthException fromFirebaseException(FirebaseAuthException e) {
    return AuthException(
      message: mapFirebaseException(e),
      code: e.code,
    );
  }

  String mapFirebaseException(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'The user corresponding to the given email has been disabled.';
      case 'user-not-found':
        return 'The user corresponding to the given email was not found.';
      case 'wrong-password':
        return 'The password is invalid for the given email, or the account corresponding to the email does not have a password set.';
      case 'email-already-in-use':
        return 'The email address is already in use by another account.';
      case 'operation-not-allowed':
        return 'Indicates that Email & Password accounts are not enabled.';
      case 'weak-password':
        return 'The password must be 6 characters long or more.';
      default:
        return 'Unknown error.';
    }
  }

  AuthException fromException(Exception e) {
    return AuthException(
      message: e.toString(),
      code: 'unknown',
    );
  }

  AuthException fromString(String message) {
    return AuthException(
      message: message,
      code: 'unknown',
    );
  }

  AuthException fromPlatformException(PlatformException e) {
    return AuthException(
      message: e.message ?? 'Unknown error',
      code: e.code,
    );
  }

  String mapPlatformException(PlatformException exception) {
    switch (exception.code) {
      case 'ERROR_INVALID_EMAIL':
        return 'The email address is not valid.';
      default:
        return 'Unknown error.';
    }
  }

  @override
  String toString() {
    return 'AuthException{message: $message, code: $code}';
  }
}
