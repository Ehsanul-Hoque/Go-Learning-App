import "package:app/app_config/resources.dart";
import "package:app/components/app_circular_progress.dart";
import "package:app/components/app_container.dart";
import "package:app/components/floating_messages/app_snack_bar_content/app_snack_bar_content.dart";
import "package:app/components/floating_messages/enums/floating_messages_content_type.dart";
import "package:app/components/promo_buy_panel/apply_promo_container.dart";
import "package:app/components/promo_buy_panel/enums/promo_state.dart";
import "package:app/components/promo_buy_panel/promo_buy_container.dart";
import "package:app/network/enums/network_call_status.dart";
import "package:app/network/models/api_coupons/coupon_response_model.dart";
import "package:app/network/network_logger.dart";
import "package:app/network/notifiers/coupon_api_notifier.dart";
import "package:app/network/views/network_widget_light.dart";
import "package:app/utils/extensions/context_extension.dart";
import "package:app/utils/extensions/iterable_extension.dart";
import "package:app/utils/typedefs.dart" show OnValueListener;
import "package:collection/collection.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:provider/provider.dart" show ReadContext, SelectContext;

class PromoBuyPanel extends StatefulWidget {
  final double initialPrice;
  final double discountedPrice;
  final OnValueListener<double> onBuyCourseTap;

  const PromoBuyPanel({
    Key? key,
    required this.initialPrice,
    required this.onBuyCourseTap,
    double? discountedPrice,
  })  : discountedPrice = discountedPrice ?? initialPrice,
        super(key: key);

  @override
  State<PromoBuyPanel> createState() => _PromoBuyPanelState();
}

class _PromoBuyPanelState extends State<PromoBuyPanel> {
  late PromoState promoState;
  late String promoCode;
  late double promoDiscountAmount;

  double get finalPrice => widget.discountedPrice - promoDiscountAmount;

  @override
  void initState() {
    promoState = PromoState.promoOrBuy;
    promoCode = "";
    promoDiscountAmount = 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width =
        MediaQuery.of(context).size.width - (Res.dimen.navBarMargin * 2);

    return AppContainer(
      width: width,
      height: Res.dimen.bottomNavBarHeight,
      margin: EdgeInsets.all(Res.dimen.navBarMargin),
      padding: EdgeInsets.zero,
      backgroundColor: Res.color.bottomNavBg,
      borderRadius:
          BorderRadius.circular(Res.dimen.fullRoundedBorderRadiusValue),
      child: NetworkWidgetLight(
        callStatusSelector: (BuildContext context) {
          return context.select((CouponApiNotifier? apiNotifier) {
            if (promoCode.isNotEmpty) {
              return apiNotifier?.couponGetResponse(promoCode).callStatus ??
                  NetworkCallStatus.none;
            } else {
              return NetworkCallStatus.none;
            }
          });
        },
        onStatusNone: onStatusNone,
        onStatusNoInternet: onStatusNoInternet,
        onStatusLoading: onStatusLoading,
        onStatusFailed: onStatusFailed,
        onStatusSuccess: onStatusSuccess,
        childBuilder: (BuildContext context, NetworkCallStatus callStatus) {
          Widget resultWidget;

          switch (promoState) {
            case PromoState.promoOrBuy:
            case PromoState.promoAppliedAndBuy:
              resultWidget = PromoBuyContainer(
                initialPrice: widget.initialPrice,
                finalPrice: promoDiscountAmount > 0
                    ? finalPrice
                    : ((widget.discountedPrice != widget.initialPrice)
                        ? widget.discountedPrice
                        : null),
                onApplyPromoTap: onApplyPromoTap,
                onBuyCourseTap: onBuyCourseTap,
                promoApplied: promoState == PromoState.promoAppliedAndBuy,
              );
              break;

            case PromoState.applyPromo:
              resultWidget = ApplyPromoContainer(
                onCheckPromoTap: onCheckPromoTap,
                onCancelTap: onCancelPromoFieldTap,
                promo: promoCode,
              );
              break;

            case PromoState.loading:
              resultWidget = const AppCircularProgress();
              break;
          }

          resultWidget = AnimatedSwitcher(
            duration: Res.durations.defaultDuration,
            switchInCurve: Res.curves.defaultCurve,
            switchOutCurve: Res.curves.defaultCurve,
            child: resultWidget,
          );

          return resultWidget;
        },
      ),
    );
  }

  void onCheckPromoTap(String promo) {
    promoCode = promo.trim().toLowerCase();
    context.read<CouponApiNotifier?>()?.getCoupon(promoCode);
  }

  void onCancelPromoFieldTap() {
    setState(() {
      promoState = PromoState.promoOrBuy;
    });
  }

  void onApplyPromoTap() {
    setState(() {
      promoState = PromoState.applyPromo;
    });
  }

  void onBuyCourseTap() => widget.onBuyCourseTap(finalPrice);

  void onStatusNone() =>
      NetLog().e("Network call has not been started for coupon \"$promoCode\"");

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
        marginBottom: Res.dimen.snackBarBottomMarginLarge,
      );
    });
  }

  void onStatusLoading() => promoState = PromoState.loading;

  void onStatusFailed() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Execute callback if page is mounted
      if (!mounted) return;

      context.showSnackBar(
        AppSnackBarContent(
          title: Res.str.errorTitle,
          message: Res.str.errorCheckingPromo,
          contentType: ContentType.failure,
        ),
        marginBottom: Res.dimen.snackBarBottomMarginLarge,
      );
    });
  }

  void onStatusSuccess() {
    CouponResponseModel? coupon = getCouponFromNotifier();

    if (coupon != null) {
      promoState = PromoState.promoAppliedAndBuy;
      promoDiscountAmount = coupon.discount?.toDouble() ?? 0;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Execute callback if page is mounted
        if (!mounted) return;

        context.showSnackBar(
          AppSnackBarContent(
            title: Res.str.yesTitle,
            message: Res.str.promoValidAndDiscountApplied,
            contentType: ContentType.success,
          ),
          marginBottom: Res.dimen.snackBarBottomMarginLarge,
        );
      });
    } else {
      promoState = PromoState.applyPromo;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Execute callback if page is mounted
        if (!mounted) return;

        context.showSnackBar(
          AppSnackBarContent(
            title: Res.str.sorryTitle,
            message: Res.str.promoDoesNotExist,
            contentType: ContentType.help,
          ),
          marginBottom: Res.dimen.snackBarBottomMarginLarge,
        );
      });
    }
  }

  CouponResponseModel? getCouponFromNotifier() {
    if (promoCode.isEmpty) return null;

    List<CouponResponseModel>? resultCoupons = context
        .read<CouponApiNotifier?>()
        ?.couponGetResponse(promoCode)
        .result
        ?.data
        ?.getNonNulls()
        .toList();

    if ((resultCoupons == null) || resultCoupons.isEmpty) {
      return null;
    }

    return resultCoupons.firstWhereOrNull((CouponResponseModel coupon) {
      return coupon.coupon?.trim().toLowerCase() == promoCode;
    });
  }
}
