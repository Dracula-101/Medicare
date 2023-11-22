class HelperFunction {
  static String getInitials(String name) {
    List<String> names = name.split(" ");
    String initials = "";
    int numWords = 2;

    if (names.length < 2) {
      numWords = names.length;
    }

    for (int i = 0; i < numWords; i++) {
      initials += names[i][0];
    }

    return initials;
  }

  static String getInitialsFromEmail(String email) {
    List<String> names = email.split("@");
    String initials = "";
    int numWords = 2;

    if (names.length < 2) {
      numWords = names.length;
    }

    for (int i = 0; i < numWords; i++) {
      initials += names[i][0];
    }

    return initials;
  }

  // verify email
  static bool verifyEmail(String email) {
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }
}

class ExceptionHelper {
  // firebase auth exceptions
  static String? getFirebaseAuthExceptionMessage(String code) {
    switch (code) {
      case 'invalid-email':
      case 'INVALID_EMAIL':
        return 'Invalid email address';
      case 'user-disabled':
      case 'USER_DISABLED':
        return 'User is disabled';
      case 'user-not-found':
      case 'USER_NOT_FOUND':
        return 'User not found';
      case 'wrong-password':
      case 'WRONG_PASSWORD':
        return 'Wrong password entered';
      case 'email-already-in-use':
      case 'EMAIL_ALREADY_IN_USE':
        return 'Email already in use. Please use another email';
      case 'operation-not-allowed':
      case 'OPERATION_NOT_ALLOWED':
        return 'Operation not allowed';
      case 'weak-password':
      case 'WEAK_PASSWORD':
        return 'User a password with 6 or more characters';
      case 'account-exists-with-different-credential':
      case 'ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL':
        return 'Account exists with different credential';
      case 'invalid-credential':
      case 'INVALID_CREDENTIAL':
        return 'Invalid credentials entered';
      case 'invalid-verification-code':
      case 'INVALID_VERIFICATION_CODE':
        return 'Invalid verification code';
      case 'invalid-verification-id':
      case 'INVALID_VERIFICATION_ID':
        return 'Invalid verification id';
      case 'too-many-requests':
      case 'TOO_MANY_REQUESTS':
        return 'Too many requests';
      case 'invalid-login-credentials':
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid email or password';
      case 'user-not-verified':
      case 'USER_NOT_VERIFIED':
        return 'User not verified';
      case 'user-not-registered':
      case 'USER_NOT_REGISTERED':
        return 'User not registered';
      default:
        return null;
    }
  }

  //platform exceptions
  static String getPlatformExceptionMessage(String code) {
    switch (code) {
      case 'ERROR_INVALID_EMAIL':
        return 'Invalid email address';
      case 'ERROR_USER_DISABLED':
        return 'User disabled';
      case 'ERROR_USER_NOT_FOUND':
        return 'User not found';
      case 'ERROR_WRONG_PASSWORD':
        return 'Wrong password';
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        return 'Email already in use';
      case 'ERROR_OPERATION_NOT_ALLOWED':
        return 'Operation not allowed';
      case 'ERROR_WEAK_PASSWORD':
        return 'Weak password';
      default:
        return 'Something went wrong';
    }
  }

  // firebase storage exceptions

  static String getFirebaseStorageExceptionMessage(String code) {
    switch (code) {
      case 'object-not-found':
        return 'Object not found';
      case 'unauthorized':
        return 'Unauthorized';
      case 'cancelled':
        return 'Cancelled';
      case 'unknown':
        return 'Unknown';
      default:
        return 'Something went wrong';
    }
  }

  //exception
  static String getExceptionMessage(Exception exception) {
    return exception.toString().split(":")[1];
  }
}
