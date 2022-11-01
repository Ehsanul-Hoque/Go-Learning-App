import "package:app/app_config/resources.dart";
import "package:app/app_config/sample_data.dart";
import "package:app/components/debouncer.dart";
import "package:app/pages/home/components/course_category_item.dart";
import "package:flutter/widgets.dart";

class Courses extends StatefulWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    Iterable<MapEntry<String, List<Map<String, Object>>>> coursesByCategory =
        getCoursesByCategory().entries;

    return Debouncer(
      child: ListView.builder(
        padding: EdgeInsets.only(
          top: Res.dimen.getPageTopPaddingWithAppBar(context),
          bottom: Res.dimen.pageBottomPaddingWithNavBar,
        ),
        itemBuilder: (BuildContext context, int index) {
          MapEntry<String, List<Map<String, Object>>> courseCategory =
              coursesByCategory.elementAt(index);

          return CourseCategoryItem(
            title: courseCategory.key,
            courses: courseCategory.value,
          );
        },
        itemCount: coursesByCategory.length,
      ),
    );
  }

  Map<String, List<Map<String, Object>>> getCoursesByCategory() {
    // TODO Get courses from API and delete the sample data

    final List<Map<String, Object>> allCourses = SampleData.courses;
    final Map<String, List<Map<String, Object>>> result =
        <String, List<Map<String, Object>>>{};

    for (Map<String, Object> element in allCourses) {
      String category = element["category"]! as String;

      if (result[category] == null) {
        result[category] = <Map<String, Object>>[];
      }

      result[category]!.add(element);
    }

    return result;
  }
}
