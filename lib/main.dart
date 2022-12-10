import "package:app/app_config/resources.dart";
import "package:app/local_storage/app_objectbox.dart";
import "package:app/local_storage/notifiers/user_notifier.dart";
import "package:app/network/notifiers/auth_api_notifier.dart";
import "package:app/network/notifiers/content_api_notifier.dart";
import "package:app/network/notifiers/coupon_api_notifier.dart";
import "package:app/network/notifiers/course_api_notifier.dart";
import "package:app/network/notifiers/static_info_api_notifier.dart";
import "package:app/pages/splash_page.dart";
import "package:flutter/services.dart"
    show SystemChrome, SystemUiMode, SystemUiOverlay;
import "package:flutter/widgets.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:flutter_platform_widgets/flutter_platform_widgets.dart"
    show PlatformApp;
import "package:provider/provider.dart" show MultiProvider;
import "package:provider/single_child_widget.dart" show SingleChildWidget;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: SystemUiOverlay.values,
  );

  /*ErrorWidget.builder =
      (FlutterErrorDetails details) => AppErrorScreen(error: details.exception);*/

  appObjectBox = await AppObjectBox.create();
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        UserNotifier.createProvider(),
        AuthApiNotifier.createProvider(),
        StaticInfoApiNotifier.createProvider(),
        CourseApiNotifier.createProvider(),
        ContentApiNotifier.createProvider(),
        CouponApiNotifier.createProvider(),
      ],
      child: PlatformApp(
        debugShowCheckedModeBanner: false,
        title: Res.str.appName,
        home: const SplashPage(),
      ),
    );
  }
}
