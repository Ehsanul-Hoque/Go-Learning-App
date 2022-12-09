import "package:app/components/app_video_player/notifiers/video_notifier.dart";
import "package:app/network/models/api_courses/course_get_response.dart";
import "package:app/pages/app_webview.dart";
import "package:app/pages/course/course_before_enroll.dart";
import "package:app/pages/course/course_checkout.dart";
import "package:app/pages/course/notifiers/course_content_notifier.dart";
import "package:app/pages/home/landing.dart";
import "package:app/pages/profile/user_profile.dart";
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
            VideoNotifier.createProvider(initialVideoUrl: course.preview ?? ""),
          ],
          child: CourseBeforeEnroll(course: course),
        ),
        replace: config.replace,
      );

  /// Route method to open the course checkout page
  Future<void> openCourseCheckoutPage(
    BuildContext context,
    CourseGetResponse course,
    double finalPrice,
  ) =>
      RoutesHelper._toOrReplace<void>(
        context,
        (BuildContext context) =>
            CourseCheckout(course: course, finalPrice: finalPrice),
        replace: config.replace,
      );

  /// Route method to open the user profile page
  Future<void> openUserProfilePage(BuildContext context) =>
      RoutesHelper._toOrReplace<void>(
        context,
        (BuildContext context) => const UserProfile(),
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

  static Future<T?> _toOrReplace<T>(
    BuildContext context,
    Widget Function(BuildContext context) page, {
    required bool replace,
  }) =>
      replace ? _replace(context, page) : _to(context, page);

  static Future<bool> _back<T>(BuildContext context, {T? result}) {
    return Navigator.of(context).maybePop(result);
  }
}
