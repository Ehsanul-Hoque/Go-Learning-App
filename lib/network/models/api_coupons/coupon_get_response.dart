import "package:app/network/models/api_model.dart";
import "package:json_annotation/json_annotation.dart";

part "../../../generated/api_coupons/coupon_get_response.g.dart";

@JsonSerializable()
class CouponGetResponse extends ApiModel {
  @JsonKey(name: "success")
  final String? success;

  @JsonKey(name: "data")
  final List<CouponGetResponseData?>? data;

  CouponGetResponse({
    this.success,
    this.data,
  });

  factory CouponGetResponse.fromJson(Map<String, dynamic> json) =>
      _$CouponGetResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CouponGetResponseToJson(this);
}

@JsonSerializable()
class CouponGetResponseData extends ApiModel {
  @JsonKey(name: "_id")
  final String? sId;

  @JsonKey(name: "coupon")
  final String? coupon;

  @JsonKey(name: "discount")
  final int? discount;

  @JsonKey(name: "createdAt")
  final String? createdAt;

  @JsonKey(name: "updatedAt")
  final String? updatedAt;

  @JsonKey(name: "__v")
  final int? iV;

  const CouponGetResponseData({
    this.sId,
    this.coupon,
    this.discount,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  factory CouponGetResponseData.fromJson(Map<String, dynamic> json) =>
      _$CouponGetResponseDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CouponGetResponseDataToJson(this);
}
