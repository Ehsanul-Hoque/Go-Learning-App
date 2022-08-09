import "package:app/app_config/resources.dart";
import "package:flutter/widgets.dart";

class Courses extends StatelessWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          Res.str.page2,
          style: Res.textStyles.general,
        ),
      ),
    );
  }
}
