import "package:app/app_config/resources.dart";
import "package:app/components/app_container.dart";
import "package:app/components/app_video_player/notifiers/video_notifier.dart";
import "package:app/components/icon_and_text.dart";
import "package:app/components/my_cached_image.dart";
import "package:app/components/splash_effect.dart";
import "package:app/network/models/api_courses/course_get_response_model.dart";
import "package:app/pages/course/course_before_enroll.dart";
import "package:app/pages/course/notifiers/course_content_notifier.dart";
import "package:app/utils/app_page_nav.dart";
import "package:app/utils/painters/price_bg_painter.dart";
import "package:app/utils/utils.dart";
import "package:flutter/cupertino.dart" show CupertinoIcons;
import "package:flutter/widgets.dart";
import "package:provider/provider.dart" show MultiProvider;
import "package:provider/single_child_widget.dart";

class CourseItem extends StatelessWidget {
  final CourseGetResponseModel course;
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
        onTap: () {
          onItemTap(context);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: Res.dimen.bannerAspectRatio,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: MyCachedImage(
                      imageUrl: course.thumbnail,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    bottom: -2,
                    right: 0,
                    child: DefaultTextStyle(
                      style: Res.textStyles.general.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Res.color.price,
                      ),
                      child: CustomPaint(
                        painter: PriceBgPainter(),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: Res.dimen.largeSpacingValue,
                            top: Res.dimen.xsSpacingValue,
                            right: Res.dimen.smallSpacingValue,
                            bottom: Res.dimen.xsSpacingValue,
                          ),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "${course.price?.toStringAsFixed(0) ?? "-"}"
                                " ${Res.str.tkDot}",
                              ),
                              if ((course.originalPrice != null) &&
                                  (course.price !=
                                      course.originalPrice)) ...<Widget>[
                                const Text(" "),
                                Text(
                                  "${course.originalPrice?.toStringAsFixed(0) ?? "-"}"
                                  " ${Res.str.tkDot}",
                                  style: TextStyle(
                                    fontSize: Res.dimen.fontSizeSmall,
                                    color: Res.color.strikethroughPrice2,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ],
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
                course.title ?? "",
                style: Res.textStyles.labelSmall,
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
                course.instructorName ?? "",
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
                    IconAndText(
                      iconData: CupertinoIcons.videocam_circle,
                      text: course.totalLecture?.toString() ?? 0.toString(),
                    ),
                    SizedBox(
                      width: Res.dimen.xxsSpacingValue,
                    ),
                    IconAndText(
                      iconData: CupertinoIcons.pencil_outline,
                      text: course.totalQuiz?.toString() ?? 0.toString(),
                    ),
                    const Spacer(),
                    IconAndText(
                      iconData: CupertinoIcons.time,
                      text: Utils.formatDurationText(course.duration ?? ""),
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

  void onItemTap(BuildContext context) {
    PageNav.to(
      context,
      MultiProvider(
        providers: <SingleChildWidget>[
          CourseContentNotifier.createProvider(),
          VideoNotifier.createProvider(
            initialVideoUrl: course.preview ?? "",
          ),
        ],
        child: CourseBeforeEnroll(course: course),
      ),
    );
  }
}
