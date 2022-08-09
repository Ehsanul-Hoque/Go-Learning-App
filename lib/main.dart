import "package:app/app_config/resources.dart";
import "package:app/pages/welcome/auth.dart";
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
      debugShowCheckedModeBanner: false,
      title: Res.str.appName,
      home: const AuthPage(),
    );
  }
}
