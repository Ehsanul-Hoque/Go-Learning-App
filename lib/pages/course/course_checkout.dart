import "package:app/app_config/resources.dart";
import "package:app/components/app_bar/my_app_bar_config.dart";
import "package:app/components/app_bar/my_platform_app_bar.dart";
import "package:app/components/app_button.dart";
import "package:app/components/app_divider.dart";
import "package:app/components/fields/app_form_field.dart";
import "package:app/components/fields/app_input_field.dart";
import "package:app/components/floating_messages/app_snack_bar_content/app_snack_bar_content.dart";
import "package:app/components/floating_messages/enums/floating_messages_content_type.dart";
import "package:app/network/enums/network_call_status.dart";
import "package:app/network/models/api_courses/course_get_response.dart";
import "package:app/network/models/api_static_info/static_info_get_response.dart";
import "package:app/network/notifiers/static_info_api_notifier.dart";
import "package:app/network/views/network_widget.dart";
import "package:app/routes.dart";
import "package:app/utils/extensions/context_extension.dart";
import "package:app/utils/typedefs.dart" show OnTapListener3;
import "package:flutter/gestures.dart";
import "package:flutter/material.dart" show IconButton, Icons;
import "package:flutter/services.dart" show Clipboard, ClipboardData;
import "package:flutter/widgets.dart";
import "package:flutter_platform_widgets/flutter_platform_widgets.dart";
import "package:provider/provider.dart" show ReadContext, SelectContext;

part "package:app/pages/course/parts/course_checkout_form.dart";

class CourseCheckout extends StatefulWidget {
  final CourseGetResponse course;
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
  @override
  void initState() {
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
                    onPressed: () => Routes.goBack(context),
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
                          child: CourseCheckoutForm(
                            finalPrice: widget.finalPrice,
                            bkashNumber: bkashNumber,
                            onSubmitTap: onSubmitTap,
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

  void onSubmitTap(
    String personalNumber,
    String transactionId,
    String mfsNumber,
  ) {
    // TODO Uncomment validation when submission is properly implemented
    // if (_formKey.currentState?.validate() ?? false) {
    //   _formKey.currentState?.save();

    Routes.goBack(context);
    // }
  }
}
