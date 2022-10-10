import "package:app/components/app_bar/my_app_bar_config.dart";
import "package:app/components/app_bar/views/my_app_bar_full_content.dart";
import "package:app/components/app_bar/views/my_app_bar_toolbar.dart";
import "package:app/components/app_bar/views/my_app_bar_animation_view.dart";
import "package:app/utils/painters/app_bar_with_avatar_painter.dart";
import "package:flutter/widgets.dart";

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final MyAppBarConfig config;

  const MyAppBar({
    Key? key,
    required this.config,
  }) : super(key: key);

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(
        config.toolbarHeight + (config.bottom?.preferredSize.height ?? 0),
      );
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    if (widget.config.avatarConfig != null) {
      return MyAppBarAnimationView(
        config: widget.config,
        builder: (
          AnimationController animationController,
          double avatarCenterX,
          double avatarRadius,
        ) {
          return MyAppBarFullContent(
            config: widget.config,
            toolbarContents: MyAppBarToolbar(
              config: widget.config,
              leftPadding:
                  (avatarRadius > 0) ? (avatarCenterX + avatarRadius) : null,
            ),
            preferredAppBarHeight: widget.preferredSize.height,
            appBarBgPainter: AppBarWithAvatarPainter(
              config: widget.config,
              avatarCenterX: avatarCenterX,
              avatarRadius: avatarRadius,
            ),
            avatarCenterX: avatarCenterX,
            avatarRadius: avatarRadius,
          );
        },
      );
    }

    return MyAppBarFullContent(
      config: widget.config,
      toolbarContents: MyAppBarToolbar(config: widget.config),
      preferredAppBarHeight: widget.preferredSize.height,
      appBarBgPainter: AppBarWithAvatarPainter(config: widget.config),
    );
  }
}
