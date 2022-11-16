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
      onStatusFailed,
      onStatusSuccess;

  const NetworkWidgetLight({
    Key? key,
    required this.callStatusSelector,
    required this.childBuilder,
    this.onStatusNone,
    this.onStatusNoInternet,
    this.onStatusLoading,
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
              if (widget.onStatusNone != null) widget.onStatusNone!();
              break;

            case NetworkCallStatus.noInternet:
              if (widget.onStatusNoInternet != null) {
                widget.onStatusNoInternet!();
              }
              break;

            case NetworkCallStatus.loading:
              if (widget.onStatusLoading != null) widget.onStatusLoading!();
              break;

            case NetworkCallStatus.failed:
              if (widget.onStatusFailed != null) widget.onStatusFailed!();
              break;

            case NetworkCallStatus.success:
              if (widget.onStatusSuccess != null) widget.onStatusSuccess!();
              break;
          }

          previousCallStatus = callStatus;
        }

        return widget.childBuilder(context, callStatus);
      },
    );
  }
}
