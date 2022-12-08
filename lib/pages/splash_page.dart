import "dart:async";

import "package:app/app_config/resources.dart";
import "package:app/components/app_circular_progress.dart";
import "package:app/routes.dart";
import "package:flutter/widgets.dart";
import "package:flutter_platform_widgets/flutter_platform_widgets.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:package_info_plus/package_info_plus.dart";

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late Future<String> appVersionStringFuture;

  @override
  void initState() {
    super.initState();

    appVersionStringFuture = getAppVersionString();
    Timer(
      const Duration(seconds: 1),
      () => Routes(config: const RoutesConfig(replace: true))
          .openLandingPage(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: Res.color.pageBg,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Center(
              child: SvgPicture.asset(
                Res.assets.logoSvg,
                width: 200,
                height: 95.5,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              bottom: Res.dimen.normalSpacingValue,
              child: getBottomContents(),
            ),
          ],
        ),
      ),
    );
  }

  Widget getBottomContents() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const AppCircularProgress(),
        SizedBox(
          height: Res.dimen.normalSpacingValue,
        ),
        FutureBuilder<String>(
          future: appVersionStringFuture,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return Text(
              "${Res.str.appVersionWithColon} ${snapshot.data ?? "-"}",
              style: Res.textStyles.general,
            );
          },
        ),
      ],
    );
  }

  Future<String> getAppVersionString() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}
