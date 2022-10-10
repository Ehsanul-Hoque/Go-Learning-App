import "package:app/app_config/resources.dart";
import "package:app/components/app_bar/my_app_bar_config.dart";
import "package:app/components/app_bar/my_platform_app_bar.dart";
import "package:app/components/app_button.dart";
import "package:app/components/app_snack_bar_content/app_snack_bar_content.dart";
import "package:app/components/app_snack_bar_content/enums/app_snack_bar_content_type.dart";
import "package:app/components/fields/app_form_field.dart";
import "package:app/components/fields/app_input_field.dart";
import "package:app/components/widget_checkbox.dart";
import "package:app/models/page_model.dart";
import "package:app/utils/app_page_nav.dart";
import "package:app/utils/extensions/context_extension.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart" show IconButton, Icons;
import "package:flutter/services.dart" show Clipboard, ClipboardData;
import "package:flutter/widgets.dart";
import "package:flutter_platform_widgets/flutter_platform_widgets.dart";

class CourseCheckout extends StatefulWidget {
  final Map<String, Object> course;
  final double finalPrice;

  const CourseCheckout({
    Key? key,
    required this.course,
    required this.finalPrice,
  }) : super(key: key);

  @override
  State<CourseCheckout> createState() => _CourseCheckoutState();
}

class _CourseCheckoutState extends State<CourseCheckout> {
  static const String _merchantNumberKey = "merchantNumber";
  late final List<PageModel> _mfsModels; // MFS = Mobile Financial Service
  int selectedMfsIndex = 0;

  late GlobalKey<FormState> _formKey;
  late TextEditingController _personalNumberTextController;
  late TextEditingController _transactionIdTextController;
  late TextEditingController _mfsNumberTextController;

  String get selectedMfsName => _mfsModels[selectedMfsIndex].title;
  String? get selectedMfsNumber =>
      _mfsModels[selectedMfsIndex].configs[_merchantNumberKey] as String?;

