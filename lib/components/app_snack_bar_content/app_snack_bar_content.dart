import "package:app/app_config/resources.dart";
import "package:app/components/app_snack_bar_content/enums/app_snack_bar_content_type.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

class AppSnackBarContent extends StatelessWidget {
  /// `IMPORTANT NOTE` for SnackBar properties before putting this in `content`
  /// set backgroundColor: Colors.transparent
  /// set behavior: SnackBarBehavior.floating
  /// set elevation: 0.0

  final String title;
  final String message;
  final ContentType contentType;
  final Color? backgroundColor;

  const AppSnackBarContent({
    Key? key,
    required this.title,
    required this.message,
    required this.contentType,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Res.textStyles.general.copyWith(
        color: Res.color.contentOnDark,
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double maxWidth = Res.dimen.snackBarMaxWidth;

          if (constraints.maxWidth > maxWidth) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                getContent(context, maxWidth),
              ],
            );
          } else {
            return getContent(context, double.infinity);
          }
        },
      ),
    );
  }

  Widget getContent(BuildContext context, double maxWidth) {
    /// For reflecting different color shades in the SnackBar
    final HSLColor hsl =
        HSLColor.fromColor(backgroundColor ?? contentType.color);
    final HSLColor hslDark =
        hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0));

    return SizedBox(
      width: maxWidth,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: Res.dimen.snackBarContentLeftPadding,
              top: Res.dimen.normalSpacingValue,
              right: Res.dimen.normalSpacingValue,
              bottom: Res.dimen.normalSpacingValue,
            ),
            decoration: BoxDecoration(
              color: hsl.toColor(),
              borderRadius:
                  BorderRadius.circular(Res.dimen.mediumBorderRadiusValue),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: Res.dimen.fontSizeXl,
                      ),
                    ),
                    GestureDetector(
                      onTap: () =>
                          ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                      child: SvgPicture.asset(
                        Res.assets.icFailureSvg,
                        height: Res.dimen.iconSizeSmall,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: Res.dimen.smallSpacingValue,
                ),
                Text(
                  message,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          /// other SVGs in body
          Positioned(
            bottom: 0,
            left: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(Res.dimen.mediumBorderRadiusValue),
              ),
              child: SvgPicture.asset(
                Res.assets.cornerBubblesSvg,
                height: Res.dimen.snackBarBubbleImageSize,
                width: Res.dimen.snackBarBubbleImageSize,
                color: hslDark.toColor(),
              ),
            ),
          ),
          Positioned(
            top: Res.dimen.snackBarTopBubbleTop,
            left: Res.dimen.mediumBorderRadiusValue,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  Res.assets.talkBubbleSvg,
                  height: Res.dimen.snackBarTopBubbleSize,
                  color: hslDark.toColor(),
                ),
                Positioned(
                  top: Res.dimen.snackBarTopBubbleIconTop,
                  child: SvgPicture.asset(
                    getContentIcon(contentType),
                    height: Res.dimen.snackBarTopBubbleIconHeight,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getContentIcon(ContentType contentType) {
    if (contentType == ContentType.help) {
      return Res.assets.icHelpSvg;
    } else if (contentType == ContentType.failure) {
      return Res.assets.icFailureSvg;
    } else if (contentType == ContentType.success) {
      return Res.assets.icSuccessSvg;
    } else if (contentType == ContentType.warning) {
      return Res.assets.icWarningSvg;
    } else {
      return Res.assets.icFailureSvg;
    }
  }
}
