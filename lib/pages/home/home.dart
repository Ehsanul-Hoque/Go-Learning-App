import "package:app/app_config/app_state.dart";
import "package:app/app_config/default_parameters.dart";
import "package:flutter/widgets.dart";

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          AppState().strings.page1,
          style: DefaultParameters.defaultTextStyle,
        ),
      ),
    );
  }
}
