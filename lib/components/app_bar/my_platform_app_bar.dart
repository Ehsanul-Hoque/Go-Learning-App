import "package:app/app_config/resources.dart";
import "package:app/components/app_bar/my_app_bar.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_platform_widgets/flutter_platform_widgets.dart";

//the default has alpha which will cause the content to slide under the header for ios
/*const Color _kDefaultNavBarBorderColor = Color(0x4C000000);

const Border _kDefaultNavBarBorder = Border(
  bottom: BorderSide(
    color: _kDefaultNavBarBorderColor,
    width: 0.0, // One physical pixel.
    style: BorderStyle.solid,
  ),
);*/

class MyPlatformAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;

  const MyPlatformAppBar({
    Key? key,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isMaterial(context)) {
      return createMaterialWidget(context);
    } else if (isCupertino(context)) {
      return createCupertinoWidget(context);
    }

    return throw UnsupportedError(
      "This platform is not supported: $defaultTargetPlatform",
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Res.dimen.toolbarHeight);

  PreferredSizeWidget createMaterialWidget(BuildContext context) {
    return const MyAppBar();
  }

  PreferredSizeWidget createCupertinoWidget(BuildContext context) {
    return const MyAppBar();
  }
}
