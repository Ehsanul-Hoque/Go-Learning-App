import "package:app/app_config/app_state.dart";
import "package:app/pages/home/landing.dart";
import "package:flutter/widgets.dart";
import "package:flutter_platform_widgets/flutter_platform_widgets.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      title: AppState().strings.appName,
      home: const LandingPage(),
    );
  }
}
