import "package:app/app_config/resources.dart";
import "package:app/components/app_drawer/app_drawer_item_model.dart";
import "package:flutter/widgets.dart";

class MyAppDrawerConfig {
  final Color backgroundColor, avatarBackgroundColor;
  final double avatarRadius;
  final List<AppDrawerItemModel> drawerItems;

  MyAppDrawerConfig({
    Color? backgroundColor,
    Color? avatarBackgroundColor,
    double? avatarRadius,
    List<AppDrawerItemModel>? drawerItems,
  })  : backgroundColor = backgroundColor ?? Res.color.drawerBg,
        avatarBackgroundColor =
            avatarBackgroundColor ?? Res.color.drawerAvatarBg,
        avatarRadius = avatarRadius ?? Res.dimen.drawerAvatarRadius,
        drawerItems = drawerItems ?? <AppDrawerItemModel>[];
}
