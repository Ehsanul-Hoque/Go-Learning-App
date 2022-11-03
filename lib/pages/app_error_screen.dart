import "package:app/app_config/resources.dart";
import "package:app/components/status_text.dart";
import "package:flutter/widgets.dart";

class AppErrorScreen extends StatelessWidget {
  const AppErrorScreen({
    Key? key,
    required Object? error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StatusText(Res.str.generalError),
    );
  }
}
