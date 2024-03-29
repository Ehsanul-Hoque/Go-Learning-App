import "package:app/app_config/resources.dart";
import "package:app/components/app_bar/my_app_bar_config.dart";
import "package:app/components/app_bar/my_platform_app_bar.dart";
import "package:app/components/floating_messages/app_snack_bar_content/app_snack_bar_content.dart";
import "package:app/components/floating_messages/enums/floating_messages_content_type.dart";
import "package:app/components/promo_buy_panel/promo_buy_panel.dart";
import "package:app/components/tab_bar/views/app_tab_bar.dart";
import "package:app/local_storage/boxes/userbox.dart";
import "package:app/models/page_model.dart";
import "package:app/network/models/api_coupons/coupon_get_response.dart";
import "package:app/network/models/api_courses/course_get_response.dart";
import "package:app/pages/course/course_details.dart";
import "package:app/pages/course/course_playlist.dart";
import "package:app/routes.dart";
import "package:app/utils/extensions/context_extension.dart";
import "package:app/utils/extensions/iterable_extension.dart";
import "package:flutter/material.dart"
    show DefaultTabController, IconButton, Icons, Scaffold, Tab;
import "package:flutter/widgets.dart";

class CourseBeforeEnroll extends StatefulWidget {
  final CourseGetResponse course;

  const CourseBeforeEnroll({
    Key? key,
    required this.course,
  }) : super(key: key);

  @override
  State<CourseBeforeEnroll> createState() => _CourseBeforeEnrollState();
}

class _CourseBeforeEnrollState extends State<CourseBeforeEnroll> {
  late final List<PageModel> _pageModels;
  late final PageController _pageController;
  int _selectedTabBarIndex = 0;
  bool _pageViewScrolling = false;
  CouponGetResponseData? appliedPromo;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);

    if (widget.course.hasEnrolled) {
      _pageModels = <PageModel>[
        PageModel(
          title: Res.str.coursePlaylist,
          page: CoursePlaylist(course: widget.course),
        ),
        PageModel(
          title: Res.str.courseDetails,
          page: CourseDetails(course: widget.course),
        ),
      ];
    } else {
      _pageModels = <PageModel>[
        PageModel(
          title: Res.str.courseDetails,
          page: CourseDetails(course: widget.course),
        ),
        PageModel(
          title: Res.str.coursePlaylist,
          page: CoursePlaylist(course: widget.course),
        ),
      ];
    }

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Res.color.pageRootBg,
      child: Scaffold(
        backgroundColor: Res.color.pageBg,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification notification) {
                  if (notification.depth == 0 &&
                      notification is ScrollEndNotification) {
                    _pageViewScrolling = false;
                  }
                  return false;
                },
                child: DefaultTabController(
                  animationDuration: Res.durations.defaultDuration,
                  length: _pageModels.length,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: Res.dimen.smallSpacingValue,
                      ),
                      MyPlatformAppBar(
                        config: MyAppBarConfig(
                          backgroundColor: Res.color.appBarBgTransparent,
                          shadow: const <BoxShadow>[],
                          title: Text(
                            widget.course.title ?? "",
                          ),
                          subtitle: Text(
                            "${Res.str.by} ${widget.course.instructorName ?? ""}",
                          ),
                          startActions: <Widget>[
                            IconButton(
                              // TODO extract this back button as a component
                              constraints: const BoxConstraints(),
                              icon: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                              ),
                              iconSize: Res.dimen.iconSizeNormal,
                              color: Res.color.iconButton,
                              onPressed: () => Routes.goBack(context: context),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Res.dimen.normalSpacingValue,
                        ),
                        child: AppTabBar(
                          tabs: _pageModels.map((PageModel page) {
                            return Tab(
                              text: page.title,
                            );
                          }).toList(),
                          onTabChange: (int newSelectedIndex) {
                            _pageViewScrolling = true;
                            updatePage(newSelectedIndex, true);
                          },
                        ),
                      ),
                      Expanded(
                        child: PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _pageController,
                          children: _pageModels.map((PageModel model) {
                            return model.page;
                          }).toList(),
                          onPageChanged: (int newSelectedIndex) {
                            if (!_pageViewScrolling) {
                              updatePage(newSelectedIndex, false);
                            }

                            _pageViewScrolling = true;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (!widget.course.isPendingOrder && !widget.course.hasEnrolled)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: PromoBuyPanel(
                    initialPrice: widget.course.originalPrice?.toDouble() ?? 0,
                    discountedPrice: widget.course.price?.toDouble(),
                    onPromoApplied: (CouponGetResponseData promo) =>
                        appliedPromo = promo,
                    onBuyCourseTap: onBuyCourseTap,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void updatePage(int index, bool updatePageView) {
    FocusScope.of(context).unfocus();
    setState(() {
      _selectedTabBarIndex = index;

      if (updatePageView) {
        _pageController.animateToPage(
          _selectedTabBarIndex,
          duration: Res.durations.defaultDuration,
          curve: Res.curves.defaultCurve,
        );
      }
    });
  }

  void onBuyCourseTap(double finalPrice) {
    if (UserBox.hasProfileInfo) {
      if (isEnrolledAlready()) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Execute callback if page is mounted
          if (!mounted) return;

          context.showSnackBar(
            AppSnackBarContent(
              title: Res.str.heyTitle,
              message: Res.str.alreadyEnrolledCourse,
              contentType: ContentType.help,
            ),
            marginBottom: Res.dimen.snackBarBottomMarginLarge,
          );
        });
      } else {
        Routes().openCourseCheckoutPage(
          context: context,
          course: widget.course,
          appliedCoupon: appliedPromo,
          finalPrice: finalPrice,
        );
      }
    } else {
      Routes().openAuthPage(
        context: context,
        redirectOnSuccess: (BuildContext context) {
          if (isEnrolledAlready()) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // Execute callback if page is mounted
              if (!mounted) return;

              context.showSnackBar(
                AppSnackBarContent(
                  title: Res.str.heyTitle,
                  message: Res.str.alreadyEnrolledCourse,
                  contentType: ContentType.help,
                ),
                marginBottom: Res.dimen.snackBarBottomMarginLarge,
              );
            });

            Routes.goBack(context: context);
          } else {
            Routes(config: const RoutesConfig(replace: true))
                .openCourseCheckoutPage(
              context: context,
              course: widget.course,
              appliedCoupon: appliedPromo,
              finalPrice: finalPrice,
            );
          }
        },
      );
    }
  }

  bool isEnrolledAlready() {
    List<String> enrolledCourseIds =
        UserBox.currentUser?.enrolledCourses?.getNonNulls().toList() ??
            <String>[];

    return enrolledCourseIds.contains(widget.course.sId);
  }
}
