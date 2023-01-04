import "package:app/components/app_video_player/config/app_video_player_config.dart";
import "package:app/network/models/api_coupons/coupon_get_response.dart";
import "package:app/network/models/api_courses/course_get_response.dart";
import "package:app/pages/app_webview.dart";
import "package:app/pages/course/course_before_enroll.dart";
import "package:app/pages/course/course_checkout.dart";
import "package:app/pages/course/notifiers/course_content_notifier.dart";
import "package:app/pages/course/workers/content_worker.dart";
import "package:app/pages/home/landing.dart";
import "package:app/pages/pdf_viewer/app_pdf_viewer.dart";
import "package:app/pages/profile/user_profile.dart";
import "package:app/pages/splash_page.dart";
import "package:app/components/app_video_player/app_fullscreen_player.dart";
import "package:app/pages/welcome/auth.dart";
import "package:app/utils/typedefs.dart";
import "package:flutter/material.dart" show MaterialPageRoute;
import "package:flutter/widgets.dart";
import "package:provider/provider.dart";
import "package:provider/single_child_widget.dart";

class Routes {
  Routes({this.config = const RoutesConfig()});

  final RoutesConfig config;

  /// Route method to open the authentication page
  Future<void> openSplashPage(BuildContext context) =>
      RoutesHelper._removeAllAndTo<void>(
        context,
        (BuildContext context) => const SplashPage(),
      );

  /// Route method to open the authentication page
  Future<void> openAuthPage(
    BuildContext context, {
    OnValueListener<BuildContext>? redirectOnSuccess,
  }) =>
      RoutesHelper._toOrReplace<void>(
        context,
        (BuildContext context) =>
            AuthPage(redirectOnSuccess: redirectOnSuccess),
        replace: config.replace,
      );

  /// Route method to open the landing page (first page after login)
  Future<void> openLandingPage(BuildContext context) =>
      RoutesHelper._toOrReplace<void>(
        context,
        (BuildContext context) => const LandingPage(),
        replace: config.replace,
      );

  /// Route method to open the course page before enrolling to that course
  Future<void> openCourseBeforeEnrollPage(
    BuildContext context,
    CourseGetResponse course,
  ) =>
      RoutesHelper._toOrReplace<void>(
        context,
        (BuildContext context) => MultiProvider(
          providers: <SingleChildWidget>[
            CourseContentNotifier.createProvider(),
          ],
          child: CourseBeforeEnroll(course: course),
        ),
        replace: config.replace,
      );

  /// Route method to open the course checkout page
  Future<void> openCourseCheckoutPage(
    BuildContext context,
    CourseGetResponse course,
    CouponGetResponseData? appliedCoupon,
    double finalPrice,
  ) =>
      RoutesHelper._toOrReplace<void>(
        context,
        (BuildContext context) => CourseCheckout(
          course: course,
          appliedCoupon: appliedCoupon,
          finalPrice: finalPrice,
        ),
        replace: config.replace,
      );

  /// Route method to open the user profile page
  Future<void> openUserProfilePage(BuildContext context) =>
      RoutesHelper._toOrReplace<void>(
        context,
        (BuildContext context) => const UserProfile(),
        replace: config.replace,
      );

  /// Route method to open the fullscreen video page.
  /// Either 'url' (of the video) or 'contentWorker'
  /// (which can fetch the url of the video) is needed.
  /// If both are given, then 'url' is used.
  Future<void> openVideoPage({
    required BuildContext context,
    required AppVideoPlayerConfig videoConfig,
    String? url,
    ContentWorker<String>? contentWorker,
    VoidCallback? onEnterFullScreen,
    VoidCallback? onExitFullScreen,
  }) =>
      RoutesHelper._toOrReplace<void>(
        context,
        (BuildContext context) => AppFullScreenPlayer(
          config: videoConfig,
          url: url,
          contentWorker: contentWorker,
          onEnterFullScreen: onEnterFullScreen,
          onExitFullScreen: onExitFullScreen,
        ),
        replace: config.replace,
      );

  /// Route method to open the pdf view page.
  /// Either 'url' (of the pdf) or 'contentWorker'
  /// (which can fetch the url of the pdf) is needed.
  /// If both are given, then 'url' is used.
  Future<void> openPdfViewerPage({
    required BuildContext context,
    String? url,
    ContentWorker<String>? contentWorker,
  }) =>
      RoutesHelper._toOrReplace<void>(
        context,
        (BuildContext context) => AppPdfViewer(
          url: url,
          contentWorker: contentWorker,
        ),
        replace: config.replace,
      );

  /// Route method to open the web view page
  Future<void> openWebViewPage(BuildContext context, String? url) {
    return RoutesHelper._toOrReplace<void>(
      context,
      (BuildContext context) =>
          AppWebView(url: url ?? "https://www.golearningbd.com"),
      replace: config.replace,
    );
    // TODO Extract the golearningbd site url as constant
  }

  /// Route method to close the current page if possible
  static Future<bool> goBack<T>(BuildContext context, {T? result}) =>
      RoutesHelper._back(context, result: result);

  /// Route method to close all pages except the first page
  static void goHome(BuildContext context) =>
      RoutesHelper._backToFirst(context);
}

/// Routes config class
class RoutesConfig {
  const RoutesConfig({
    this.replace = false,
  });

  final bool replace;
}

// Private static methods for as helpers
class RoutesHelper {
  static Future<T?> _to<T>(
    BuildContext context,
    Widget Function(BuildContext context) page,
  ) {
    return Navigator.push(
      context,
      MaterialPageRoute<T>(
        builder: (BuildContext context) => page(context),
      ),
    );
  }

  static Future<T?> _replace<T>(
    BuildContext context,
    Widget Function(BuildContext context) page,
  ) {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute<T>(
        builder: (BuildContext context) => page(context),
      ),
    );
  }

  static Future<T?> _removeAllAndTo<T>(
    BuildContext context,
    Widget Function(BuildContext context) page,
  ) {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute<T>(
        builder: (BuildContext context) => page(context),
      ),
      (Route<dynamic> route) => false,
    );
  }

  static Future<T?> _toOrReplace<T>(
    BuildContext context,
    Widget Function(BuildContext context) page, {
    required bool replace,
  }) =>
      replace ? _replace(context, page) : _to(context, page);

  static Future<bool> _back<T>(BuildContext context, {T? result}) {
    return Navigator.of(context).maybePop(result);
  }

  static void _backToFirst(BuildContext context) {
    Navigator.popUntil(
      context,
      (Route<dynamic> route) => route.isFirst,
    );
  }
}
