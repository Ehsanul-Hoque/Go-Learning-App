import "package:app/app_config/resources.dart";
import "package:app/components/app_button.dart";
import "package:app/utils/typedefs.dart" show OnTapListener;
import "package:flutter/material.dart" show Icons;
import "package:flutter/widgets.dart";

class PromoBuyContainer extends StatefulWidget {
  final double initialPrice;
  final double? finalPrice;
  final OnTapListener onApplyPromoTap;
  final OnTapListener onBuyCourseTap;
  final bool promoApplied;

  const PromoBuyContainer({
    Key? key,
    required this.initialPrice,
    required this.onApplyPromoTap,
    required this.onBuyCourseTap,
    this.finalPrice,
    this.promoApplied = false,
  }) : super(key: key);

  @override
  State<PromoBuyContainer> createState() => _PromoBuyContainerState();
}

class _PromoBuyContainerState extends State<PromoBuyContainer> {
  late bool discounted;

  @override
  void initState() {
    discounted = widget.finalPrice != null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Res.dimen.xsSpacingValue),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: widget.promoApplied
                ? Wrap(
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: Res.dimen.xsSpacingValue,
                    children: <Widget>[
                      Icon(
                        Icons.check_circle,
                        color: Res.color.textSuccess,
                      ),
                      Text(
                        Res.str.promoApplied,
                        style: Res.textStyles.general.copyWith(
                          color: Res.color.textSuccess,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  )
                : AppButton(
                    text: Text(Res.str.applyPromo),
                    onTap: widget.onApplyPromoTap,
                    backgroundColor: Res.color.buttonHollowBg,
                    contentColor: Res.color.buttonHollowContent,
                    tintIconWithContentColor: false,
                    padding: EdgeInsets.zero,
                    borderRadius: Res.dimen.fullRoundedBorderRadiusValue,
                  ),
          ),
          SizedBox(
            width: Res.dimen.xsSpacingValue,
          ),
          Expanded(
            flex: 3,
            child: AppButton(
              text: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(Res.str.buyCourseAt),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "${widget.initialPrice.toStringAsFixed(0)} ${Res.str.tkDot}",
                        style: TextStyle(
                          fontSize: discounted ? null : Res.dimen.fontSizeXl,
                          fontWeight: discounted ? null : FontWeight.w700,
                          color:
                              discounted ? Res.color.strikethroughPrice : null,
                          decoration:
                              discounted ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      if (discounted) ...<Widget>[
                        SizedBox(
                          width: Res.dimen.smallSpacingValue,
                        ),
                        Text(
                          "${widget.finalPrice!.toStringAsFixed(0)} ${Res.str.tkDot}",
                          style: TextStyle(
                            fontSize: Res.dimen.fontSizeXl,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
              onTap: widget.onBuyCourseTap,
              padding: EdgeInsets.zero,
              borderRadius: Res.dimen.fullRoundedBorderRadiusValue,
            ),
          ),
        ],
      ),
    );
  }
}
