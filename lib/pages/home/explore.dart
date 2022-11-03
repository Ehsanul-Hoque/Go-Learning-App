import "package:app/app_config/resources.dart";
import "package:app/components/debouncer.dart";
import "package:app/network/enums/network_call_status.dart";
import "package:app/network/models/api_courses/category_model.dart";
import "package:app/network/models/api_courses/course_get_response_model.dart";
import "package:app/network/notifiers/course_api_notifier.dart";
import "package:app/network/views/network_widget.dart";
import "package:app/pages/home/components/course_category_item.dart";
import "package:flutter/widgets.dart";
import "package:provider/provider.dart" show ReadContext, SelectContext;
import "package:tuple/tuple.dart";

class Courses extends StatefulWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Execute callback if page is mounted
      if (!mounted) return;

      context.read<CourseApiNotifier?>()?.getAllCategories();
      context.read<CourseApiNotifier?>()?.getAllCourses();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Debouncer(
      child: NetworkWidget(
        callStatusSelector: (BuildContext context) => context.select(
          (CourseApiNotifier? apiNotifier) => <NetworkCallStatus?>[
            apiNotifier?.allCategoriesGetInfo.callStatus,
            apiNotifier?.allCoursesGetInfo.callStatus,
          ],
        ),
        noContentChecker: () {
          bool noCategories = context
                  .read<CourseApiNotifier?>()
                  ?.allCategoriesGetInfo
                  .result
                  ?.categories
                  ?.isEmpty !=
              false;

          bool noCourses = context
                  .read<CourseApiNotifier?>()
                  ?.allCoursesGetInfo
                  .result
                  ?.isEmpty !=
              false;

          return noCategories || noCourses;
        },
        noContentText: Res.str.noCourses,
        childBuilder: (BuildContext context) {
          Iterable<Tuple2<CategoryModel, List<CourseGetResponseModel>>>
              coursesByCategory = getCoursesByCategory();

          return ListView.builder(
            padding: EdgeInsets.only(
              top: Res.dimen.getPageTopPaddingWithAppBar(context),
              bottom: Res.dimen.pageBottomPaddingWithNavBar,
            ),
            itemBuilder: (BuildContext context, int index) {
              Tuple2<CategoryModel, List<CourseGetResponseModel>>
                  categoryAndCourse = coursesByCategory.elementAt(index);

              return CourseCategoryItem(
                title: categoryAndCourse.item1.name ?? "Uncategorized",
                courses: categoryAndCourse.item2,
              );
            },
            itemCount: coursesByCategory.length,
          );
        },
      ),
    );
  }

  Iterable<Tuple2<CategoryModel, List<CourseGetResponseModel>>>
      getCoursesByCategory() {
    // Get the categories
    List<CategoryModel?> categories = context
            .read<CourseApiNotifier?>()
            ?.allCategoriesGetInfo
            .result
            ?.categories ??
        <CategoryModel>[];

    // Get the courses
    List<CourseGetResponseModel?> courses =
        context.read<CourseApiNotifier?>()?.allCoursesGetInfo.result ??
            <CourseGetResponseModel?>[];

    // Create a map to store the final result
    final Map<String, Tuple2<CategoryModel, List<CourseGetResponseModel>>>
        // ignore: always_specify_types
        categoriesByIdMap = {};

    // Fill up the result map with initial data
    for (CategoryModel? category in categories) {
      if (category == null) {
        continue;
      }

      categoriesByIdMap[category.sId ?? ""] =
          Tuple2<CategoryModel, List<CourseGetResponseModel>>(
        category,
        <CourseGetResponseModel>[],
      );
    }

    // Put the courses in the result map according to their root categories
    for (CourseGetResponseModel? course in courses) {
      if (course == null) {
        continue;
      }

      List<CategoryModel?>? allParentCategories = course.categoryId;
      if (allParentCategories == null) {
        continue;
      }

      CategoryModel? rootCategory;
      for (CategoryModel? category in allParentCategories) {
        if (category == null) {
          continue;
        }

        if (category.parentId == null || category.parentId!.trim().isEmpty) {
          rootCategory = category;
        }
      }

      if (rootCategory == null) {
        continue;
      }

      String rootCategoryId = rootCategory.sId ?? "";
      Tuple2<CategoryModel, List<CourseGetResponseModel>>? categoryAndCourse =
          categoriesByIdMap[rootCategoryId];

      if (categoryAndCourse == null) {
        continue;
      }

      categoryAndCourse.item2.add(course);
      categoriesByIdMap[rootCategoryId] = categoryAndCourse;
    }

    return categoriesByIdMap.values;
  }
}
