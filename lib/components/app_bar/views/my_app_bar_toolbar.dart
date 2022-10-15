import "package:app/app_config/resources.dart";
import "package:app/components/app_bar/my_app_bar_config.dart";
import "package:app/components/app_container.dart";
import "package:flutter/widgets.dart";

class MyAppBarToolbar extends StatelessWidget {
  final MyAppBarConfig config;
  final double? leftPadding;

  const MyAppBarToolbar({
    Key? key,
    required this.config,
    this.leftPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      height: config.toolbarHeight,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.only(
        left: leftPadding ?? Res.dimen.smallSpacingValue,
        right: Res.dimen.smallSpacingValue,
      ),
      borderRadius: BorderRadius.zero,
      shadow: const <BoxShadow>[],
      backgroundColor: Res.color.transparent,
      child: Row(
        children: <Widget>[
          ...config.startActions,
          SizedBox(
            width: Res.dimen.smallSpacingValue,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: config.centerTitle
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: <Widget>[
                if (config.title != null)
                  DefaultTextStyle(
                    style: config.titleStyle,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    textAlign:
                        config.centerTitle ? TextAlign.center : TextAlign.start,
                    child: config.title!,
                  ),
                if (config.subtitle != null)
                  DefaultTextStyle(
                    style: config.subtitleStyle,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    textAlign:
                        config.centerTitle ? TextAlign.center : TextAlign.start,
                    child: config.subtitle!,
                  ),
              ],
            ),
          ),
          SizedBox(
            width: Res.dimen.smallSpacingValue,
          ),
          ...config.endActions,
        ],
      ),
    );
  }
}
