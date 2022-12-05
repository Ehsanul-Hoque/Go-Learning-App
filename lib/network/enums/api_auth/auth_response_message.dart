enum AuthResponseMessage {
  noAccount("no account found"),
  alreadyHasAccount("the email is already in use"),
  invalidPassword("incorrect password"),
  tooSmallPassword("\"password\" length must be at least"),
  tooSmallName("\"name\" length must be at least"),
  unknown("");

  final String message;

  const AuthResponseMessage(this.message);

  static AuthResponseMessage valueOf(String message) {
    return AuthResponseMessage.values.firstWhere(
      (AuthResponseMessage element) =>
          message.toLowerCase().contains(element.message.toLowerCase()),
      orElse: () => AuthResponseMessage.unknown,
    );
  }
}
