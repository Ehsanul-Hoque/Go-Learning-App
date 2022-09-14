import "package:app/app_config/resources.dart";
import "package:app/components/app_container.dart";
import "package:app/components/promo_buy_panel/apply_promo_container.dart";
import "package:app/components/promo_buy_panel/promo_buy_container.dart";
import "package:app/utils/typedefs.dart" show OnValueListener;
import "package:flutter/widgets.dart";

class PromoBuyPanel extends StatefulWidget {
  final double initialPrice;
  final OnValueListener<double> onBuyCourseTap;
  final double? width, height;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final double? spaceBetweenItems;
  final Duration? animationDuration;
  final Curve? animationCurve;

  const PromoBuyPanel({
    Key? key,
    required this.initialPrice,
    required this.onBuyCourseTap,
    this.width,
    this.height,
    this.backgroundColor,
    this.borderRadius,
    this.spaceBetweenItems,
    this.animationDuration,
    this.animationCurve,
  }) : super(key: key);

  @override
  State<PromoBuyPanel> createState() => _PromoBuyPanelState();
}

class _PromoBuyPanelState extends State<PromoBuyPanel> {
  late double width, height;
  late double contentMinWidth;
  late Color backgroundColor;
  late EdgeInsets padding;
  late BorderRadius borderRadius;
  late Duration animationDuration;
  late Curve animationCurve;

  late bool showApplyPromoField;
  late double discountAmount;

  double get finalPrice => widget.initialPrice - discountAmount;

  @override
  void initState() {
    height = widget.height ?? Res.dimen.bottomNavBarHeight;
    backgroundColor = widget.backgroundColor ?? Res.color.bottomNavBg;
    borderRadius = widget.borderRadius ??
        BorderRadius.circular(
          Res.dimen.fullRoundedBorderRadiusValue,
        );

    animationDuration =
        widget.animationDuration ?? Res.durations.defaultDuration;
    animationCurve = widget.animationCurve ?? Res.curves.defaultCurve;

    showApplyPromoField = false;
    discountAmount = 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = widget.width ??
        MediaQuery.of(context).size.width - (Res.dimen.navBarMargin * 2);

    return AppContainer(
      width: width,
      height: height,
      margin: EdgeInsets.all(Res.dimen.navBarMargin),
      padding: EdgeInsets.zero,
      backgroundColor: backgroundColor,
      borderRadius:
          BorderRadius.circular(Res.dimen.fullRoundedBorderRadiusValue),
      child: AnimatedSwitcher(
        duration: animationDuration,
        switchInCurve: animationCurve,
        switchOutCurve: animationCurve,
        child: showApplyPromoField
            ? ApplyPromoContainer(
                onCheckPromoTap: onCheckPromoTap,
                onCancelTap: onCancelPromoFieldTap,
                spaceBetweenItems: widget.spaceBetweenItems,
              )
            : PromoBuyContainer(
                initialPrice: widget.initialPrice,
                finalPrice: discountAmount > 0 ? finalPrice : null,
                onApplyPromoTap: onApplyPromoTap,
                onBuyCourseTap: onBuyCourseTap,
                spaceBetweenItems: widget.spaceBetweenItems,
              ),
      ),
    );
  }

  void onCheckPromoTap(String promo) {
    // TODO Check if the promo is valid or not
    setState(() {
      discountAmount = 150; // TODO Set an actual discount amount from API
      showApplyPromoField = false;
    });
  }

  void onCancelPromoFieldTap() {
    setState(() {
      showApplyPromoField = false;
    });
  }

  void onApplyPromoTap() {
    setState(() {
      showApplyPromoField = true;
    });
  }

  void onBuyCourseTap() {
    widget.onBuyCourseTap(finalPrice);
  }
}
