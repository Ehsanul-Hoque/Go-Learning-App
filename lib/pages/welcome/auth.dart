import "package:app/app_config/app_state.dart";
import "package:app/app_config/default_parameters.dart";
import "package:app/components/animated_size_container.dart";
import "package:app/components/app_button.dart";
import "package:app/components/app_divider.dart";
import "package:app/components/fields/app_form_field.dart";
import "package:app/components/fields/app_input_field.dart";
import "package:app/components/tab_bar/views/app_tab_bar.dart";
import "package:app/components/shadow_container.dart";
import "package:app/models/page_model.dart";
import "package:app/utils/app_colors.dart";
import "package:email_validator/email_validator.dart";
import "package:flutter/material.dart";
import "package:flutter_platform_widgets/flutter_platform_widgets.dart";
import "package:flutter_svg/svg.dart";

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  static const String _isLogInPageKey = "isLogInPage";
  late final List<PageModel> _pageModels;
  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  late TextEditingController _confirmPasswordTextController;
  int _selectedTabBarIndex = 0;
  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  @override
  void initState() {
    _pageModels = <PageModel>[
      PageModel(
        title: AppState.strings.logIn,
        configs: <String, bool>{
          _isLogInPageKey: true,
        },
      ),
      PageModel(
        title: AppState.strings.signUp,
        configs: <String, bool>{
          _isLogInPageKey: false,
        },
      ),
    ];

    _formKey = GlobalKey<FormState>();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _confirmPasswordTextController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _confirmPasswordTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: DefaultParameters.defaultPageBgColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: ShadowContainer(
              margin: DefaultParameters.defaultLargeInsetAll,
              padding: DefaultParameters.defaultLargeInsetAll,
              child: DefaultTabController(
                length: _pageModels.length,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Container(
                          constraints: const BoxConstraints(
                            maxWidth: 200,
                          ),
                          child: AppTabBar(
                            tabs: _pageModels.map((PageModel page) {
                              return Tab(
                                text: page.title,
                              );
                            }).toList(),
                            onTabChange: onTabChange,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: DefaultParameters.defaultLargeSpacingValue,
                      ),
                      AppFormField(
                        appInputField: AppInputField(
                          textEditingController: _emailTextController,
                          label: AppState.strings.email,
                          textInputType: TextInputType.emailAddress,
                          goNextOnComplete: true,
                          borderRadius:
                              DefaultParameters.defaultBorderRadiusValue,
                          validator: onEmailValidation,
                        ),
                      ),
                      AppFormField(
                        appInputField: AppInputField(
                          textEditingController: _passwordTextController,
                          label: AppState.strings.password,
                          textInputType: TextInputType.visiblePassword,
                          obscureText: _hidePassword,
                          goNextOnComplete: true,
                          borderRadius:
                              DefaultParameters.defaultBorderRadiusValue,
                          validator: onPasswordValidation,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _hidePassword = !_hidePassword;
                              });
                            },
                            icon: Icon(
                              _hidePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: DefaultParameters.secondaryIconButtonColor,
                              size: DefaultParameters.defaultIconSize,
                            ),
                          ),
                        ),
                      ),
                      AnimatedSizeContainer(
                        animateForward: !isCurrentPageLogInPage,
                        animateOnInit: false,
                        axisAlignment: 1,
                        axis: Axis.vertical,
                        child: AppFormField(
                          appInputField: AppInputField(
                            textEditingController:
                                _confirmPasswordTextController,
                            label: AppState.strings.confirmPassword,
                            textInputType: TextInputType.visiblePassword,
                            obscureText: _hideConfirmPassword,
                            goNextOnComplete: true,
                            borderRadius:
                                DefaultParameters.defaultBorderRadiusValue,
                            validator: onConfirmPasswordValidation,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _hideConfirmPassword = !_hideConfirmPassword;
                                });
                              },
                              icon: Icon(
                                _hideConfirmPassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color:
                                    DefaultParameters.secondaryIconButtonColor,
                                size: DefaultParameters.defaultIconSize,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: DefaultParameters.defaultNormalSpacingValue,
                      ),
                      AppButton(
                        text: isCurrentPageLogInPage
                            ? AppState.strings.logIn
                            : AppState.strings.signUp,
                        onTap: onSubmitTap,
                        borderRadius:
                            DefaultParameters.fullRoundedBorderRadiusValue,
                      ),
                      const SizedBox(
                        height: DefaultParameters.defaultNormalSpacingValue,
                      ),
                      Row(
                        children: <Widget>[
                          const Expanded(
                            child: AppDivider(
                              margin: EdgeInsets.symmetric(
                                horizontal:
                                    DefaultParameters.defaultNormalSpacingValue,
                              ),
                            ),
                          ),
                          Text(
                            AppState.strings.or,
                            style: DefaultParameters.defaultTextStyle.copyWith(
                              color: AppColors.grey400,
                            ),
                          ),
                          const Expanded(
                            child: AppDivider(
                              margin: EdgeInsets.symmetric(
                                horizontal:
                                    DefaultParameters.defaultNormalSpacingValue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: DefaultParameters.defaultNormalSpacingValue,
                      ),
                      AppButton(
                        text: AppState.strings.googleLogIn,
                        onTap: onGoogleLogInTap,
                        icon: SvgPicture.asset(
                          "assets/icons/ic_google.svg",
                          width: DefaultParameters.defaultIconSize,
                          height: DefaultParameters.defaultIconSize,
                        ),
                        tintIconWithContentColor: false,
                        borderRadius:
                            DefaultParameters.fullRoundedBorderRadiusValue,
                        border: Border.all(
                          color: AppColors.grey300,
                        ),
                      ),
                      const SizedBox(
                        height: DefaultParameters.defaultLargeSpacingValue * 2,
                      ),
                      Wrap(
                        alignment: WrapAlignment.center,
                        runSpacing:
                            DefaultParameters.defaultExtraSmallSpacingValue,
                        children: <Widget>[
                          Text(
                            AppState.strings.byContinuingYouAgreeTo,
                            style: DefaultParameters.secondaryTextStyle,
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              GestureDetector(
                                onTap: onPrivacyPolicyTap,
                                child: Text(
                                  AppState.strings.privacyPolicy,
                                  style: DefaultParameters.linkTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Text(
                                " ${AppState.strings.and} ",
                                style: DefaultParameters.secondaryTextStyle,
                                textAlign: TextAlign.center,
                              ),
                              GestureDetector(
                                onTap: onTermsOfUseTap,
                                child: Text(
                                  AppState.strings.termsOfUse,
                                  style: DefaultParameters.linkTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool get isCurrentPageLogInPage =>
      _pageModels[_selectedTabBarIndex].configs[_isLogInPageKey] == true;

  void onTabChange(int index) {
    FocusScope.of(context).unfocus();
    setState(() {
      _selectedTabBarIndex = index;
    });
  }

  String? onEmailValidation(String? value) {
    return EmailValidator.validate(value ?? "")
        ? null
        : AppState.strings.invalidEmail;
  }

  String? onPasswordValidation(String? value) {
    String password = _passwordTextController.text;

    if (password.isEmpty) {
      return AppState.strings.enterPassword;
    } else if (password.length < 4) {
      return AppState.strings.passwordTooSmall;
    }

    if (!isCurrentPageLogInPage) {
      String confirmPassword = _confirmPasswordTextController.text;
      if (password != confirmPassword) {
        return AppState.strings.passwordsNotMatched;
      }
    }

    return null;
  }

  String? onConfirmPasswordValidation(String? value) {
    if (!isCurrentPageLogInPage) {
      String password = _passwordTextController.text;
      String confirmPassword = _confirmPasswordTextController.text;
      if (password != confirmPassword) {
        return AppState.strings.passwordsNotMatched;
      }
    }

    return null;
  }

  void onSubmitTap() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
    }
  }

  void onGoogleLogInTap() {}

  void onPrivacyPolicyTap() {}

  void onTermsOfUseTap() {}
}