  @override
  void initState() {
    _mfsModels = <PageModel>[
      PageModel(
        title: Res.str.bkash,
        icon: Image.asset(
          Res.assets.logoBkashPng,
        ),
        configs: <String, String>{
          _merchantNumberKey: "+880bkash00000", // TODO Get number from API
        },
      ),
      PageModel(
        title: Res.str.nagad,
        icon: Image.asset(
          Res.assets.logoNagadPng,
        ),
        configs: <String, String>{
          _merchantNumberKey: "+880nagad00000", // TODO Get number from API
        },
      ),
      PageModel(
        title: Res.str.rocket,
        icon: Image.asset(
          Res.assets.logoRocketPng,
        ),
        configs: <String, String>{
          _merchantNumberKey: "+880rocket0000", // TODO Get number from API
        },
      ),
    ];

    _formKey = GlobalKey<FormState>();
    _personalNumberTextController = TextEditingController();
    _transactionIdTextController = TextEditingController();
    _mfsNumberTextController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: Res.color.pageBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyPlatformAppBar(
              config: MyAppBarConfig(
                backgroundColor: Res.color.appBarBgTransparent,
                shadow: const <BoxShadow>[],
                title: Text(Res.str.checkout),
                subtitle: widget.course["title"]!
                    as String, // TODO Get title from API
                startActions: <Widget>[
                  IconButton(
                    // TODO extract this back button as a component
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                    ),
                    iconSize: Res.dimen.iconSizeNormal,
                    color: Res.color.iconButton,
                    onPressed: () {
                      PageNav.back(context);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(Res.dimen.normalSpacingValue),
                child: Center(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: Res.dimen.maxWidthNormal,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          " ${Res.str.selectPaymentMethod}",
                          style: Res.textStyles.label,
                        ),
                        SizedBox(
                          height: Res.dimen.normalSpacingValue,
                        ),
                        Center(
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth:
                                  Res.dimen.checkoutPaymentMethodsMaxWidth,
                            ),
                            child: Row(
                              children: _mfsModels
                                  .asMap()
                                  .map((int index, PageModel value) {
                                    return MapEntry<int, Widget>(
                                      index,
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal:
                                                Res.dimen.smallSpacingValue,
                                          ),
                                          child: WidgetCheckbox(
                                            selected: selectedMfsIndex == index,
                                            image: value.icon,
                                            onTap: () =>
                                                updateSelectedMblIndex(index),
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                                  .values
                                  .toList(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Res.dimen.xxlSpacingValue,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Res.dimen.xsSpacingValue,
                          ),
                          child: Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: "${Res.str.youHaveToPay} "),
                                TextSpan(
                                  text: widget.finalPrice.toStringAsFixed(2),
                                  style:
                                      TextStyle(color: Res.color.textFocusing),
                                ),
                                TextSpan(text: " ${Res.str.tkDot}"),
                              ],
                            ),
                            style: Res.textStyles.label,
                          ),
                        ),
                        SizedBox(
                          height: Res.dimen.xxlSpacingValue,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Res.dimen.xsSpacingValue,
                          ),
                          child: Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: "${Res.str.pleaseCompleteYour} ",
                                ),
                                TextSpan(
                                  text: selectedMfsName.toUpperCase(),
                                  style: TextStyle(color: Res.color.textLink),
                                ),
                                TextSpan(text: " ${Res.str.paymentTo} "),
                                TextSpan(
                                  text: selectedMfsNumber,
                                  style: TextStyle(color: Res.color.textLink),
                                  recognizer: onMerchantNumberTapGesture(
                                    selectedMfsNumber,
                                  ),
                                ),
                                TextSpan(text: " ${Res.str.thenFillFormBelow}"),
                              ],
                            ),
                            style: Res.textStyles.label,
                          ),
                        ),
                        SizedBox(
                          height: Res.dimen.xxlSpacingValue,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              AppFormField(
                                appInputField: AppInputField(
                                  textEditingController:
                                      _personalNumberTextController,
                                  label: Res.str.yourNumberForContact,
                                  prefixText: "${Res.str.bdCountryCode} ",
                                  textInputType: TextInputType.phone,
                                  goNextOnComplete: true,
                                  borderRadius:
                                      Res.dimen.defaultBorderRadiusValue,
                                  maxLength: 15,
                                  validator: onPersonalNumberValidation,
                                ),
                              ),
                              AppFormField(
                                appInputField: AppInputField(
                                  textEditingController:
                                      _transactionIdTextController,
                                  label: "${selectedMfsName.toUpperCase()}"
                                      " ${Res.str.transactionId}",
                                  textInputType: TextInputType.text,
                                  goNextOnComplete: true,
                                  borderRadius:
                                      Res.dimen.defaultBorderRadiusValue,
                                  maxLength: 100,
                                  validator: onTransactionIdValidation,
                                ),
                              ),
                              AppFormField(
                                appInputField: AppInputField(
                                  textEditingController:
                                      _mfsNumberTextController,
                                  label: "${selectedMfsName.toUpperCase()}"
                                      " ${Res.str.numberTheMoneySentFrom}",
                                  prefixText: "${Res.str.bdCountryCode} ",
                                  textInputType: TextInputType.phone,
                                  goNextOnComplete: false,
                                  borderRadius:
                                      Res.dimen.defaultBorderRadiusValue,
                                  maxLength: 15,
                                  validator: onMfsNumberValidation,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Res.dimen.normalSpacingValue,
                        ),
                        AppButton(
                          text: Text(Res.str.submit),
                          onTap: onSubmitTap,
                          borderRadius: Res.dimen.fullRoundedBorderRadiusValue,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateSelectedMblIndex(int newIndex) {
    setState(() {
      selectedMfsIndex = newIndex;
    });
  }

  GestureRecognizer? onMerchantNumberTapGesture(String? merchantNumber) {
    TapGestureRecognizer tapGestureRecognizer = TapGestureRecognizer();

    tapGestureRecognizer.onTap = () {
      Clipboard.setData(ClipboardData(text: merchantNumber));

      context.showSnackBar(
        AppSnackBarContent(
          title: Res.str.copied,
          message: Res.str.numberCopied,
          contentType: ContentType.success,
        ),
      );
    };

    return tapGestureRecognizer;
  }

  String? onNonEmptyFieldValidation(
    TextEditingController controller,
    String? value,
    String errorMessage,
  ) {
    /// TODO move this method to a separate Validator class
    String text = controller.text;

    if (text.isEmpty) {
      return errorMessage;
    }

    return null;
  }

  String? onPersonalNumberValidation(String? value) {
    return onNonEmptyFieldValidation(
      _personalNumberTextController,
      value,
      Res.str.enterPhoneNumber,
    );
  }

  String? onTransactionIdValidation(String? value) {
    return onNonEmptyFieldValidation(
      _transactionIdTextController,
      value,
      Res.str.enterTransactionId,
    );
  }

  String? onMfsNumberValidation(String? value) {
    return onNonEmptyFieldValidation(
      _mfsNumberTextController,
      value,
      Res.str.enterMfsNumber,
    );
  }

  void onSubmitTap() {
    // TODO Uncomment validation when submission is properly implemented
    // if (_formKey.currentState?.validate() ?? false) {
    //   _formKey.currentState?.save();

    PageNav.back(context);
    // }
  }
}
