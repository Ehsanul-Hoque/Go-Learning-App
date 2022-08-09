import "package:app/app_config/resources.dart";
import "package:flutter/widgets.dart";

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          Res.str.page1,
          style: Res.textStyles.general,
        ),
      ),
    );
  }
}
