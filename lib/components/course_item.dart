import "package:app/app_config/resources.dart";
import "package:app/components/app_container.dart";
import "package:app/components/icon_and_text.dart";
import "package:app/components/splash_effect.dart";
import "package:app/utils/painters/price_bg_painter.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_svg/flutter_svg.dart";

class CourseItem extends StatelessWidget {
  final Map<String, String> course;
  final double? width, height;
  final EdgeInsets margin;

  const CourseItem({
    Key? key,
    required this.course,
    this.width,
    this.height,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      width: width,
      height: height,
      margin: margin,
      padding: EdgeInsets.zero,
      shadow: <BoxShadow>[
        Res.shadows.lighter,
      ],
      child: SplashEffect(
        onTap: onItemTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: course["banner"]!, // TODO Get banner from API
                    fadeInDuration: Res.durations.defaultDuration,
                    fadeOutDuration: Res.durations.defaultDuration,
                    fadeInCurve: Res.curves.defaultCurve,
                    fadeOutCurve: Res.curves.defaultCurve,
                    placeholder: (BuildContext context, String url) {
                      return Padding(
                        padding: EdgeInsets.all(
                          Res.dimen.normalSpacingValue,
                        ),
                        child: SvgPicture.asset(Res.assets.loadingSvg),
                      );
                    },
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: -2,
                    right: 0,
                    child: CustomPaint(
                      painter: PriceBgPainter(),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: Res.dimen.largeSpacingValue,
                          top: Res.dimen.xsSpacingValue,
                          right: Res.dimen.smallSpacingValue,
                          bottom: Res.dimen.xsSpacingValue,
                        ),
                        child: Text(
                          course["price"]!, // TODO Get price from API
                          style: Res.textStyles.general.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Res.color.priceColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Res.dimen.smallSpacingValue,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Res.dimen.msSpacingValue,
              ),
              child: Text(
                course["title"]!, // TODO Get title from API
                style: Res.textStyles.subLabel,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            SizedBox(
              height: Res.dimen.xxsSpacingValue,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Res.dimen.msSpacingValue,
              ),
              child: Text(
                "${Res.str.by} ${course["instructor"]!}", // TODO Get instructor from API
                style: Res.textStyles.secondary,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Res.dimen.msSpacingValue,
                ),
                child: Row(
                  children: <Widget>[
                    const IconAndText(
                      iconData: CupertinoIcons.videocam_circle,
                      text: "18", // TODO Get video count from API
                    ),
                    SizedBox(
                      width: Res.dimen.xxsSpacingValue,
                    ),
                    const IconAndText(
                      iconData: CupertinoIcons.pencil_outline,
                      text: "20", // TODO Get quiz count from API
                    ),
                    const Spacer(),
                    const IconAndText(
                      iconData: CupertinoIcons.time,
                      text: "3.25h", // TODO Get course time length from API
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onItemTap() {
    // TODO Implement on tap
  }
}
