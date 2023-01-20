import "package:app/app_config/resources.dart";
import "package:app/components/animated_size_container.dart";
import "package:app/components/app_button.dart";
import "package:app/components/app_circular_progress.dart";
import "package:app/components/fields/app_form_field.dart";
import "package:app/components/fields/app_input_field.dart";
import "package:app/components/floating_messages/app_snack_bar_content/app_snack_bar_content.dart";
import "package:app/components/floating_messages/enums/floating_messages_content_type.dart";
import "package:app/components/tab_bar/views/app_tab_bar.dart";
import "package:app/components/app_container.dart";
import "package:app/local_storage/boxes/userbox.dart";
import "package:app/local_storage/notifiers/user_notifier.dart";
import "package:app/models/page_model.dart";
import "package:app/network/enums/network_call_status.dart";
import "package:app/network/models/api_auth/sign_in_post_request.dart";
import "package:app/network/models/api_auth/sign_up_post_request.dart";
import "package:app/network/network_error.dart";
import "package:app/network/network_response.dart";
import "package:app/network/notifiers/auth_api_notifier.dart";
import "package:app/network/notifiers/order_api_notifier.dart";
import "package:app/network/views/network_widget_light.dart";
import "package:app/routes.dart";
import "package:app/utils/extensions/context_extension.dart";
import "package:app/utils/typedefs.dart";
import "package:email_validator/email_validator.dart";
import "package:flutter/material.dart"
    show DefaultTabController, IconButton, Icons, Tab;
import "package:flutter/widgets.dart";
import "package:flutter_platform_widgets/flutter_platform_widgets.dart";
import "package:provider/provider.dart";

class AuthPage extends StatefulWidget {
  final OnValueListener<BuildContext>? redirectOnSuccess;

