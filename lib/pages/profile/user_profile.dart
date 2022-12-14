import "package:app/app_config/resources.dart";
import "package:app/components/app_bar/my_app_bar_config.dart";
import "package:app/components/app_bar/my_platform_app_bar.dart";
import "package:app/components/app_button.dart";
import "package:app/components/app_circular_progress.dart";
import "package:app/components/app_divider.dart";
import "package:app/components/fields/app_form_field.dart";
import "package:app/components/fields/app_input_field.dart";
import "package:app/components/floating_messages/app_snack_bar_content/app_snack_bar_content.dart";
import "package:app/components/floating_messages/enums/floating_messages_content_type.dart";
import "package:app/components/my_circle_avatar.dart";
import "package:app/components/userbox_widget.dart";
import "package:app/network/enums/network_call_status.dart";
import "package:app/network/models/api_auth/edit_profile_post_request.dart";
import "package:app/network/models/api_auth/profile_get_response.dart";
import "package:app/network/notifiers/auth_api_notifier.dart";
import "package:app/network/views/network_widget_light.dart";
import "package:app/routes.dart";
import "package:app/utils/extensions/context_extension.dart";
import "package:flutter/material.dart" show IconButton, Icons;
import "package:flutter/widgets.dart";
import "package:flutter_platform_widgets/flutter_platform_widgets.dart";
import "package:provider/provider.dart" show ReadContext, SelectContext;

part "package:app/pages/profile/edit_profile_form_part.dart";

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late GlobalKey<FormState> _formKey;
  late EditProfilePostRequest editInfo;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    editInfo = EditProfilePostRequest.blank();

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Execute callback if page is mounted
      if (!mounted) return;

      context.read<AuthApiNotifier?>()?.getProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: Res.color.pageBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            MyPlatformAppBar(
              config: MyAppBarConfig(
                backgroundColor: Res.color.appBarBgTransparent,
                shadow: const <BoxShadow>[],
                title: Text(Res.str.profile),
                startActions: <Widget>[
                  IconButton(
                    // TODO extract this back button as a component
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                    ),
                    iconSize: Res.dimen.iconSizeNormal,
                    color: Res.color.iconButton,
                    onPressed: () => Routes.goBack(context),
                  ),
                ],
                bottomBorder: AppDivider(
                  margin: EdgeInsets.symmetric(
                    horizontal: Res.dimen.normalSpacingValue,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(Res.dimen.normalSpacingValue),
                child: UserBoxWidget(
                  showGuestWhileLoading: false,
                  showGuestIfNoInternet: false,
                  showGuestIfFailed: false,
                  childBuilder: (
                    BuildContext context,
                    ProfileGetResponseData profileData,
                  ) {
                    return Column(
                      children: <Widget>[
                        SizedBox(
                          height: Res.dimen.normalSpacingValue,
                        ),
                        EditProfileFormPart(
                          formKey: _formKey,
                          profileData: profileData,
                          editInfo: editInfo,
                          // formFieldsEnabled: !profileData.isGuest,
                        ),
                        if (!profileData.isGuest) ...<Widget>[
                          SizedBox(
                            height: Res.dimen.normalSpacingValue,
                          ),
                          NetworkWidgetLight(
                            callStatusSelector: (BuildContext context) {
                              return context
                                  .select((AuthApiNotifier? apiNotifier) {
                                return apiNotifier
                                        ?.updateProfilePutResponse.callStatus ??
                                    NetworkCallStatus.none;
                              });
                            },
                            onStatusNoInternet: onUpdateStatusNoInternet,
                            onStatusFailed: onUpdateStatusFailed,
                            onStatusSuccess: onUpdateStatusSuccess,
                            childBuilder: (
                              BuildContext context,
                              NetworkCallStatus callStatus,
                            ) {
                              Widget resultWidget;

                              if (callStatus == NetworkCallStatus.loading) {
                                resultWidget = const AppCircularProgress();
                              } else {
                                resultWidget = AppButton(
                                  text: Text(Res.str.update),
                                  onTap: onUpdateTap,
                                  borderRadius:
                                      Res.dimen.fullRoundedBorderRadiusValue,
                                );
                              }

                              resultWidget = AnimatedSize(
                                duration: Res.durations.defaultDuration,
                                curve: Res.curves.defaultCurve,
                                clipBehavior: Clip.none,
                                child: AnimatedSwitcher(
                                  duration: Res.durations.defaultDuration,
                                  switchInCurve: Res.curves.defaultCurve,
                                  switchOutCurve: Res.curves.defaultCurve,
                                  child: resultWidget,
                                ),
                              );

                              return resultWidget;
                            },
                          ),
                        ],
                        SizedBox(
                          height: Res.dimen.hugeSpacingValue,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onUpdateTap() {
    if (_formKey.currentState?.validate() != true) return;
    _formKey.currentState?.save();

    AuthApiNotifier authNotifier = context.read<AuthApiNotifier>();
    authNotifier.updateProfile(editInfo);
  }

  void onUpdateStatusNoInternet() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Execute callback if page is mounted
      if (!mounted) return;

      context.showSnackBar(
        AppSnackBarContent(
          title: Res.str.noInternetTitle,
          message: Res.str.noInternetDescription,
          contentType: ContentType.help,
        ),
      );
    });
  }

  void onUpdateStatusFailed() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Execute callback if page is mounted
      if (!mounted) return;

      context.showSnackBar(
        AppSnackBarContent(
          title: Res.str.sorryTitle,
          message: Res.str.errorUpdatingProfile,
          contentType: ContentType.failure,
        ),
      );
    });
  }

  void onUpdateStatusSuccess() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Execute callback if page is mounted
      if (!mounted) return;

      context.showSnackBar(
        AppSnackBarContent(
          title: Res.str.yesTitle,
          message: Res.str.profileUpdatedSuccessfully,
          contentType: ContentType.success,
        ),
      );
    });
  }
}
