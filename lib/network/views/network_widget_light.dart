import "package:app/network/enums/network_call_status.dart";
import "package:flutter/widgets.dart";

typedef SelectFunction = NetworkCallStatus Function(BuildContext context);
typedef ChildBuilder = Widget Function(
  BuildContext context,
  NetworkCallStatus callStatus,
);

class NetworkWidgetLight extends StatefulWidget {
  final SelectFunction callStatusSelector;
  final ChildBuilder childBuilder;
  final void Function()? onStatusNone,
      onStatusNoInternet,
      onStatusLoading,
      onStatusCancelled,
      onStatusFailed,
      onStatusSuccess;

  const NetworkWidgetLight({
    Key? key,
    required this.callStatusSelector,
    required this.childBuilder,
    this.onStatusNone,
    this.onStatusNoInternet,
    this.onStatusLoading,
    this.onStatusCancelled,
    this.onStatusFailed,
    this.onStatusSuccess,
  }) : super(key: key);

  @override
  State<NetworkWidgetLight> createState() => _NetworkWidgetLightState();
}

class _NetworkWidgetLightState extends State<NetworkWidgetLight> {
  NetworkCallStatus previousCallStatus = NetworkCallStatus.none;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        NetworkCallStatus callStatus = widget.callStatusSelector(context);

        if (previousCallStatus != callStatus) {
          switch (callStatus) {
            case NetworkCallStatus.none:
              widget.onStatusNone?.call();
              break;

            case NetworkCallStatus.noInternet:
              widget.onStatusNoInternet?.call();
              break;

            case NetworkCallStatus.loading:
              widget.onStatusLoading?.call();
              break;

            case NetworkCallStatus.cancelled:
              widget.onStatusCancelled?.call();
              break;

            case NetworkCallStatus.failed:
              widget.onStatusFailed?.call();
              break;

            case NetworkCallStatus.success:
              widget.onStatusSuccess?.call();
              break;
          }

          previousCallStatus = callStatus;
        }

        return widget.childBuilder(context, callStatus);
      },
    );
  }
}
