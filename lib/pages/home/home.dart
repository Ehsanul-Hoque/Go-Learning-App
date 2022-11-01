import "package:app/app_config/resources.dart";
import "package:app/app_config/sample_data.dart";
import "package:app/components/carousal/widget_carousal.dart";
import "package:app/components/course_item.dart";
import "package:app/components/debouncer.dart";
import "package:app/components/sliver_sized_box.dart";
import "package:app/network/enums/network_call_status.dart";
import "package:app/network/models/api_courses/course_get_response_model.dart";
import "package:app/network/notifiers/course_api_notifier.dart";
import "package:app/network/views/network_widget.dart";
import "package:flutter/widgets.dart";
import "package:provider/provider.dart";

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

      context.read<CourseApiNotifier?>()?.getAllCourses();
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

          return CustomScrollView(
            slivers: <Widget>[
              SliverSizedBox(
                height: Res.dimen.getPageTopPaddingWithAppBar(context),
              ),
              SliverToBoxAdapter(
                child: WidgetCarousal(
                  images: SampleData.images, // TODO Show banners from API
                ),
              ),
              SliverSizedBox(
                height: Res.dimen.largeSpacingValue,
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: Res.dimen.normalSpacingValue,
                ),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    " ${Res.str.courses}",
                    style: Res.textStyles.label,
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(_courseGridPadding),
                sliver: NetworkWidget(
                  shouldOutputBeSliver: true,
                  callStatusSelector: () => context.select(
                    (CourseApiNotifier? apiNotifier) =>
                        apiNotifier?.allCoursesGetInfo.callStatus ??
                        NetworkCallStatus.none,
                  ),
                  noContentChecker: () =>
                      context
                          .read<CourseApiNotifier?>()
                          ?.allCoursesGetInfo
                          .result
                          ?.isEmpty !=
                      false,
                  noContentText: Res.str.noCourses,
                  childBuilder: (BuildContext context) {
                    List<CourseGetResponseModel> allCourses = context
                            .read<CourseApiNotifier?>()
                            ?.allCoursesGetInfo
                            .result ??
                        <CourseGetResponseModel>[];

                    return SliverGrid(
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
                          return CourseItem(
                            course: allCourses[index],
                          );
                        },
                        childCount: allCourses.length,
                      ),
                    );
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
}
