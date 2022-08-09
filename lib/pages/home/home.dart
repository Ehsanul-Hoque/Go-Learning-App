import "package:app/app_config/resources.dart";
import "package:app/components/widget_carousal.dart";
import "package:flutter/widgets.dart";

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: Res.dimen.largeSpacingValue,
        ),
        child: Column(
          children: const <Widget>[
            WidgetCarousal(
              images: <String>[
                "https://images.unsplash.com/photo-1659635749899-c5edec6e5eec?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3387&q=80",
                "https://images.unsplash.com/photo-1659703024686-0c107a8300c7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1358&q=80",
                "https://images.unsplash.com/photo-1657299143363-621ba0a1e6ac?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1308&q=80",
                "https://images.unsplash.com/photo-1659991689791-db84493f8544?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1286&q=80",
              ],
            ),
          ],
        ),
      ),
    );
  }
}
