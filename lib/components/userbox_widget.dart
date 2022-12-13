import "package:app/app_config/resources.dart";
import "package:app/components/app_loading_anim.dart";
import "package:app/components/status_text.dart";
import "package:app/local_storage/notifiers/user_notifier.dart";
import "package:app/network/enums/network_call_status.dart";
import "package:app/network/models/api_auth/profile_get_response.dart";
import "package:app/network/notifiers/auth_api_notifier.dart";
import "package:app/utils/user_utils.dart";
import "package:flutter/widgets.dart";
import "package:provider/provider.dart";
import "package:sliver_tools/sliver_tools.dart";

typedef SuccessChildBuilder = Widget Function(
  BuildContext context,
  ProfileGetResponseData profileData,
);

class UserBoxWidget extends StatelessWidget {
  final SuccessChildBuilder childBuilder;
  final Widget? statusNoneWidget,
      statusNoInternetWidget,
      statusLoadingWidget,
      statusFailedWidget;
  final bool shouldOutputBeSliver,
      showGuestWhileLoading,
      showGuestIfNoInternet,
      showGuestIfFailed;

  const UserBoxWidget({
    Key? key,
    required this.childBuilder,
    this.statusNoneWidget,
    this.statusNoInternetWidget,
    this.statusLoadingWidget,
    this.statusFailedWidget,
    this.shouldOutputBeSliver = false,
    this.showGuestWhileLoading = true,
    this.showGuestIfNoInternet = true,
    this.showGuestIfFailed = true,
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

        Widget? widget;

        if (profileData != null) {
          widget = childBuilder(context, profileData);
        } else {
          switch (authResponseCallStatus) {
            case NetworkCallStatus.noInternet:
              if (!showGuestIfNoInternet) {
                widget =
                    statusNoInternetWidget ?? StatusText(Res.str.noInternet);
              }
              break;

            case NetworkCallStatus.loading:
              if (!showGuestWhileLoading) {
                widget = statusLoadingWidget ?? const AppLoadingAnim();
              }
              break;

            case NetworkCallStatus.failed:
              if (!showGuestIfFailed) {
                widget = statusFailedWidget ??
                    StatusText(Res.str.errorLoadingProfile);
              }
              break;

            default:
              break;
          }
        }

        /*ProfileGetResponseData? profileDataNew =
            context.read<UserNotifier?>()?.currentUser;*/

        ProfileGetResponseData newProfileData =
            profileData ?? UserUtils.guestUser;

        widget ??= childBuilder(context, newProfileData);

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
}
