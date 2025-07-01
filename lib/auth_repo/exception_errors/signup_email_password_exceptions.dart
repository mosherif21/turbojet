class SignUpWithEmailAndPasswordFailure {
  final String errorMessage;
  const SignUpWithEmailAndPasswordFailure([
    this.errorMessage = "An unknown error occurred",
  ]);
  factory SignUpWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'weak-password':
        return SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password',
        );
      case 'invalid-email':
        return SignUpWithEmailAndPasswordFailure('Email entered is invalid');
      case 'requires-recent-login':
        return SignUpWithEmailAndPasswordFailure(
          'This operation is sensitive and requires recent authentication',
        );
      case 'email-already-in-use':
        return SignUpWithEmailAndPasswordFailure('This email already exists');
      case 'operation-not-allowed':
        return SignUpWithEmailAndPasswordFailure(
          'Operation now allowed. Contact Support',
        );
      case 'user-disabled':
        return SignUpWithEmailAndPasswordFailure('This user is disabled');
      default:
        return SignUpWithEmailAndPasswordFailure(
          'An unknown error occurred. Try again',
        );
    }
  }
}
