class ResetPasswordFailure {
  final String errorMessage;
  const ResetPasswordFailure([this.errorMessage = "An unknown error occurred"]);
  factory ResetPasswordFailure.code(String code) {
    switch (code) {
      case 'invalid-email':
        return ResetPasswordFailure('Email entered is invalid');
      case 'missing-email':
        return ResetPasswordFailure('No Email entered');
      case 'user-not-found':
        return ResetPasswordFailure(
          'There is no account with this email registered',
        );
      default:
        return ResetPasswordFailure('An unknown error occurred. Try again');
    }
  }
}
