import "package:app/network/network_response.dart";

typedef ResponseCallback<DO> = void Function(NetworkResponse<DO> response);

class NetworkCallback<DO> {
  ResponseCallback<DO>? onStart;
  ResponseCallback<DO>? onLoading;
  ResponseCallback<DO>? onCancelled;
  ResponseCallback<DO>? onFailed;
  ResponseCallback<DO>? onSuccess;
  ResponseCallback<DO>? onUpdate;

  NetworkCallback({
    this.onStart,
    this.onLoading,
    this.onCancelled,
    this.onFailed,
    this.onSuccess,
    this.onUpdate,
  });
}
