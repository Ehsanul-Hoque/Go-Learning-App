import "package:app/app_config/resources.dart";
import "package:app/components/app_container.dart";
import "package:app/components/icon_and_text.dart";
import "package:app/components/my_cached_image.dart";
import "package:app/components/splash_effect.dart";
import "package:app/components/userbox_widget.dart";
import "package:app/network/models/api_auth/profile_get_response.dart";
import "package:app/network/models/api_courses/category_get_response.dart";
import "package:app/network/models/api_courses/course_get_response.dart";
import "package:app/routes.dart";
import "package:app/utils/painters/price_bg_painter.dart";
import "package:app/utils/utils.dart";
import "package:collection/collection.dart";
import "package:flutter/cupertino.dart" show CupertinoIcons;
import "package:flutter/widgets.dart";

class CourseItem extends StatelessWidget {
  final CourseGetResponse course;
  final double? width, height;
  final EdgeInsets margin;
  final bool showRootCategory, listenToUserNotifier;

  const CourseItem({
    Key? key,
    required this.course,
    this.width,
    this.height,
    this.margin = EdgeInsets.zero,
    this.showRootCategory = false,
    this.listenToUserNotifier = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO move this [course.purchased] line to somewhere better
    //  rather than in the build method,
    //  because build method can be called too much
    // course.purchased =
    //     UserBox.currentUser?.enrolledCourses?.contains(course.sId) == true;

    return AppContainer(
      width: width,
      height: height,
      margin: margin,
      padding: EdgeInsets.zero,
      shadow: <BoxShadow>[
        Res.shadows.lighter,
      ],
      child: SplashEffect(
        onTap: () => Routes().openCourseBeforeEnrollPage(context, course),
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
                  if (showRootCategory)
                    Builder(
                      builder: (BuildContext context) {
                        String? rootCategoryName = course.categoryId
                            ?.firstWhereOrNull(
                              (CategoryGetResponseData? category) =>
                                  category?.parentId == null,
                            )
                            ?.name;

                        if (rootCategoryName == null) {
                          return const SizedBox.shrink();
                        }

                        return Positioned(
                          top: Res.dimen.xsSpacingValue,
                          right: Res.dimen.xsSpacingValue,
                          child: AppContainer(
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.only(
                              left: Res.dimen.smallSpacingValue,
                              top: Res.dimen.xxsSpacingValue / 2,
                              right: Res.dimen.smallSpacingValue,
                              // bottom: Res.dimen.xxsSpacingValue / 2,
                            ),
                            shadow: const <BoxShadow>[],
                            backgroundColor: Res.color.courseCategoryChipBg,
                            child: Text(
                              rootCategoryName,
                              style: Res.textStyles.extraSmallExtraThick
                                  .copyWith(color: Res.color.contentOnDark),
                            ),
                          ),
                        );
                      },
                    ),
                  Positioned(
                    bottom: -2,
                    right: 0,
                    child: listenToUserNotifier
                        ? UserBoxWidget(
                            showGuestWhileLoading: true,
                            showGuestIfNoInternet: true,
                            showGuestIfFailed: true,
                            childBuilder: (
                              BuildContext context,
                              ProfileGetResponseData profileData,
                            ) {
                              List<String?> enrolledCourseIds =
                                  profileData.enrolledCourses ?? <String>[];

                              course.hasEnrolled =
                                  enrolledCourseIds.contains(course.sId);

                              return getPriceWidget();
                            },
                          )
                        : getPriceWidget(),
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

  Widget getPriceWidget() {
    bool showOriginalPrice = !course.hasEnrolled &&
        !course.isFree &&
        course.originalPrice != null &&
        course.price != course.originalPrice;

    String currentPriceText;
    if (course.hasEnrolled) {
      currentPriceText = Res.str.enrolledExclamation;
    } else if (course.isFree) {
      currentPriceText = Res.str.freeExclamation;
    } else {
      currentPriceText = "${course.price?.toStringAsFixed(0) ?? "-"}"
          " ${Res.str.tkDot}";
    }

    String originalPriceText =
        "${course.originalPrice?.toStringAsFixed(0) ?? "-"}"
        " ${Res.str.tkDot}";

    return DefaultTextStyle(
      style: Res.textStyles.general.copyWith(
        fontWeight: FontWeight.w500,
        color: Res.color.price,
      ),
      child: CustomPaint(
        painter: PriceBgPainter(
          color: (course.hasEnrolled || course.isFree)
              ? Res.color.enrolledCoursePriceBg
              : null,
        ),
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
                currentPriceText,
                style: Res.textStyles.general,
              ),
              if (showOriginalPrice) ...<Widget>[
                const Text(" "),
                Text(
                  originalPriceText,
                  style: Res.textStyles.small.copyWith(
                    color: Res.color.strikethroughPrice2,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
