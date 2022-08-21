import "package:app/app_config/resources.dart";
import "package:app/components/app_button.dart";
import "package:app/components/app_drawer/app_drawer_item_model.dart";
import "package:app/components/app_drawer/my_app_drawer_config.dart";
import "package:app/components/my_circle_avatar.dart";
import "package:flutter/material.dart" show Icons;
import "package:flutter/widgets.dart";

class AppDrawer extends StatelessWidget {
  final MyAppDrawerConfig? config;

  const AppDrawer({
    Key? key,
    this.config,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyAppDrawerConfig config = this.config ?? MyAppDrawerConfig();

    return Container(
      color: config.backgroundColor,
      padding: EdgeInsets.only(
        left: Res.dimen.largeSpacingValue,
        top: MediaQuery.of(context).padding.top,
        right: Res.dimen.largeSpacingValue,
      ),
      child: Column(
        children: <Widget>[
          const Spacer(),
          MyCircleAvatar(
            imageUrl:
                "https://preview.redd.it/gwqupsh46yn51.png?width=301&format=png&auto=webp&s=60efa3b8c4375c7589c929945a840c60c713c949", // TODO Get profile picture from API
            radius: config.avatarRadius,
            padding: 1,
            backgroundColor: config.avatarBackgroundColor,
            shadow: const <BoxShadow>[],
          ),
          SizedBox(
            height: Res.dimen.normalSpacingValue,
          ),
          Text(
            "Md. Ehsanul Hoque Fahad", // TODO Get username from API
            style: Res.textStyles.header,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: Res.dimen.hugeSpacingValue,
          ),
          ...config.drawerItems.map((AppDrawerItemModel item) {
            return AppButton(
              text: item.text,
              onTap: item.onTap,
              icon: Icon(
                item.iconData,
                size: Res.dimen.iconSizeNormal,
              ),
              backgroundColor: Res.color.buttonHollowBg,
              contentColor: Res.color.buttonHollowContent,
              fontSize: Res.dimen.fontSizeMedium,
              alignCenter: false,
            );
          }).toList(),
          SizedBox(
            height: Res.dimen.hugeSpacingValue,
          ),
          AppButton(
            text: Res.str.logOut,
            onTap: onLogOutTap,
            icon: Icon(
              Icons.logout_rounded,
              size: Res.dimen.iconSizeNormal,
            ),
            backgroundColor: Res.color.buttonHollowBg,
            contentColor: Res.color.drawerLogOutItem,
            // padding: EdgeInsets.zero,
            fontSize: Res.dimen.fontSizeMedium,
            alignCenter: false,
          ),
          const Spacer(),
        ],
      ),
    );
  }

  void onLogOutTap() {
    // TODO Implement log out
  }
}
