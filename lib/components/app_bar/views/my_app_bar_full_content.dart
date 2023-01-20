import "package:app/app_config/resources.dart";
import "package:app/components/app_bar/my_app_bar_config.dart";
import "package:app/components/app_bar/views/my_app_bar_toolbar.dart";
import "package:app/components/my_circle_avatar.dart";
import "package:app/components/userbox_widget.dart";
import "package:app/network/models/api_auth/profile_get_response.dart";
import "package:app/utils/painters/app_bar_with_avatar_painter.dart";
import "package:flutter/widgets.dart";

class MyAppBarFullContent extends StatelessWidget {
  final MyAppBarConfig config;
  final MyAppBarToolbar toolbarContents;
  final double preferredAppBarHeight;
  final AppBarWithAvatarPainter? appBarBgPainter;
  final double? avatarCenterX, avatarRadius;

  const MyAppBarFullContent({
    Key? key,
    required this.config,
    required this.toolbarContents,
    required this.preferredAppBarHeight,
    this.appBarBgPainter,
    this.avatarCenterX,
    this.avatarRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final bool hasAvatar = (config.avatarConfig != null);
    final double avatarCenterX = this.avatarCenterX ??
        config.avatarConfig?.avatarCenterX ??
        Res.dimen.appBarAvatarCenterX;
    final double avatarRadius = this.avatarRadius ??
        config.avatarConfig?.avatarRadius ??
        Res.dimen.appBarAvatarRadius;

    Widget fullContent = Padding(
      padding: EdgeInsets.only(
        top: statusBarHeight,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              toolbarContents,
              config.bottom ?? const SizedBox.shrink(),
            ],
          ),
          if (config.bottomBorder != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: config.bottomBorder!,
            ),
          if (hasAvatar)
            Positioned(
              bottom: -avatarRadius,
              left: avatarCenterX - avatarRadius,
              child: UserBoxWidget(
                showGuestWhileLoading: true,
                showGuestIfNoInternet: true,
                showGuestIfCancelled: true,
                showGuestIfFailed: true,
                childBuilder: (
                  BuildContext context,
                  ProfileGetResponseData profileData,
                ) {
                  return GestureDetector(
                    onTap: config.avatarConfig?.onAvatarTap,
                    child: MyCircleAvatar(
                      imageUrl: profileData.photo,
                      radius: avatarRadius,
                      padding: Res.dimen.defaultBorderThickness,
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );

    fullContent = CustomPaint(
      painter: appBarBgPainter ?? AppBarWithAvatarPainter(config: config),
      child: fullContent,
    );

    return Container(
      height: preferredAppBarHeight + statusBarHeight,
      decoration: BoxDecoration(
        boxShadow: config.shadow ??
            <BoxShadow>[
              Res.shadows.normal,
            ],
        // color: (appBarBgPainter == null) ? config.backgroundColor : null,
      ),
      child: fullContent,
    );
  }
}
