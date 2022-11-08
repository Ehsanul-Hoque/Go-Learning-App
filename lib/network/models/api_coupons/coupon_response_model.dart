import "package:app/network/models/base_api_model.dart";
import "package:app/network/serializers/api_coupons/coupon_response_serializer.dart";

class CouponResponseModel extends BaseApiModel {
  final String? sId;
  final String? coupon;
  final int? discount;
  final String? createdAt;
  final String? updatedAt;
  final int? iV;

  const CouponResponseModel({
    this.sId,
    this.coupon,
    this.discount,
    this.createdAt,
    this.updatedAt,
    this.iV,
  }) : super(serializer: const CouponResponseSerializer());

  @override
  String get className => "CouponResponseModel";
}
