import "package:app/app_config/resources.dart";
import "package:app/network/notifiers/course_api_notifier.dart";
import "package:app/network/notifiers/static_info_api_notifier.dart";
import "package:app/pages/app_error_screen.dart";
import "package:app/pages/welcome/auth.dart";
import "package:flutter/services.dart"
    show SystemChrome, SystemUiMode, SystemUiOverlay;
import "package:flutter/widgets.dart";
import "package:flutter_platform_widgets/flutter_platform_widgets.dart"
    show PlatformApp;
import "package:provider/provider.dart" show MultiProvider;
import "package:provider/single_child_widget.dart" show SingleChildWidget;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: SystemUiOverlay.values,
  );

  ErrorWidget.builder =
      (FlutterErrorDetails details) => AppErrorScreen(error: details.exception);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        StaticInfoApiNotifier.createProvider(),
        CourseApiNotifier.createProvider(),
      ],
      child: PlatformApp(
        debugShowCheckedModeBanner: false,
        title: Res.str.appName,
        home: const AuthPage(),
      ),
    );
  }
}
