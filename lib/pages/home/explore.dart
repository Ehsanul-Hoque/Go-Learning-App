import "package:app/app_config/app_state.dart";
import "package:app/app_config/default_parameters.dart";
import "package:flutter/widgets.dart";

class Courses extends StatelessWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          AppState().strings.page2,
          style: DefaultParameters.defaultTextStyle,
        ),
      ),
    );
  }
}
