import "package:app/components/app_video_player/notifiers/video_notifier.dart";
import "package:app/network/models/api_courses/course_get_response.dart";
import "package:app/pages/app_webview.dart";
import "package:app/pages/course/course_before_enroll.dart";
import "package:app/pages/course/course_checkout.dart";
import "package:app/pages/course/notifiers/course_content_notifier.dart";
import "package:app/pages/home/landing.dart";
import "package:app/pages/welcome/auth.dart";
import "package:flutter/material.dart" show MaterialPageRoute;
import "package:flutter/widgets.dart";
import "package:provider/provider.dart";
import "package:provider/single_child_widget.dart";

class Routes {
  /// Route method to open the authentication page
  static Future<void> openAuthPage(
    BuildContext context, {
    bool closeAfterAuthDone = false,
  }) =>
      RoutesHelper._to<void>(
        context,
        (BuildContext context) =>
            AuthPage(closeAfterAuthDone: closeAfterAuthDone),
      );

  /// Route method to open the landing page (first page after login)
  static Future<void> openLandingPage(BuildContext context) =>
      RoutesHelper._to<void>(
        context,
        (BuildContext context) => const LandingPage(),
      );

  /// Route method to open the course page before enrolling to that course
  static Future<void> openCourseBeforeEnrollPage(
    BuildContext context,
    CourseGetResponse course,
  ) =>
      RoutesHelper._to<void>(
        context,
        (BuildContext context) => MultiProvider(
          providers: <SingleChildWidget>[
            CourseContentNotifier.createProvider(),
            VideoNotifier.createProvider(initialVideoUrl: course.preview ?? ""),
          ],
          child: CourseBeforeEnroll(course: course),
        ),
      );

  /// Route method to open the course checkout page
  static Future<void> openCourseCheckoutPage(
    BuildContext context,
    CourseGetResponse course,
    double finalPrice,
  ) =>
      RoutesHelper._replace<void>(
        context,
        (BuildContext context) =>
            CourseCheckout(course: course, finalPrice: finalPrice),
      );

  /// Route method to open the web view page
  static Future<void> openWebViewPage(BuildContext context, String? url) {
    return RoutesHelper._to<void>(
      context,
      (BuildContext context) =>
          AppWebView(url: url ?? "https://www.golearningbd.com"),
    );
    // TODO Extract the golearningbd site url as constant
  }

  /// Route method to close the current page if possible
  static Future<bool> goBack<T>(BuildContext context, {T? result}) =>
      RoutesHelper._back(context, result: result);
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

  static Future<bool> _back<T>(BuildContext context, {T? result}) {
    return Navigator.of(context).maybePop(result);
  }
}
