import "package:app/app_config/app_state.dart";
import "package:app/components/advanced_custom_scroll_view/notifiers/acsv_scroll_notifier.dart";
import "package:app/components/app_video_player/config/app_video_player_config.dart";
import "package:app/components/countdown_timer/notifiers/countdown_timer_notifier.dart";
import "package:app/network/models/api_contents/content_tree_get_response.dart";
import "package:app/network/models/api_contents/quiz_attempt_get_response.dart";
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
import "package:app/pages/quiz/enums/quiz_state.dart";
import "package:app/pages/quiz/notifiers/quiz_notifier.dart";
import "package:app/pages/quiz/quiz.dart";
import "package:app/pages/quiz/quiz_intro.dart";
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
  Future<void> openSplashPage([BuildContext? context]) =>
      RoutesHelper._removeAllAndTo<void>(
        context: context,
        page: (BuildContext context) => const SplashPage(),
      );

  /// Route method to open the authentication page
  Future<void> openAuthPage({
    BuildContext? context,
    OnValueListener<BuildContext>? redirectOnSuccess,
  }) =>
      RoutesHelper._toOrReplace<void>(
        context: context,
        page: (BuildContext context) =>
            AuthPage(redirectOnSuccess: redirectOnSuccess),
        replace: config.replace,
      );

  /// Route method to open the landing page (first page after login)
  Future<void> openLandingPage([BuildContext? context]) =>
      RoutesHelper._toOrReplace<void>(
        context: context,
        page: (BuildContext context) => const LandingPage(),
        replace: config.replace,
      );

  /// Route method to open the course page before enrolling to that course
  Future<void> openCourseBeforeEnrollPage({
    BuildContext? context,
    required CourseGetResponse course,
  }) =>
      RoutesHelper._toOrReplace<void>(
        context: context,
        page: (BuildContext context) => MultiProvider(
          providers: <SingleChildWidget>[
            CourseContentNotifier.createProvider(),
          ],
          child: CourseBeforeEnroll(course: course),
        ),
        replace: config.replace,
      );

  /// Route method to open the course checkout page
  Future<void> openCourseCheckoutPage({
    BuildContext? context,
    required CourseGetResponse course,
    required CouponGetResponseData? appliedCoupon,
    required double finalPrice,
  }) =>
      RoutesHelper._toOrReplace<void>(
        context: context,
        page: (BuildContext context) => CourseCheckout(
          course: course,
          appliedCoupon: appliedCoupon,
          finalPrice: finalPrice,
        ),
        replace: config.replace,
      );

  /// Route method to open the user profile page
  Future<void> openUserProfilePage([BuildContext? context]) =>
      RoutesHelper._toOrReplace<void>(
        context: context,
        page: (BuildContext context) => const UserProfile(),
        replace: config.replace,
      );

  /// Route method to open the fullscreen video page.
  /// Either 'url' (of the video) or 'contentWorker'
  /// (which can fetch the url of the video) is needed.
  /// If both are given, then 'url' is used.
  Future<void> openVideoPage({
    BuildContext? context,
    required AppVideoPlayerConfig videoConfig,
    String? url,
    ContentWorker<String>? contentWorker,
    VoidCallback? onEnterFullScreen,
    VoidCallback? onExitFullScreen,
  }) =>
      RoutesHelper._toOrReplace<void>(
        context: context,
        page: (BuildContext context) => AppFullScreenPlayer(
          config: videoConfig,
          url: url,
          contentWorker: contentWorker,
          onEnterFullScreen: onEnterFullScreen,
          onExitFullScreen: onExitFullScreen,
        ),
        replace: config.replace,
      );

  /// Route method to open the quiz intro page
  Future<void> openQuizIntroPage({
    BuildContext? context,
    required CourseGetResponse course,
    required ContentWorker<QuizAttemptGetResponse> contentWorker,
  }) =>
      RoutesHelper._toOrReplace<void>(
        context: context,
        page: (BuildContext context) =>
            QuizIntro(course: course, contentWorker: contentWorker),
        replace: config.replace,
      );

  /// Route method to open the quiz page
  Future<void> openQuizPage({
    BuildContext? context,
    required ContentTreeGetResponseContents quizContent,
    required QuizAttemptGetResponse previousBestAttempt,
    CourseGetResponse? course,
    bool? showPreviousAttemptAtStart,
  }) {
    QuizAttemptGetResponseData? prevAttemptData = previousBestAttempt.data;
    showPreviousAttemptAtStart ??= (prevAttemptData != null);

    return RoutesHelper._toOrReplace<void>(
      context: context,
      page: (BuildContext context) {
        return MultiProvider(
          providers: <SingleChildWidget>[
            QuizNotifier.createProviderWithPrevAttempt(
              initialState: (showPreviousAttemptAtStart ?? true)
                  ? QuizState.previousAttempt
                  : QuizState.currentAttempt,
              quizContent: quizContent,
              prevAttemptData: prevAttemptData,
              course: course,
            ),
            CountdownTimerNotifier.createQuizNotifierProxyProvider(),
            AcsvScrollNotifier.createProvider(),
          ],
          child: Quiz(
            course: course,
            quizContent: quizContent,
            previousBestAttemptData: prevAttemptData,
            showPreviousAttemptAtStart: showPreviousAttemptAtStart ?? true,
          ),
        );
      },
      replace: config.replace,
    );
  }

  /// Route method to open the pdf view page.
  /// Either 'url' (of the pdf) or 'contentWorker'
  /// (which can fetch the url of the pdf) is needed.
  /// If both are given, then 'url' is used.
  Future<void> openPdfViewerPage({
    BuildContext? context,
    String? url,
    ContentWorker<String>? contentWorker,
  }) =>
      RoutesHelper._toOrReplace<void>(
        context: context,
        page: (BuildContext context) => AppPdfViewer(
          url: url,
          contentWorker: contentWorker,
        ),
        replace: config.replace,
      );

  /// Route method to open the web view page
  Future<void> openWebViewPage({BuildContext? context, required String? url}) {
    return RoutesHelper._toOrReplace<void>(
      context: context,
      page: (BuildContext context) =>
          AppWebView(url: url ?? "https://www.golearningbd.com"),
      replace: config.replace,
    );
    // TODO Extract the golearningbd site url as constant
  }

  /// Route method to close the current page if possible
  static Future<bool?> goBack<T>({BuildContext? context, T? result}) =>
      RoutesHelper._back(context: context, result: result);

  /// Route method to close all pages except the first page
  static void goHome([BuildContext? context]) =>
      RoutesHelper._backToFirst(context: context);
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
  static Future<T?> _to<T>({
    BuildContext? context,
    required Widget Function(BuildContext context) page,
  }) {
    context ??= AppState.navigatorKey.currentContext;
    if (context != null) {
      return Navigator.push(
        context,
        MaterialPageRoute<T>(
          builder: (BuildContext context) => page(context),
        ),
      );
    }

    return Future<T>.value(null);
  }

  static Future<T?> _replace<T>({
    BuildContext? context,
    required Widget Function(BuildContext context) page,
  }) {
    context ??= AppState.navigatorKey.currentContext;
    if (context != null) {
      return Navigator.pushReplacement(
        context,
        MaterialPageRoute<T>(
          builder: (BuildContext context) => page(context),
        ),
      );
    }

    return Future<T>.value(null);
  }

  static Future<T?> _removeAllAndTo<T>({
    BuildContext? context,
    required Widget Function(BuildContext context) page,
  }) {
    context ??= AppState.navigatorKey.currentContext;
    if (context != null) {
      return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<T>(
          builder: (BuildContext context) => page(context),
        ),
        (Route<dynamic> route) => false,
      );
    }

    return Future<T>.value(null);
  }

  static Future<T?> _toOrReplace<T>({
    BuildContext? context,
    required Widget Function(BuildContext context) page,
    required bool replace,
  }) {
    return replace
        ? _replace(context: context, page: page)
        : _to(context: context, page: page);
  }

  static Future<bool?> _back<T>({BuildContext? context, T? result}) {
    context ??= AppState.navigatorKey.currentContext;
    if (context != null) {
      return Navigator.of(context).maybePop(result);
    }

    return Future<bool?>.value(null);
  }

  static void _backToFirst({BuildContext? context}) {
    context ??= AppState.navigatorKey.currentContext;
    if (context != null) {
      Navigator.popUntil(
        context,
        (Route<dynamic> route) => route.isFirst,
      );
    }
  }
}
