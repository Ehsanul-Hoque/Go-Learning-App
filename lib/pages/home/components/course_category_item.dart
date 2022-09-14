import "package:app/app_config/resources.dart";
import "package:app/components/course_item.dart";
import "package:flutter/widgets.dart";

class CourseCategoryItem extends StatelessWidget {
  final String title;
  final List<Map<String, Object>> courses;

  const CourseCategoryItem({
    Key? key,
    required this.title,
    required this.courses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int totalCourses = courses.length;
    double itemSpacing = Res.dimen.normalSpacingValue;
    double listHorizontalPadding = itemSpacing;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: listHorizontalPadding,
          ),
          child: Text(
            " $title",
            style: Res.textStyles.label,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: Res.dimen.normalSpacingValue,
            bottom: Res.dimen.xxlSpacingValue,
          ),
          child: SizedBox(
            height: Res.dimen.getCourseItemHeight(Res.dimen.courseItemWidth),
            child: ListView.builder(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return CourseItem(
                  course: courses.elementAt(index),
                  width: Res.dimen.courseItemWidth,
                  margin: EdgeInsets.only(
                    left: (index == 0)
                        ? listHorizontalPadding
                        : (itemSpacing / 2),
                    right: (index == totalCourses - 1)
                        ? listHorizontalPadding
                        : (itemSpacing / 2),
                  ),
                );
              },
              itemCount: totalCourses,
            ),
          ),
        ),
      ],
    );
  }
}
