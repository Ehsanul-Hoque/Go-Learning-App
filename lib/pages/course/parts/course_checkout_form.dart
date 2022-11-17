part of "package:app/pages/course/course_checkout.dart";

class CourseCheckoutForm extends StatefulWidget {
  final double finalPrice;
  final String bkashNumber;
  final OnTapListener3<String, String, String> onSubmitTap;

  const CourseCheckoutForm({
    Key? key,
    required this.finalPrice,
    required this.bkashNumber,
    required this.onSubmitTap,
  }) : super(key: key);

  @override
  State<CourseCheckoutForm> createState() => _CourseCheckoutFormState();
}

class _CourseCheckoutFormState extends State<CourseCheckoutForm> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _personalNumberTextController;
  late TextEditingController _transactionIdTextController;
  late TextEditingController _mfsNumberTextController;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _personalNumberTextController = TextEditingController();
    _transactionIdTextController = TextEditingController();
    _mfsNumberTextController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
                    style: TextStyle(
                      color: Res.color.textFocusing,
                      decoration: TextDecoration.underline,
                    ),
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
                    text: Res.str.bkash.toUpperCase(),
                    style: TextStyle(
                      color: Res.color.textLink,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(text: " ${Res.str.paymentTo} "),
                  TextSpan(
                    text: widget.bkashNumber,
                    style: TextStyle(
                      color: Res.color.textLink,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: onMerchantNumberTapGesture(
                      widget.bkashNumber,
                    ),
                  ),
                  TextSpan(
                    text: " ${Res.str.thenFillFormBelow}",
                  ),
                ],
              ),
              style: Res.textStyles.label,
            ),
          ),
          SizedBox(
            height: Res.dimen.normalSpacingValue,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Res.dimen.xsSpacingValue,
            ),
            child: IntrinsicHeight(
              child: Row(
                children: <Widget>[
                  AppDivider(
                    axis: Axis.vertical,
                    margin: EdgeInsets.only(
                      right: Res.dimen.normalSpacingValue,
                    ),
                  ),
                  Text(
                    Res.str.canTapOnNumberToCopy,
                    style: Res.textStyles.general,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: Res.dimen.xxlSpacingValue,
          ),
          AppFormField(
            appInputField: AppInputField(
              textEditingController: _personalNumberTextController,
              label: Res.str.yourNumberForContact,
              prefixText: "${Res.str.bdCountryCode} ",
              textInputType: TextInputType.phone,
              goNextOnComplete: true,
              borderRadius: Res.dimen.defaultBorderRadiusValue,
              maxLength: 15,
              validator: onPersonalNumberValidation,
            ),
          ),
          AppFormField(
            appInputField: AppInputField(
              textEditingController: _transactionIdTextController,
              label: "${Res.str.bkash.toUpperCase()}"
                  " ${Res.str.transactionId}",
              textInputType: TextInputType.text,
              goNextOnComplete: true,
              borderRadius: Res.dimen.defaultBorderRadiusValue,
              maxLength: 100,
              validator: onTransactionIdValidation,
            ),
          ),
          AppFormField(
            appInputField: AppInputField(
              textEditingController: _mfsNumberTextController,
              label: "${Res.str.bkash.toUpperCase()}"
                  " ${Res.str.numberTheMoneySentFrom}",
              prefixText: "${Res.str.bdCountryCode} ",
              textInputType: TextInputType.phone,
              goNextOnComplete: false,
              borderRadius: Res.dimen.defaultBorderRadiusValue,
              maxLength: 15,
              validator: onMfsNumberValidation,
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
    );
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
    String? value,
    String errorMessage,
  ) {
    /// TODO move this method to a separate Validator class
    if (value == null || value.isEmpty) {
      return errorMessage;
    }

    return null;
  }

  String? onPersonalNumberValidation(String? value) {
    return onNonEmptyFieldValidation(
      value,
      Res.str.enterPhoneNumber,
    );
  }

  String? onTransactionIdValidation(String? value) {
    return onNonEmptyFieldValidation(
      value,
      Res.str.enterTransactionId,
    );
  }

  String? onMfsNumberValidation(String? value) {
    return onNonEmptyFieldValidation(
      value,
      Res.str.enterMfsNumber,
    );
  }

  void onSubmitTap() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      widget.onSubmitTap(
        _personalNumberTextController.text,
        _transactionIdTextController.text,
        _mfsNumberTextController.text,
      );
    }
  }
}
