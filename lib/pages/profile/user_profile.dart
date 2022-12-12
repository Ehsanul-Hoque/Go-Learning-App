import "package:app/app_config/resources.dart";
import "package:app/components/app_bar/my_app_bar_config.dart";
import "package:app/components/app_bar/my_platform_app_bar.dart";
import "package:app/components/app_button.dart";
import "package:app/components/app_divider.dart";
import "package:app/components/fields/app_form_field.dart";
import "package:app/components/fields/app_input_field.dart";
import "package:app/components/my_circle_avatar.dart";
import "package:app/components/userbox_widget.dart";
import "package:app/network/models/api_auth/profile_get_response.dart";
import "package:app/network/notifiers/auth_api_notifier.dart";
import "package:app/routes.dart";
import "package:flutter/material.dart" show IconButton, Icons;
import "package:flutter/widgets.dart";
import "package:flutter_platform_widgets/flutter_platform_widgets.dart";
import "package:provider/provider.dart" show ReadContext;

part "package:app/pages/profile/edit_profile_form_part.dart";

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _nameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _phoneTextController;
  late TextEditingController _addressTextController;
  late TextEditingController _institutionNameTextController;
  late TextEditingController _currentClassTextController;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _nameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _phoneTextController = TextEditingController();
    _addressTextController = TextEditingController();
    _institutionNameTextController = TextEditingController();
    _currentClassTextController = TextEditingController();

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Execute callback if page is mounted
      if (!mounted) return;

      context.read<AuthApiNotifier?>()?.getProfile();
    });
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _emailTextController.dispose();
    _phoneTextController.dispose();
    _addressTextController.dispose();
    _institutionNameTextController.dispose();
    _currentClassTextController.dispose();

    super.dispose();
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
                    if (_nameTextController.text.isEmpty) {
                      _nameTextController.text = profileData.name ?? "";
                    }

                    if (_emailTextController.text.isEmpty) {
                      _emailTextController.text = profileData.email ?? "";
                    }

                    if (_phoneTextController.text.isEmpty) {
                      _phoneTextController.text = profileData.phone ?? "";
                    }

                    if (_addressTextController.text.isEmpty) {
                      _addressTextController.text = profileData.address ?? "";
                    }

                    if (_institutionNameTextController.text.isEmpty) {
                      _institutionNameTextController.text =
                          profileData.institution ?? "";
                    }

                    if (_currentClassTextController.text.isEmpty) {
                      _currentClassTextController.text =
                          profileData.selectedClass ?? "";
                    }

                    return Column(
                      children: <Widget>[
                        SizedBox(
                          height: Res.dimen.normalSpacingValue,
                        ),
                        MyCircleAvatar(
                          imageUrl: profileData.photo,
                          radius: Res.dimen.drawerAvatarRadius,
                          padding: 1,
                          backgroundColor: Res.color.drawerAvatarBg,
                          shadow: const <BoxShadow>[],
                        ),
                        SizedBox(
                          height: Res.dimen.normalSpacingValue,
                        ),
                        EditProfileFormPart(
                          formKey: _formKey,
                          nameTextController: _nameTextController,
                          emailTextController: _emailTextController,
                          phoneTextController: _phoneTextController,
                          addressTextController: _addressTextController,
                          institutionNameTextController:
                              _institutionNameTextController,
                          currentClassTextController:
                              _currentClassTextController,
                          formFieldsEnabled: !profileData.isGuest,
                        ),
                        if (!profileData.isGuest) ...<Widget>[
                          SizedBox(
                            height: Res.dimen.normalSpacingValue,
                          ),
                          AppButton(
                            text: Text(
                              Res.str.submit,
                            ),
                            onTap: onUpdateTap,
                            borderRadius:
                                Res.dimen.fullRoundedBorderRadiusValue,
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

  String? onNameValidation(String? value) {
    if (value == null || value.isEmpty) {
      return Res.str.enterName;
    } else if (value.length < 5) {
      return Res.str.nameTooSmall;
    } else if (value.length >= 20) {
      return Res.str.nameTooBig;
    }

    return null;
  }

  String? onPhoneValidation(String? value) {
    if (value == null || value.isEmpty) {
      return Res.str.enterPhoneNumber;
    } else if (value.length != 11) {
      return Res.str.invalidPhoneNumber;
    }

    return null;
  }

  String? onFieldNotEmptyValidation(String? value, String errorIfEmpty) {
    if ((value == null) || value.isEmpty) {
      return errorIfEmpty;
    }

    return null;
  }

  void onUpdateTap() {
    if (_formKey.currentState?.validate() != true) return;

    _formKey.currentState?.save();
    // TODO update profile
    /*AuthApiNotifier authNotifier = context.read<AuthApiNotifier>();

    if (isCurrentPageLogInPage) {
      authNotifier.signInWithEmailPassword(
        context,
        SignInPostRequest(
          email: _emailTextController.text.trim(),
          password: _passwordTextController.text,
        ),
      );
    } else {
      authNotifier.signUpWithEmailPassword(
        context,
        SignUpPostRequest(
          name: _nameTextController.text.trim(),
          email: _emailTextController.text.trim(),
          password: _passwordTextController.text,
        ),
      );
    }*/
  }
}
