import "package:app/app_config/resources.dart";
import "package:flutter/widgets.dart";
import "package:lottie/lottie.dart";

class AppLoadingAnim extends StatelessWidget {
  const AppLoadingAnim({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: Res.dimen.pageLoadingSize,
        height: Res.dimen.pageLoadingSize,
        // child: SvgPicture.asset(Res.assets.loadingSvg),
        child: Lottie.asset(Res.assets.loadingLottieJson),
      ),
    );
  }
}
