import "package:app/app_config/resources.dart";
import "package:app/components/app_bar/my_app_bar_config.dart";
import "package:app/components/app_bar/my_platform_app_bar.dart";
import "package:app/components/app_button.dart";
import "package:app/components/app_circular_progress.dart";
import "package:app/components/app_divider.dart";
import "package:app/components/fields/app_form_field.dart";
import "package:app/components/fields/app_input_field.dart";
import "package:app/components/floating_messages/app_snack_bar_content/app_snack_bar_content.dart";
import "package:app/components/floating_messages/enums/floating_messages_content_type.dart";
import "package:app/network/enums/network_call_status.dart";
import "package:app/network/models/api_coupons/coupon_get_response.dart";
import "package:app/network/models/api_courses/course_get_response.dart";
import "package:app/network/models/api_orders/course_order_post_request.dart";
import "package:app/network/models/api_static_info/static_info_get_response.dart";
import "package:app/network/notifiers/order_api_notifier.dart";
import "package:app/network/notifiers/static_info_api_notifier.dart";
import "package:app/network/views/network_widget.dart";
import "package:app/network/views/network_widget_light.dart";
import "package:app/routes.dart";
import "package:app/utils/extensions/context_extension.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart" show IconButton, Icons;
import "package:flutter/services.dart" show Clipboard, ClipboardData;
import "package:flutter/widgets.dart";
import "package:flutter_platform_widgets/flutter_platform_widgets.dart";
import "package:provider/provider.dart" show ReadContext, SelectContext;

part "package:app/pages/course/parts/course_checkout_form.dart";

class CourseCheckout extends StatefulWidget {
  final CourseGetResponse course;
  final CouponGetResponseData? appliedCoupon;
  final double finalPrice;

  const CourseCheckout({
    Key? key,
    required this.course,
    required this.finalPrice,
    this.appliedCoupon,
  }) : super(key: key);

  @override
  State<CourseCheckout> createState() => _CourseCheckoutState();
}

class _CourseCheckoutState extends State<CourseCheckout> {
  late GlobalKey<FormState> _formKey;
  late CourseOrderPostRequest _orderInfo;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _orderInfo = CourseOrderPostRequest.blank();
    _orderInfo.courseId = widget.course.sId ?? "";
    _orderInfo.paymentProvider = "bkash";
    _orderInfo.coupon = widget.appliedCoupon?.coupon ?? "";

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Execute callback if page is mounted
      if (!mounted) return;

      context.read<StaticInfoApiNotifier?>()?.getStaticInfo();
    });
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
                subtitle: Text(widget.course.title ?? ""),
                startActions: <Widget>[
                  IconButton(
                    // TODO extract this back button as a component
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                    ),
                    iconSize: Res.dimen.iconSizeNormal,
                    color: Res.color.iconButton,
                    onPressed: () => Routes.goBack(context: context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: NetworkWidget(
                callStatusSelector: (BuildContext context) => context.select(
                  (StaticInfoApiNotifier? apiNotifier) =>
                      apiNotifier?.staticInfoGetResponse.callStatus ??
                      NetworkCallStatus.none,
                ),
                childBuilder: (BuildContext context) {
                  StaticInfoGetResponse? response = context
                      .read<StaticInfoApiNotifier?>()
                      ?.staticInfoGetResponse
                      .result;

                  String bkashNumber = response?.bkashNumber ?? "-";

                  return Align(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(Res.dimen.normalSpacingValue),
                      child: Center(
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: Res.dimen.maxWidthNormal,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              CourseCheckoutForm(
                                formKey: _formKey,
                                finalPrice: widget.finalPrice,
                                bkashNumber: bkashNumber,
                                orderInfo: _orderInfo,
                              ),
                              SizedBox(
                                height: Res.dimen.normalSpacingValue,
                              ),
                              NetworkWidgetLight(
                                callStatusSelector: (BuildContext context) {
                                  return context
                                      .select((OrderApiNotifier? apiNotifier) {
                                    return apiNotifier?.courseOrderPostResponse
                                            .callStatus ??
                                        NetworkCallStatus.none;
                                  });
                                },
                                onStatusNoInternet: onSubmitStatusNoInternet,
                                onStatusFailed: onSubmitStatusFailed,
                                onStatusSuccess: onSubmitStatusSuccess,
                                childBuilder: (
                                  BuildContext context,
                                  NetworkCallStatus callStatus,
                                ) {
                                  Widget resultWidget;

                                  if (callStatus == NetworkCallStatus.loading) {
                                    resultWidget = const AppCircularProgress();
                                  } else {
                                    resultWidget = AppButton(
                                      text: Text(Res.str.submit),
                                      onTap: onSubmitTap,
                                      borderRadius: Res
                                          .dimen.fullRoundedBorderRadiusValue,
                                    );
                                  }

                                  resultWidget = AnimatedSize(
                                    duration: Res.durations.defaultDuration,
                                    curve: Res.curves.defaultCurve,
                                    clipBehavior: Clip.none,
                                    child: AnimatedSwitcher(
                                      duration: Res.durations.defaultDuration,
                                      switchInCurve: Res.curves.defaultCurve,
                                      switchOutCurve: Res.curves.defaultCurve,
                                      child: resultWidget,
                                    ),
                                  );

                                  return resultWidget;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSubmitTap() {
    if (_formKey.currentState?.validate() != true) return;
    _formKey.currentState?.save();

    OrderApiNotifier apiNotifier = context.read<OrderApiNotifier>();
    apiNotifier.postCourseOrder(_orderInfo);
  }

  void onSubmitStatusNoInternet() {
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
  }

  void onSubmitStatusFailed() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Execute callback if page is mounted
      if (!mounted) return;

      context.showSnackBar(
        AppSnackBarContent(
          title: Res.str.sorryTitle,
          message: Res.str.errorOrderingCourse,
          contentType: ContentType.failure,
        ),
      );
    });
  }

  void onSubmitStatusSuccess() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Execute callback if page is mounted
      if (!mounted) return;

      context.showSnackBar(
        AppSnackBarContent(
          title: Res.str.yesTitle,
          message: Res.str.courseOrderedSuccessfully,
          contentType: ContentType.success,
        ),
      );
    });

    Routes.goHome(context);
  }
}
