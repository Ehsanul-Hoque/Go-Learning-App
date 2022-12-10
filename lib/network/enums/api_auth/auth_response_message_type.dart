enum AuthResponseMessageType {
  noAccount("no account found"),
  alreadyHasAccount("the email is already in use"),
  invalidPassword("incorrect password"),
  tooSmallPassword("\"password\" length must be at least"),
  tooSmallName("\"name\" length must be at least"),
  unknown("---");

  final String message;

  const AuthResponseMessageType(this.message);

  static AuthResponseMessageType valueOf(String message) {
    return AuthResponseMessageType.values.firstWhere(
      (AuthResponseMessageType element) =>
          message.toLowerCase().contains(element.message.toLowerCase()),
      orElse: () => AuthResponseMessageType.unknown,
    );
  }
}
