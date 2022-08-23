import "package:app/app_config/resources.dart";
import "package:app/app_config/sample_data.dart";
import "package:app/components/carousal/widget_carousal.dart";
import "package:app/components/course_item.dart";
import "package:app/components/fake_loading.dart";
import "package:app/components/sliver_sized_box.dart";
import "package:app/utils/extensions/iterable_extension.dart";
import "package:flutter/widgets.dart";

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  late final Iterable<Map<String, String>> _sampleCourses;
  late final double _courseGridPadding;
  late final double _courseGridHorizontalGap;
  late final double _courseGridVerticalGap;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _sampleCourses = SampleData.courses.getRandoms(100);
    _courseGridPadding = Res.dimen.normalSpacingValue;
    _courseGridHorizontalGap = Res.dimen.normalSpacingValue;
    _courseGridVerticalGap = Res.dimen.normalSpacingValue;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return FakeLoading(
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
                sliver: SliverGrid(
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
                      // TODO Show courses from API
                      return CourseItem(
                        course: _sampleCourses.elementAt(index),
                      );
                    },
                    childCount: _sampleCourses.length,
                  ),
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
