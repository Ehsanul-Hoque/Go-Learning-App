import "package:app/app_config/resources.dart";
import "package:app/components/app_loading_anim.dart";
import "package:app/components/status_text.dart";
import "package:app/components/status_text_widget.dart";
import "package:app/local_storage/boxes/userbox.dart";
import "package:app/local_storage/notifiers/user_notifier.dart";
import "package:app/network/enums/network_call_status.dart";
import "package:app/network/models/api_auth/profile_get_response.dart";
import "package:app/network/notifiers/auth_api_notifier.dart";
import "package:app/routes.dart";
import "package:flutter/gestures.dart";
import "package:flutter/widgets.dart";
import "package:provider/provider.dart";
import "package:sliver_tools/sliver_tools.dart";

typedef SelectFunction = NetworkCallStatus Function(BuildContext context);
typedef NoContentFunction = bool Function(ProfileGetResponseData profileData);
typedef SuccessChildBuilder = Widget Function(
  BuildContext context,
  ProfileGetResponseData profileData,
);

class UserBoxNetworkWidget extends StatelessWidget {
  final SuccessChildBuilder childBuilder;
  final SelectFunction callStatusSelector;
  final Widget? statusNoneWidget,
      statusNoInternetWidget,
      statusLoadingWidget,
      statusCancelledWidget,
      statusFailedWidget,
      noContentWidget;
  final String? statusNoneText,
      statusNoInternetText,
      statusCancelledText,
      statusFailedText,
      noContentText;
  final NoContentFunction? noContentChecker;
  final bool shouldOutputBeSliver,
      showPromptIfNotAuthenticated,
      showGuestIfStatusNone,
      showGuestWhileLoading,
      showGuestIfNoInternet,
      showGuestIfCancelled,
      showGuestIfFailed;

  const UserBoxNetworkWidget({
    Key? key,
    required this.callStatusSelector,
    required this.childBuilder,
    this.statusNoneWidget,
    this.statusNoInternetWidget,
    this.statusLoadingWidget,
    this.statusCancelledWidget,
    this.statusFailedWidget,
    this.noContentWidget,
    this.statusNoneText,
    this.statusNoInternetText,
    this.statusCancelledText,
    this.statusFailedText,
    this.noContentText,
    this.noContentChecker,
    this.shouldOutputBeSliver = false,
    this.showPromptIfNotAuthenticated = true,
    this.showGuestIfStatusNone = false,
    this.showGuestWhileLoading = false,
    this.showGuestIfNoInternet = false,
    this.showGuestIfCancelled = false,
    this.showGuestIfFailed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        ProfileGetResponseData? profileData = context.select(
          (UserNotifier? userNotifier) => userNotifier?.currentUser,
        );

        NetworkCallStatus authResponseCallStatus =
            context.select((AuthApiNotifier? apiNotifier) {
          return apiNotifier?.authResponse.callStatus ?? NetworkCallStatus.none;
        });

        NetworkCallStatus otherCallStatus = callStatusSelector(context);

        Widget? widget;

        if (!UserBox.isLoggedIn) {
          if (showPromptIfNotAuthenticated) {
            widget = StatusTextWidget(
              child: Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: "${Res.str.youAreInGuestMood} ${Res.str.please} ",
                    ),
                    TextSpan(
                      text: Res.str.logIn,
                      style: TextStyle(
                        color: Res.color.textLink,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: onAuthTapGesture(context),
                    ),
                    TextSpan(text: " ${Res.str.or} "),
                    TextSpan(
                      text: Res.str.signUp,
                      style: TextStyle(
                        color: Res.color.textLink,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: onAuthTapGesture(context),
                    ),
                    TextSpan(text: " ${Res.str.firstFullStop}"),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
        } else {
          // else if (profileData == null || profileData.isGuest) {
          NetworkCallStatus combinedCallStatus =
              NetworkCallStatus.combineInParallel(<NetworkCallStatus>[
            authResponseCallStatus,
            otherCallStatus,
          ]);

          switch (combinedCallStatus) {
            case NetworkCallStatus.none:
              if (!showGuestIfStatusNone) {
                widget = statusNoneWidget ??
                    StatusText(statusNoneText ?? Res.str.startNetworkCall);
              }
              break;

            case NetworkCallStatus.noInternet:
              if (!showGuestIfNoInternet) {
                widget = statusNoInternetWidget ??
                    StatusText(statusNoInternetText ?? Res.str.noInternet);
              }
              break;

            case NetworkCallStatus.loading:
              if (!showGuestWhileLoading) {
                widget = statusLoadingWidget ?? const AppLoadingAnim();
              }
              break;

            case NetworkCallStatus.cancelled:
              if (!showGuestIfCancelled) {
                widget = statusCancelledWidget ??
                    StatusText(
                      statusCancelledText ?? Res.str.networkCallCancelled,
                    );
              }
              break;

            case NetworkCallStatus.failed:
              if (!showGuestIfFailed) {
                widget = statusFailedWidget ??
                    StatusText(statusFailedText ?? Res.str.generalError);
              }
              break;

            case NetworkCallStatus.success:
              break;
          }

          // } else {

          if (widget == null) {
            if (profileData == null) {
              widget = statusFailedWidget ??
                  StatusText(statusFailedText ?? Res.str.generalError);
            } else if (noContentChecker != null &&
                noContentChecker!(profileData) == true) {
              widget = noContentWidget ??
                  StatusText(noContentText ?? Res.str.noContents);
            } else {
              widget = childBuilder(context, profileData);
            }
          }
        }

        widget = AnimatedSize(
          duration: Res.durations.defaultDuration,
          curve: Res.curves.defaultCurve,
          alignment: Alignment.topCenter,
          child: widget,
        );

        if (shouldOutputBeSliver) {
          widget = SliverToBoxAdapter(
            child: widget,
          );
        }

        return AnimatedSwitcher(
          duration: Res.durations.longDuration,
          switchInCurve: Res.curves.defaultCurve,
          switchOutCurve: Res.curves.defaultCurve,
          transitionBuilder: shouldOutputBeSliver
              ? SliverAnimatedSwitcher.defaultTransitionBuilder
              : AnimatedSwitcher.defaultTransitionBuilder,
          layoutBuilder: shouldOutputBeSliver
              ? SliverAnimatedSwitcher.defaultLayoutBuilder
              : AnimatedSwitcher.defaultLayoutBuilder,
          child: widget,
        );
      },
    );
  }

  GestureRecognizer? onAuthTapGesture(BuildContext context) {
    TapGestureRecognizer tapGestureRecognizer = TapGestureRecognizer();

    tapGestureRecognizer.onTap = () {
      if (!UserBox.isLoggedIn) {
        Routes().openAuthPage(context: context);
      } else {
        // TODO show snack bar that the user is already authenticated
      }
    };

    return tapGestureRecognizer;
  }
}
