enum SignInResponseMessage {
  invalidEmail("no account found"),
  invalidPassword("incorrect password"),
  tooSmallPassword("length must be at least"),
  unknown("");

  final String message;

  const SignInResponseMessage(this.message);

  static SignInResponseMessage valueOf(String message) {
    return SignInResponseMessage.values.firstWhere(
      (SignInResponseMessage element) =>
          message.toLowerCase().contains(element.message.toLowerCase()),
      orElse: () => SignInResponseMessage.unknown,
    );
  }
}
