import "package:app/app_config/resources.dart";
import "package:app/utils/utils.dart";

class NetworkError {
  /// Constructor to create a new error object
  NetworkError({
    this.title = "",
    this.message = "",
  });

  /// Constructor to create a new error object with a generic error values
  NetworkError.general()
      : title = Res.str.sorryTitle,
        message = Res.str.generalError;

  /// Title of the error
  String title;

  /// Error message
  String message;

  /// toString() method
  @override
  String toString() {
    return Utils.getModelString(
      runtimeType.toString(),
      <String, dynamic>{
        "title": title,
        "message": message,
      },
    );
  }
}
