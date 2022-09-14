import "package:app/app_config/resources.dart";
import "package:app/components/fields/app_input_field.dart";
import "package:app/utils/typedefs.dart" show OnTapListener, OnValueListener;
import "package:flutter/cupertino.dart" show CupertinoIcons;
import "package:flutter/material.dart" show IconButton;
import "package:flutter/widgets.dart";

class ApplyPromoContainer extends StatefulWidget {
  final OnValueListener<String> onCheckPromoTap;
  final OnTapListener onCancelTap;
  final double? spaceBetweenItems;

  const ApplyPromoContainer({
    Key? key,
    required this.onCheckPromoTap,
    required this.onCancelTap,
    this.spaceBetweenItems,
  }) : super(key: key);

  @override
  State<ApplyPromoContainer> createState() => _ApplyPromoContainerState();
}

class _ApplyPromoContainerState extends State<ApplyPromoContainer> {
  late TextEditingController _promoCodeTextController;

  @override
  void initState() {
    _promoCodeTextController = TextEditingController();
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
            validator: onPromoValidation,
            showCounterText: false,
            maxLength: 50,
            borderThickness: 0,
            focusedBorderThickness: 0,
            errorBorderThickness: 0,
            focusedErrorBorderThickness: 0,
          ),
        ),
        SizedBox(
          width: widget.spaceBetweenItems,
        ),
        IconButton(
          onPressed: widget.onCancelTap,
          icon: Icon(
            CupertinoIcons.multiply_circle,
            color: Res.color.iconButton,
            size: Res.dimen.iconSizeNormal,
          ),
        ),
        SizedBox(
          width: widget.spaceBetweenItems,
        ),
        IconButton(
          onPressed: () =>
              widget.onCheckPromoTap(_promoCodeTextController.text),
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

  String? onPromoValidation(String? value) {
    String promo = value ?? "";

    if (promo.isEmpty) {
      return Res.str.enterPromo;
    }

    return null;
  }
}
