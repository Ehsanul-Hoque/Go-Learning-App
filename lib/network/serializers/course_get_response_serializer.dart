import "package:app/network/models/api_courses/category_model.dart";
import "package:app/network/models/api_courses/course_get_response_model.dart";
import "package:app/network/serializers/category_serializer.dart";
import "package:app/serializers/serializer.dart";

class CourseGetResponseSerializer extends Serializer<CourseGetResponseModel> {
  const CourseGetResponseSerializer();

  @override
  CourseGetResponseModel fromJson(Map<String, dynamic>? json) {
    if (json == null) return const CourseGetResponseModel();

    return CourseGetResponseModel(
      sId: json["_id"],
      rating: json["rating"] != null
          ? const CgrRatingSerializer().fromJson(json["rating"])
          : null,
      filter: (json["filter"] as List<dynamic>?)
          ?.map((dynamic item) => item as String?)
          .toList(),
      categoryId: (json["category_id"] as List<dynamic>?)
          ?.map((dynamic category) => category as Map<String, dynamic>?)
          .map(
            (Map<String, dynamic>? category) => (category == null)
                ? null
                : const CategorySerializer().fromJson(category),
          )
          .toList(),
      certificate: json["certificate"],
      language: json["language"],
      metaKeyword: json["meta_keyword"],
      metaDesc: json["meta_desc"],
      totalQuiz: json["total_quiz"],
      totalLecture: json["total_lecture"],
      title: json["title"],
      aliasName: json["alias_name"],
      description: json["description"],
      instructorName: json["instructor_name"],
      originalPrice: json["original_price"],
      price: json["price"],
      duration: json["duration"],
      access: json["access"],
      banner: json["banner"],
      preview: json["preview"],
      thumbnail: json["thumbnail"],
      immediateCategory: json["immediate_category"] != null
          ? const CgrImmediateCategorySerializer()
              .fromJson(json["immediate_category"])
          : null,
      iV: json["__v"],
    );
  }

  @override
  Map<String, dynamic> toJson(CourseGetResponseModel serializable) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["_id"] = serializable.sId;
    data["rating"] = (serializable.rating == null)
        ? null
        : const CgrRatingSerializer().toJson(serializable.rating!);
    data["filter"] = serializable.filter;
    data["category_id"] = serializable.categoryId
        ?.map(
          (CategoryModel? category) => (category == null)
              ? null
              : const CategorySerializer().toJson(category),
        )
        .toList();
    data["certificate"] = serializable.certificate;
    data["language"] = serializable.language;
    data["meta_keyword"] = serializable.metaKeyword;
    data["meta_desc"] = serializable.metaDesc;
    data["total_quiz"] = serializable.totalQuiz;
    data["total_lecture"] = serializable.totalLecture;
    data["title"] = serializable.title;
    data["alias_name"] = serializable.aliasName;
    data["description"] = serializable.description;
    data["instructor_name"] = serializable.instructorName;
    data["original_price"] = serializable.originalPrice;
    data["price"] = serializable.price;
    data["duration"] = serializable.duration;
    data["access"] = serializable.access;
    data["banner"] = serializable.banner;
    data["preview"] = serializable.preview;
    data["thumbnail"] = serializable.thumbnail;
    if (serializable.immediateCategory != null) {
      data["immediate_category"] = const CgrImmediateCategorySerializer()
          .toJson(serializable.immediateCategory!);
    }
    data["__v"] = serializable.iV;

    return data;
  }
}

class CgrRatingSerializer extends Serializer<CgrRatingModel> {
  const CgrRatingSerializer();

  @override
  CgrRatingModel fromJson(Map<String, dynamic>? json) {
    if (json == null) return const CgrRatingModel();

    return CgrRatingModel(
      totalRatingCount: json["total_rating_count"],
      average: json["average"],
    );
  }

  @override
  Map<String, dynamic> toJson(CgrRatingModel serializable) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["total_rating_count"] = serializable.totalRatingCount;
    data["average"] = serializable.average;

    return data;
  }
}

class CgrImmediateCategorySerializer
    extends Serializer<CgrImmediateCategoryModel> {
  const CgrImmediateCategorySerializer();

  @override
  CgrImmediateCategoryModel fromJson(Map<String, dynamic>? json) {
    if (json == null) return const CgrImmediateCategoryModel();

    return CgrImmediateCategoryModel(
      sId: json["_id"],
      name: json["name"],
      parentId: json["parent_id"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      iV: json["__v"],
    );
  }

  @override
  Map<String, dynamic> toJson(CgrImmediateCategoryModel serializable) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["_id"] = serializable.sId;
    data["name"] = serializable.name;
    data["parent_id"] = serializable.parentId;
    data["createdAt"] = serializable.createdAt;
    data["updatedAt"] = serializable.updatedAt;
    data["__v"] = serializable.iV;

    return data;
  }
}
