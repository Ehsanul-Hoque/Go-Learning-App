import "package:app/network/models/api_courses/course_get_response.dart";
import "package:app/network/models/api_model.dart";
import "package:json_annotation/json_annotation.dart";

part "../../../generated/api_orders/all_orders_get_response.g.dart";

@JsonSerializable()
class AllOrdersGetResponse extends ApiModel {
  @JsonKey(name: "success")
  final String? success;

  @JsonKey(name: "msg")
  final String? msg;

  @JsonKey(name: "data")
  final AllOrdersGetResponsePage? data;

  const AllOrdersGetResponse({
    this.success,
    this.msg,
    this.data,
  });

  factory AllOrdersGetResponse.fromJson(Map<String, dynamic> json) =>
      _$AllOrdersGetResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AllOrdersGetResponseToJson(this);
}

@JsonSerializable()
class AllOrdersGetResponsePage extends ApiModel {
  @JsonKey(name: "total_documents")
  final int? totalDocuments;

  @JsonKey(name: "total_page")
  final int? totalPage;

  @JsonKey(name: "data")
  final List<AllOrdersGetResponseOrder?>? data;

  const AllOrdersGetResponsePage({
    this.totalDocuments,
    this.totalPage,
    this.data,
  });

  factory AllOrdersGetResponsePage.fromJson(Map<String, dynamic> json) =>
      _$AllOrdersGetResponsePageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AllOrdersGetResponsePageToJson(this);
}

@JsonSerializable()
class AllOrdersGetResponseOrder extends ApiModel {
  @JsonKey(name: "_id")
  final String? sId;

  @JsonKey(name: "bkash_transaction_id")
  final String? bkashTransactionId;

  @JsonKey(name: "payment_provider")
  final String? paymentProvider;

  @JsonKey(name: "status")
  final String? status;

  @JsonKey(name: "coupon")
  final String? coupon;

  @JsonKey(name: "phone")
  final String? phone;

  @JsonKey(name: "short_id")
  final String? shortId;

  @JsonKey(name: "course_price")
  final double? coursePrice;

  @JsonKey(name: "discount")
  final double? discount;

  @JsonKey(name: "subtotal")
  final double? subtotal;

  @JsonKey(name: "details")
  final AllOrdersGetResponseOrderContent? details;

  @JsonKey(name: "createdAt")
  final String? createdAt;

  @JsonKey(name: "updatedAt")
  final String? updatedAt;

  @JsonKey(name: "__v")
  final int? iV;

  AllOrdersGetResponseOrder({
    this.sId,
    this.bkashTransactionId,
    this.paymentProvider,
    this.status,
    this.coupon,
    this.phone,
    this.shortId,
    this.coursePrice,
    this.discount,
    this.subtotal,
    this.details,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  factory AllOrdersGetResponseOrder.fromJson(Map<String, dynamic> json) =>
      _$AllOrdersGetResponseOrderFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AllOrdersGetResponseOrderToJson(this);
}

@JsonSerializable()
class AllOrdersGetResponseOrderContent extends ApiModel {
  @JsonKey(name: "course")
  final CourseGetResponse? course;

  @JsonKey(name: "course_id")
  final String? courseId;

  const AllOrdersGetResponseOrderContent({
    this.course,
    this.courseId,
  });

  factory AllOrdersGetResponseOrderContent.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$AllOrdersGetResponseOrderContentFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$AllOrdersGetResponseOrderContentToJson(this);
}
