import "package:app/app_config/resources.dart";
import "package:app/components/fields/app_input_field.dart";
import "package:app/components/floating_messages/app_snack_bar_content/app_snack_bar_content.dart";
import "package:app/components/floating_messages/enums/floating_messages_content_type.dart";
import "package:app/utils/extensions/context_extension.dart";
import "package:app/utils/typedefs.dart" show OnTapListener, OnValueListener;
import "package:flutter/cupertino.dart" show CupertinoIcons;
import "package:flutter/material.dart" show IconButton;
import "package:flutter/widgets.dart";

class ApplyPromoContainer extends StatefulWidget {
  final OnValueListener<String> onCheckPromoTap;
  final OnTapListener onCancelTap;
  final String promo;

  const ApplyPromoContainer({
    Key? key,
    required this.onCheckPromoTap,
    required this.onCancelTap,
    this.promo = "",
  }) : super(key: key);

  @override
  State<ApplyPromoContainer> createState() => _ApplyPromoContainerState();
}

class _ApplyPromoContainerState extends State<ApplyPromoContainer> {
  late TextEditingController _promoCodeTextController;

  @override
  void initState() {
    _promoCodeTextController = TextEditingController(text: widget.promo);
    super.initState();
  }

  @override
  void dispose() {
    _promoCodeTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: Res.dimen.normalSpacingValue,
        ),
        Expanded(
          child: AppInputField(
            textEditingController: _promoCodeTextController,
            hint: Res.str.enterPromoHere,
            textInputType: TextInputType.text,
            goNextOnComplete: false,
            showCounterText: false,
            maxLength: 50,
            borderThickness: 0,
            focusedBorderThickness: 0,
            errorBorderThickness: 0,
            focusedErrorBorderThickness: 0,
          ),
        ),
        SizedBox(
          width: Res.dimen.xsSpacingValue,
        ),
        IconButton(
          onPressed: widget.onCancelTap,
          icon: Icon(
            CupertinoIcons.multiply_circle,
            color: Res.color.iconButton,
            size: Res.dimen.iconSizeNormal,
          ),
        ),
        IconButton(
          onPressed: () => onCheckPromoTap(_promoCodeTextController.text),
          icon: Icon(
            CupertinoIcons.checkmark_alt_circle,
            color: Res.color.iconButton,
            size: Res.dimen.iconSizeNormal,
          ),
        ),
        SizedBox(
          width: Res.dimen.normalSpacingValue,
        ),
      ],
    );
  }

  void onCheckPromoTap(String promo) {
    if (promo.trim().isEmpty) {
      context.showSnackBar(
        AppSnackBarContent(
          title: Res.str.invalidPromoTitle,
          message: Res.str.emptyPromoNotValid,
          contentType: ContentType.help,
        ),
        marginBottom: Res.dimen.snackBarBottomMarginLarge,
      );
      return;
    }

    widget.onCheckPromoTap(promo);
  }
}
