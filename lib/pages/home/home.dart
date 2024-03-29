import "package:app/app_config/resources.dart";
import "package:app/components/carousal/widget_carousal.dart";
import "package:app/components/column_row_grid.dart";
import "package:app/components/course_item.dart";
import "package:app/components/debouncer.dart";
import "package:app/components/sliver_sized_box.dart";
import "package:app/components/userbox_network_widget.dart";
import "package:app/local_storage/boxes/userbox.dart";
import "package:app/network/enums/network_call_status.dart";
import "package:app/network/models/api_auth/profile_get_response.dart";
import "package:app/network/models/api_courses/course_get_response.dart";
import "package:app/network/models/api_orders/all_orders_get_response.dart";
import "package:app/network/notifiers/auth_api_notifier.dart";
import "package:app/network/notifiers/course_api_notifier.dart";
import "package:app/network/notifiers/order_api_notifier.dart";
import "package:app/network/notifiers/static_info_api_notifier.dart";
import "package:app/network/views/network_widget.dart";
import "package:app/utils/extensions/iterable_extension.dart";
import "package:flutter/widgets.dart";
import "package:provider/provider.dart" show ReadContext, SelectContext;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  late final double _courseGridPadding;
  late final double _courseGridHorizontalGap;
  late final double _courseGridVerticalGap;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _courseGridPadding = Res.dimen.normalSpacingValue;
    _courseGridHorizontalGap = Res.dimen.normalSpacingValue;
    _courseGridVerticalGap = Res.dimen.normalSpacingValue;

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Execute callback if page is mounted
      if (!mounted) return;

      context.read<StaticInfoApiNotifier?>()?.getStaticInfo();
      context.read<CourseApiNotifier?>()?.getAllCourses();

      if (UserBox.isLoggedIn) {
        context.read<AuthApiNotifier?>()?.getProfile();
        context.read<OrderApiNotifier?>()?.getAllOrders();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Debouncer(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          int courseGridCrossAxisCount = 1;

          for (int i = 2; i < 10; ++i) {
            double w = calculateCourseGridItemWidth(i, constraints.maxWidth);
            if (w < 150) break;
            courseGridCrossAxisCount = i;
          }

          double courseGridItemWidth = calculateCourseGridItemWidth(
            courseGridCrossAxisCount,
            constraints.maxWidth,
          );
          double courseGridItemHeight = calculateCourseGridItemHeight(
            courseGridCrossAxisCount,
            constraints.maxWidth,
          );

          return CustomScrollView(
            slivers: <Widget>[
              SliverSizedBox(
                height: Res.dimen.getPageTopPaddingWithAppBar(context),
              ),
              NetworkWidget(
                shouldOutputBeSliver: true,
                callStatusSelector: (BuildContext context) => context.select(
                  (StaticInfoApiNotifier? apiNotifier) =>
                      apiNotifier?.staticInfoGetResponse.callStatus ??
                      NetworkCallStatus.none,
                ),
                childBuilder: (BuildContext context) {
                  List<String> allBanners = context
                          .read<StaticInfoApiNotifier?>()
                          ?.staticInfoGetResponse
                          .result
                          ?.banner
                          ?.getNonNulls()
                          .toList() ??
                      <String>[];

                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: Res.dimen.largeSpacingValue,
                    ),
                    child: WidgetCarousal(
                      images: allBanners,
                    ),
                  );
                },
              ),

              /// "My Courses" heading
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: Res.dimen.normalSpacingValue,
                ),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    " ${Res.str.myCourses}",
                    style: Res.textStyles.label,
                  ),
                ),
              ),

              /// My courses grid view
              SliverPadding(
                padding: EdgeInsets.all(_courseGridPadding),
                sliver: UserBoxNetworkWidget(
                  shouldOutputBeSliver: true,
                  callStatusSelector: (BuildContext context) {
                    NetworkCallStatus allCoursesCallStatus = context.select(
                      (CourseApiNotifier? apiNotifier) =>
                          apiNotifier?.allCoursesGetResponse.callStatus ??
                          NetworkCallStatus.none,
                    );

                    NetworkCallStatus allOrdersCallStatus = context.select(
                      (OrderApiNotifier? apiNotifier) =>
                          apiNotifier?.allOrdersGetResponse.callStatus ??
                          NetworkCallStatus.none,
                    );

                    return NetworkCallStatus
                        .combineInParallel(<NetworkCallStatus>[
                      allCoursesCallStatus,
                      allOrdersCallStatus,
                    ]);
                  },
                  noContentChecker: (ProfileGetResponseData profileData) {
                    List<AllOrdersGetResponseOrder> allPendingOrders = context
                            .read<OrderApiNotifier?>()
                            ?.allOrdersGetResponse
                            .result
                            ?.data
                            ?.data
                            ?.where(
                              (AllOrdersGetResponseOrder? order) =>
                                  order?.status == "pending",
                            )
                            .getNonNulls()
                            .toList() ??
                        <AllOrdersGetResponseOrder>[];

                    List<String> enrolledCourseIds =
                        profileData.enrolledCourses?.getNonNulls().toList() ??
                            <String>[];

                    return enrolledCourseIds.isEmpty &&
                        allPendingOrders.isEmpty;
                  },
                  noContentText: Res.str.noEnrolledCourse,
                  childBuilder: (
                    BuildContext context,
                    ProfileGetResponseData profileData,
                  ) {
                    // Get a combined list of pending and enrolled courses
                    List<CourseGetResponse> myCourses =
                        getMyCourses(profileData);

                    return ColumnRowGrid(
                      itemCount: myCourses.length,
                      crossAxisCount: courseGridCrossAxisCount,
                      itemWidth: courseGridItemWidth,
                      itemHeight: courseGridItemHeight,
                      mainAxisSpacing: _courseGridVerticalGap,
                      crossAxisSpacing: _courseGridHorizontalGap,
                      itemBuilder: (BuildContext context, int index) {
                        return CourseItem(
                          course: myCourses[index],
                          showRootCategory: true,
                          listenToUserNotifier: false,
                          // No need to listen, because this grid is in the
                          // [UserBoxNetworkWidget] widget
                          // which already listens to the user notifier
                        );
                      },
                    );
                  },
                ),
              ),

              SliverSizedBox(
                height: Res.dimen.normalSpacingValue,
              ),

              /// "All Courses" heading
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: Res.dimen.normalSpacingValue,
                ),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    " ${Res.str.allCourses}",
                    style: Res.textStyles.label,
                  ),
                ),
              ),

              /// All courses grid view
              SliverPadding(
                padding: EdgeInsets.all(_courseGridPadding),
                sliver: NetworkWidget(
                  shouldOutputBeSliver: true,
                  callStatusSelector: (BuildContext context) => context.select(
                    (CourseApiNotifier? apiNotifier) =>
                        apiNotifier?.allCoursesGetResponse.callStatus ??
                        NetworkCallStatus.none,
                  ),
                  noContentChecker: () =>
                      context
                          .read<CourseApiNotifier?>()
                          ?.allCoursesGetResponse
                          .result
                          ?.isEmpty !=
                      false,
                  noContentText: Res.str.noCourses,
                  childBuilder: (BuildContext context) {
                    List<CourseGetResponse> allCourses = context
                            .read<CourseApiNotifier?>()
                            ?.allCoursesGetResponse
                            .result
                            ?.getNonNulls()
                            .toList() ??
                        <CourseGetResponse>[];

                    return ColumnRowGrid(
                      itemCount: allCourses.length,
                      crossAxisCount: courseGridCrossAxisCount,
                      itemWidth: courseGridItemWidth,
                      itemHeight: courseGridItemHeight,
                      mainAxisSpacing: _courseGridVerticalGap,
                      crossAxisSpacing: _courseGridHorizontalGap,
                      itemBuilder: (BuildContext context, int index) {
                        return CourseItem(
                          course: allCourses[index],
                          showRootCategory: true,
                        );
                      },
                    );

                    /*return SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: courseGridCrossAxisCount,
                        mainAxisSpacing: _courseGridVerticalGap,
                        crossAxisSpacing: _courseGridHorizontalGap,
                        mainAxisExtent: calculateCourseGridItemHeight(
                          courseGridCrossAxisCount,
                          constraints.maxWidth,
                        ),
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return CourseItem(course: allCourses[index]);
                        },
                        childCount: allCourses.length,
                      ),
                    );*/
                  },
                ),
              ),
              SliverSizedBox(
                height: Res.dimen.pageBottomPaddingWithNavBar,
              ),
            ],
          );
        },
      ),
    );
  }

  double calculateCourseGridItemWidth(int crossAxisCount, double parentWidth) {
    double totalPadding = _courseGridPadding * 2;
    double totalSpacing = _courseGridHorizontalGap * (crossAxisCount - 1);
    double totalGap = totalPadding + totalSpacing;
    return (parentWidth - totalGap) / crossAxisCount;
  }

  double calculateCourseGridItemHeight(int crossAxisCount, double parentWidth) {
    double contentWidth = calculateCourseGridItemWidth(
      crossAxisCount,
      parentWidth,
    );

    return Res.dimen.getCourseItemHeight(contentWidth);
  }

  List<CourseGetResponse> getMyCourses(ProfileGetResponseData profileData) {
    // Get all courses
    List<CourseGetResponse> allCourses = context
            .read<CourseApiNotifier?>()
            ?.allCoursesGetResponse
            .result
            ?.getNonNulls()
            .toList() ??
        <CourseGetResponse>[];

    // Get pending course ids
    List<String> pendingCourseIds = context
            .read<OrderApiNotifier?>()
            ?.allOrdersGetResponse
            .result
            ?.data
            ?.data
            ?.where(
              // Take only pending orders
              (AllOrdersGetResponseOrder? order) => order?.status == "pending",
            )
            .map(
              // Get a list of course ids
              (AllOrdersGetResponseOrder? e) => e?.details?.courseId,
            )
            .getNonNulls()
            .toList() ??
        <String>[];

    // Get enrolled course ids
    List<String> enrolledCourseIds =
        profileData.enrolledCourses?.getNonNulls().toList() ?? <String>[];

    // Get pending courses
    List<CourseGetResponse> pendingCourses = allCourses.where(
      (CourseGetResponse course) {
        return pendingCourseIds.contains(course.sId);
      },
    ).toList();

    // Get enrolled courses
    List<CourseGetResponse> enrolledCourses = allCourses.where(
      (CourseGetResponse course) {
        return enrolledCourseIds.contains(course.sId);
      },
    ).toList();

    // Set parameters for pending courses
    for (CourseGetResponse course in pendingCourses) {
      course.isPendingOrder = true;
      course.hasEnrolled = false;
    }

    // Set parameters for enrolled courses
    for (CourseGetResponse course in enrolledCourses) {
      course.isPendingOrder = false;
      course.hasEnrolled = true;
    }

    // Get a combined list of pending and enrolled courses
    return <CourseGetResponse>[
      ...enrolledCourses,
      ...pendingCourses,
    ];
  }
}
