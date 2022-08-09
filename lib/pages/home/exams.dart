import "package:app/app_config/resources.dart";
import "package:flutter/widgets.dart";

class Exams extends StatelessWidget {
  const Exams({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          Res.str.page4,
          style: Res.textStyles.general,
        ),
      ),
    );
  }
}
