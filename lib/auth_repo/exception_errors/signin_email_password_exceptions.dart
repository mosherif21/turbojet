class SignInWithEmailAndPasswordFailure {
  final String errorMessage;
  const SignInWithEmailAndPasswordFailure([
    this.errorMessage = "An unknown error occurred",
  ]);
  factory SignInWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'user-not-found':
        return SignInWithEmailAndPasswordFailure(
          'There is no account with this email registered',
        );
      case 'invalid-credential':
        return SignInWithEmailAndPasswordFailure(
          'Wrong email or password, please try again',
        );
      default:
        return SignInWithEmailAndPasswordFailure(
          'An unknown error occurred. Try again',
        );
    }
  }
}
