import "package:app/app_config/resources.dart";
import "package:app/components/app_button.dart";
import "package:app/components/app_drawer/app_drawer_item_model.dart";
import "package:app/components/app_drawer/my_app_drawer_config.dart";
import "package:app/components/my_circle_avatar.dart";
import "package:app/components/userbox_widget.dart";
import "package:app/local_storage/boxes/userbox.dart";
import "package:app/network/models/api_auth/profile_get_response.dart";
import "package:app/routes.dart";
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
      child: Center(
        child: SingleChildScrollView(
          child: UserBoxWidget(
            showGuestWhileLoading: true,
            showGuestIfNoInternet: true,
            showGuestIfCancelled: true,
            showGuestIfFailed: true,
            childBuilder:
                (BuildContext context, ProfileGetResponseData profileData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: Res.dimen.largeSpacingValue,
                  ),
                  MyCircleAvatar(
                    imageUrl: profileData.photo,
                    radius: config.avatarRadius,
                    padding: 1,
                    backgroundColor: config.avatarBackgroundColor,
                    shadow: const <BoxShadow>[],
                  ),
                  SizedBox(
                    height: Res.dimen.normalSpacingValue,
                  ),
                  Text(
                    profileData.name ?? Res.str.guest,
                    style: Res.textStyles.header,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: Res.dimen.hugeSpacingValue,
                  ),
                  ...config.drawerItems.map((AppDrawerItemModel item) {
                    if (item.requireAuth && !UserBox.isLoggedIn) {
                      return const SizedBox.shrink();
                    }

                    return AppButton(
                      text: Text(item.text),
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
                  if (UserBox.isLoggedIn)
                    AppButton(
                      text: Text(Res.str.logOut),
                      onTap: () => onLogOutTap(context),
                      icon: Icon(
                        Icons.logout_rounded,
                        size: Res.dimen.iconSizeNormal,
                      ),
                      backgroundColor: Res.color.buttonHollowBg,
                      contentColor: Res.color.drawerLogOutItem,
                      // padding: EdgeInsets.zero,
                      fontSize: Res.dimen.fontSizeMedium,
                      alignCenter: false,
                    )
                  else
                    AppButton(
                      text: Text("${Res.str.logIn} ${Res.str.or}"
                          " ${Res.str.signUp}"),
                      onTap: () => onLogInTap(context),
                      icon: Icon(
                        Icons.logout_rounded,
                        size: Res.dimen.iconSizeNormal,
                      ),
                      backgroundColor: Res.color.buttonHollowBg,
                      contentColor: Res.color.drawerLogInItem,
                      // padding: EdgeInsets.zero,
                      fontSize: Res.dimen.fontSizeMedium,
                      alignCenter: false,
                    ),
                  SizedBox(
                    height: Res.dimen.largeSpacingValue,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void onLogInTap(BuildContext context) {
    if (!UserBox.isLoggedIn) {
      Routes().openAuthPage(context);
    } else {
      // TODO show snack bar that the user is already authenticated
    }
  }

  void onLogOutTap(BuildContext context) {
    UserBox.logOut();
    Routes().openSplashPage(context);
  }
}
