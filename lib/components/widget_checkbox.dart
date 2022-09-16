import "package:app/app_config/resources.dart";
import "package:app/components/app_container.dart";
import "package:app/components/splash_effect.dart";
import "package:app/utils/typedefs.dart" show OnTapListener;
import "package:flutter/cupertino.dart" show CupertinoIcons;
import "package:flutter/widgets.dart";

class WidgetCheckbox extends StatelessWidget {
  final Widget image;
  final OnTapListener onTap;
  final double? aspectRatio;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final bool selected;

  const WidgetCheckbox({
    Key? key,
    required this.image,
    required this.onTap,
    this.aspectRatio,
    this.backgroundColor,
    this.padding,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double aspectRatio = this.aspectRatio ?? Res.dimen.bannerAspectRatio;

    return AppContainer(
      animated: true,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      backgroundColor: backgroundColor,
      shadow: <BoxShadow>[
        if (selected) Res.shadows.lighter,
      ],
      child: SplashEffect(
        onTap: onTap,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: padding ?? EdgeInsets.all(Res.dimen.msSpacingValue),
              child: Column(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: aspectRatio,
                    child: image,
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: AnimatedSwitcher(
                duration: Res.durations.defaultDuration,
                switchInCurve: Res.curves.defaultCurve,
                switchOutCurve: Res.curves.defaultCurve,
                child: selected
                    ? Center(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Res.color.widgetCheckBoxSelectedShade,
                          ),
                          child: Icon(
                            CupertinoIcons.checkmark_alt,
                            size: Res.dimen.iconSizeHuge,
                            color: Res.color.contentOnDark,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
