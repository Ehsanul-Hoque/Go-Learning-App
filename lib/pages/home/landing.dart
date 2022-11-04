import "package:app/app_config/resources.dart";
import "package:app/components/app_bar/my_app_bar_config.dart";
import "package:app/components/app_bar/my_platform_app_bar.dart";
import "package:app/components/app_drawer/app_drawer.dart";
import "package:app/components/app_drawer/app_drawer_item_model.dart";
import "package:app/components/app_drawer/my_app_drawer_config.dart";
import "package:app/components/bottom_nav/enums/app_bottom_navigation_item_size.dart";
import "package:app/components/bottom_nav/models/app_bottom_navigation_button_model.dart";
import "package:app/components/bottom_nav/views/app_bottom_navigation_bar.dart";
import "package:app/models/page_model.dart";
import "package:app/network/notifiers/static_info_api_notifier.dart";
import "package:app/pages/home/exams.dart";
import "package:app/pages/home/explore.dart";
import "package:app/pages/home/favourites.dart";
import "package:app/pages/home/home.dart";
import "package:flutter/cupertino.dart" show CupertinoIcons;
import "package:flutter/material.dart" show IconButton, Icons, Scaffold;
import "package:flutter/widgets.dart";
import "package:flutter_zoom_drawer/config.dart";
import "package:flutter_zoom_drawer/flutter_zoom_drawer.dart";
import "package:provider/provider.dart" show ReadContext;

part "package:app/pages/home/landing_main_section.dart";

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late final List<AppDrawerItemModel> _appDrawerItems;
  late final ZoomDrawerController _drawerController;

  @override
  void initState() {
    _appDrawerItems = <AppDrawerItemModel>[
      AppDrawerItemModel(
        iconData: Icons.edit_note_outlined,
        text: Res.str.editProfile,
        onTap: onEditProfileTap,
      ),
      AppDrawerItemModel(
        iconData: Icons.payments_outlined,
        text: Res.str.paymentHistory,
        onTap: onPaymentHistoryTap,
      ),
      AppDrawerItemModel(
        iconData: Icons.notes_outlined,
        text: Res.str.termsOfUse,
        onTap: onTermsOfUseTap,
      ),
      AppDrawerItemModel(
        iconData: Icons.privacy_tip_outlined,
        text: Res.str.privacyPolicy,
        onTap: onPrivacyPolicyTap,
      ),
    ];

    _drawerController = ZoomDrawerController();
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Execute callback if page is mounted
      if (!mounted) return;

      context.read<StaticInfoApiNotifier?>()?.getStaticInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuScreen: AppDrawer(
        config: MyAppDrawerConfig(
          drawerItems: _appDrawerItems,
        ),
      ),
      mainScreen: LandingMainSection(
        drawerController: _drawerController,
      ),
      controller: _drawerController,
      borderRadius: Res.dimen.largeBorderRadiusValue,
      menuBackgroundColor: Res.color.drawerBg,
      showShadow: true,
      slideWidth: MediaQuery.of(context).size.width * 0.85,
      openCurve: Res.curves.defaultCurve,
      closeCurve: Res.curves.defaultCurve,
      duration: Res.durations.defaultDuration,
      reverseDuration: Res.durations.defaultDuration,
      // androidCloseOnBackTap: true,
      isRtl: true,
      mainScreenTapClose: true,
    );
  }

  void onEditProfileTap() {
    // TODO Go to edit profile
  }

  void onPaymentHistoryTap() {
    // TODO Show payment history
  }

  void onTermsOfUseTap() {
    // TODO Show terms of use
  }

  void onPrivacyPolicyTap() {
    // TODO Show privacy policy
  }
}
