import "package:app/app_config/resources.dart";
import "package:app/components/animated_size_container.dart";
import "package:app/components/app_button.dart";
import "package:app/components/app_divider.dart";
import "package:app/components/fields/app_form_field.dart";
import "package:app/components/fields/app_input_field.dart";
import "package:app/components/tab_bar/views/app_tab_bar.dart";
import "package:app/components/app_container.dart";
import "package:app/models/page_model.dart";
import "package:app/pages/home/landing.dart";
import "package:app/utils/app_page_nav.dart";
import "package:email_validator/email_validator.dart";
import "package:flutter/material.dart"
    show DefaultTabController, IconButton, Icons, Tab;
import "package:flutter/widgets.dart";
import "package:flutter_platform_widgets/flutter_platform_widgets.dart";
import "package:flutter_svg/flutter_svg.dart";

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
        title: Res.str.logIn,
        configs: <String, bool>{
          _isLogInPageKey: true,
        },
      ),
      PageModel(
        title: Res.str.signUp,
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
      backgroundColor: Res.color.pageBg,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: AppContainer(
              margin: EdgeInsets.all(Res.dimen.largeSpacingValue),
              padding: EdgeInsets.all(Res.dimen.largeSpacingValue),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.height,
              ),
              child: DefaultTabController(
                animationDuration: Res.durations.defaultDuration,
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
                      SizedBox(
                        height: Res.dimen.largeSpacingValue,
                      ),
                      AppFormField(
                        appInputField: AppInputField(
                          textEditingController: _emailTextController,
                          label: Res.str.email,
                          textInputType: TextInputType.emailAddress,
                          goNextOnComplete: true,
                          borderRadius: Res.dimen.defaultBorderRadiusValue,
                          validator: onEmailValidation,
                        ),
                      ),
                      AppFormField(
                        appInputField: AppInputField(
                          textEditingController: _passwordTextController,
                          label: Res.str.password,
                          textInputType: TextInputType.visiblePassword,
                          obscureText: _hidePassword,
                          goNextOnComplete:
                              isCurrentPageLogInPage ? false : true,
                          borderRadius: Res.dimen.defaultBorderRadiusValue,
                          validator: onPasswordValidation,
                          suffixIcon: IconButton(
                            focusNode: FocusNode(skipTraversal: true),
                            onPressed: () {
                              setState(() {
                                _hidePassword = !_hidePassword;
                              });
                            },
                            icon: Icon(
                              _hidePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Res.color.secondaryIconButton,
                              size: Res.dimen.iconSizeNormal,
                            ),
                          ),
                        ),
                      ),
                      AnimatedSizeContainer(
                        animateForward: !isCurrentPageLogInPage,
                        animateOnInit: true,
                        axisAlignment: 1,
                        axis: Axis.vertical,
                        child: AppFormField(
                          appInputField: AppInputField(
                            textEditingController:
                                _confirmPasswordTextController,
                            label: Res.str.confirmPassword,
                            textInputType: TextInputType.visiblePassword,
                            obscureText: _hideConfirmPassword,
                            goNextOnComplete: false,
                            borderRadius: Res.dimen.defaultBorderRadiusValue,
                            validator: onConfirmPasswordValidation,
                            suffixIcon: IconButton(
                              focusNode: FocusNode(skipTraversal: true),
                              onPressed: () {
                                setState(() {
                                  _hideConfirmPassword = !_hideConfirmPassword;
                                });
                              },
                              icon: Icon(
                                _hideConfirmPassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Res.color.secondaryIconButton,
                                size: Res.dimen.iconSizeNormal,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Res.dimen.normalSpacingValue,
                      ),
                      AppButton(
                        text: Text(
                          isCurrentPageLogInPage
                              ? Res.str.logIn
                              : Res.str.signUp,
                        ),
                        onTap: onSubmitTap,
                        borderRadius: Res.dimen.fullRoundedBorderRadiusValue,
                      ),
                      SizedBox(
                        height: Res.dimen.normalSpacingValue,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: AppDivider(
                              margin: EdgeInsets.symmetric(
                                horizontal: Res.dimen.normalSpacingValue,
                              ),
                            ),
                          ),
                          Text(
                            Res.str.or,
                            style: Res.textStyles.ternary,
                          ),
                          Expanded(
                            child: AppDivider(
                              margin: EdgeInsets.symmetric(
                                horizontal: Res.dimen.normalSpacingValue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Res.dimen.normalSpacingValue,
                      ),
                      AppButton(
                        text: Text(Res.str.googleLogIn),
                        onTap: onGoogleLogInTap,
                        icon: SvgPicture.asset(
                          Res.assets.icGoogleSvg,
                          width: Res.dimen.iconSizeNormal,
                          height: Res.dimen.iconSizeNormal,
                        ),
                        backgroundColor: Res.color.buttonHollowBg,
                        contentColor: Res.color.buttonHollowContent,
                        tintIconWithContentColor: false,
                        borderRadius: Res.dimen.fullRoundedBorderRadiusValue,
                        border: Border.all(
                          color: Res.color.buttonHollowBorder,
                        ),
                      ),
                      SizedBox(
                        height: Res.dimen.hugeSpacingValue,
                      ),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: Res.dimen.xsSpacingValue,
                        runSpacing: Res.dimen.xsSpacingValue,
                        children: <Widget>[
                          Text(
                            Res.str.byContinuingYouAgreeTo,
                            style: Res.textStyles.secondary,
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              GestureDetector(
                                onTap: onPrivacyPolicyTap,
                                child: Text(
                                  Res.str.privacyPolicy,
                                  style: Res.textStyles.link,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Text(
                                " ${Res.str.and} ",
                                style: Res.textStyles.secondary,
                                textAlign: TextAlign.center,
                              ),
                              GestureDetector(
                                onTap: onTermsOfUseTap,
                                child: Text(
                                  Res.str.termsOfUse,
                                  style: Res.textStyles.link,
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
    return EmailValidator.validate(value ?? "") ? null : Res.str.invalidEmail;
  }

  String? onPasswordValidation(String? value) {
    String password = _passwordTextController.text;

    if (password.isEmpty) {
      return Res.str.enterPassword;
    } else if (password.length < 4) {
      return Res.str.passwordTooSmall;
    }

    if (!isCurrentPageLogInPage) {
      String confirmPassword = _confirmPasswordTextController.text;
      if (password != confirmPassword) {
        return Res.str.passwordsNotMatched;
      }
    }

    return null;
  }

  String? onConfirmPasswordValidation(String? value) {
    if (!isCurrentPageLogInPage) {
      String password = _passwordTextController.text;
      String confirmPassword = _confirmPasswordTextController.text;
      if (password != confirmPassword) {
        return Res.str.passwordsNotMatched;
      }
    }

    return null;
  }

  void onSubmitTap() {
    // TODO Uncomment validation when auth is properly implemented
    // if (_formKey.currentState?.validate() ?? false) {
    // _formKey.currentState?.save();

    PageNav.to(context, const LandingPage());
    // }
  }

  void onGoogleLogInTap() {
    // TODO Implement google log in
  }

  void onPrivacyPolicyTap() {
    // TODO Show privacy policy
  }

  void onTermsOfUseTap() {
    // TODO Show terms of use
  }
}