  const AuthPage({
    Key? key,
    this.redirectOnSuccess,
  }) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  static const String _isLogInPageKey = "isLogInPage";
  late final List<PageModel> _pageModels;
  late GlobalKey<FormState> _formKey;
  late TextEditingController _nameTextController;
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
    _nameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _confirmPasswordTextController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _confirmPasswordTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return context.read<AuthApiNotifier>().authResponse.callStatus !=
            NetworkCallStatus.loading;
      },
      child: PlatformScaffold(
        backgroundColor: Res.color.pageBg,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: AppContainer(
                // backgroundColor: Res.color.pageBg,
                margin: EdgeInsets.all(Res.dimen.largeSpacingValue),
                padding: EdgeInsets.all(Res.dimen.largeSpacingValue),
                shadow: <BoxShadow>[Res.shadows.lighter],
                border: Border.all(color: Res.color.containerBorder),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.height,
                ),
                child: DefaultTabController(
                  animationDuration: Res.durations.defaultDuration,
                  length: _pageModels.length,
                  child: Form(
                    key: _formKey,
                    child: getFormContentsOrLoading(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getFormContentsOrLoading() {
    return NetworkWidgetLight(
      callStatusSelector: (BuildContext context) {
        return context.select(
          (AuthApiNotifier? apiNotifier) =>
              apiNotifier?.authResponse.callStatus ?? NetworkCallStatus.none,
        );
      },
      onStatusNoInternet: onStatusNoInternet,
      onStatusCancelled: onStatusCancelled,
      onStatusFailed: onStatusFailed,
      onStatusSuccess: onStatusSuccess,
      childBuilder: (BuildContext context, NetworkCallStatus callStatus) {
        Widget resultWidget;

        if (callStatus == NetworkCallStatus.loading) {
          resultWidget = const AppCircularProgress();
        } else {
          resultWidget = Column(
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
              AnimatedSizeContainer(
                animateForward: !isCurrentPageLogInPage,
                animateOnInit: true,
                axisAlignment: 1,
                axis: Axis.vertical,
                child: AppFormField(
                  appInputField: AppInputField(
                    textEditingController: _nameTextController,
                    label: Res.str.fullName,
                    textInputType: TextInputType.name,
                    maxLength: 20,
                    goNextOnComplete: true,
                    borderRadius: Res.dimen.defaultBorderRadiusValue,
                    validator: onNameValidation,
                  ),
                ),
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
                  maxLength: 20,
                  obscureText: _hidePassword,
                  goNextOnComplete: isCurrentPageLogInPage ? false : true,
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
                    textEditingController: _confirmPasswordTextController,
                    label: Res.str.confirmPassword,
                    textInputType: TextInputType.visiblePassword,
                    maxLength: 20,
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
                  isCurrentPageLogInPage ? Res.str.logIn : Res.str.signUp,
                ),
                onTap: onSubmitTap,
                borderRadius: Res.dimen.fullRoundedBorderRadiusValue,
              ),
              /*SizedBox(
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
              ),*/
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
                  GestureDetector(
                    onTap: onPrivacyPolicyTap,
                    child: Text(
                      "${Res.str.privacyPolicy} ${Res.str.and}"
                      " ${Res.str.termsOfUse}",
                      style: Res.textStyles.link,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          );
        }

        resultWidget = AnimatedSize(
          duration: Res.durations.defaultDuration,
          curve: Res.curves.defaultCurve,
          child: AnimatedSwitcher(
            duration: Res.durations.defaultDuration,
            switchInCurve: Res.curves.defaultCurve,
            switchOutCurve: Res.curves.defaultCurve,
            child: resultWidget,
          ),
        );

        return resultWidget;
      },
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

  String? onNameValidation(String? value) {
    if (isCurrentPageLogInPage) return null;

    String name = _nameTextController.text.trim();

    if (name.isEmpty) {
      return Res.str.enterName;
    } else if (name.length < 5) {
      return Res.str.nameTooSmall;
    } else if (name.length > 20) {
      return Res.str.nameTooBig;
    }

    return null;
  }

  String? onEmailValidation(String? value) {
    return EmailValidator.validate(value?.trim() ?? "")
        ? null
        : Res.str.invalidEmail;
  }

  String? onPasswordValidation(String? value) {
    String password = _passwordTextController.text;

    if (password.isEmpty) {
      return Res.str.enterPassword;
    } else if (password.length < 5) {
      return Res.str.passwordTooSmall;
    } else if (password.length > 20) {
      return Res.str.passwordTooBig;
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
    if (isCurrentPageLogInPage) return null;

    String password = _passwordTextController.text;
    String confirmPassword = _confirmPasswordTextController.text;
    if (password != confirmPassword) {
      return Res.str.passwordsNotMatched;
    }

    return null;
  }

  void onSubmitTap() {
    if (handleIfAlreadyAuthenticated()) return;
    if (_formKey.currentState?.validate() != true) return;

    _formKey.currentState?.save();
    AuthApiNotifier authNotifier = context.read<AuthApiNotifier>();

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
    }
  }

  void onGoogleLogInTap() {
    if (handleIfAlreadyAuthenticated()) return;
    context.read<AuthApiNotifier>().signInWithGoogle(context);
  }

  void onPrivacyPolicyTap() {
    Routes().openWebViewPage(
      context: context,
      url: "https://golearningbd.com/privacy-policy",
    );
  }

  bool handleIfAlreadyAuthenticated() {
    if (!UserBox.isLoggedIn) return false;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Execute callback if page is mounted
      if (!mounted) return;

      context.showSnackBar(
        AppSnackBarContent(
          title: Res.str.authenticatedTitle,
          message: Res.str.authenticatedMessage,
          contentType: ContentType.help,
        ),
      );
    });

    return true;
  }

  void onStatusNoInternet() {
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

    context.read<UserNotifier>().logOut(resetNetworkCalls: false);
  }

  void onStatusCancelled() {
    context.read<UserNotifier>().logOut(resetNetworkCalls: false);
  }

  void onStatusFailed() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Execute callback if page is mounted
      if (!mounted) return;

      NetworkResponse<Object> authResponse =
          context.read<AuthApiNotifier>().authResponse;
      NetworkError? error = authResponse.error;

      context.showSnackBar(
        AppSnackBarContent(
          title: error?.title ?? Res.str.errorTitle,
          message: error?.message ??
              (isCurrentPageLogInPage
                  ? Res.str.errorLogIn
                  : Res.str.errorSignUp),
          contentType: ContentType.failure,
        ),
      );
    });

    context.read<UserNotifier>().logOut(resetNetworkCalls: false);
  }

  void onStatusSuccess() {
    if (!UserBox.hasProfileInfo) {
      onStatusFailed();
      return;
    }

    loadNecessaryInfo();

    Future<void>.delayed(
      const Duration(milliseconds: 200),
      () {
        OnValueListener<BuildContext>? redirectOnSuccess =
            widget.redirectOnSuccess;

        if (redirectOnSuccess != null) {
          redirectOnSuccess.call(context);
        } else {
          Routes.goBack(context: context);
        }
      },
    );
  }

  void loadNecessaryInfo() {
    context.read<OrderApiNotifier>().getAllOrders();
  }
}
