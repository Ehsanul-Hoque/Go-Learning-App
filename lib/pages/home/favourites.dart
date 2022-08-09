import "package:app/app_config/resources.dart";
import "package:flutter/widgets.dart";

class Favourites extends StatelessWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          Res.str.page3,
          style: Res.textStyles.general,
        ),
      ),
    );
  }
}
