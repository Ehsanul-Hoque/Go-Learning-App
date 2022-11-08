import "package:app/network/models/api_coupons/coupon_response_model.dart";
import "package:app/serializers/serializer.dart";

class CouponResponseSerializer extends Serializer<CouponResponseModel> {
  const CouponResponseSerializer();

  @override
  CouponResponseModel fromJson(Map<String, dynamic>? json) {
    if (json == null) return const CouponResponseModel();

    return CouponResponseModel(
      sId: json["_id"],
      coupon: json["coupon"],
      discount: json["discount"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      iV: json["__v"],
    );
  }

  @override
  Map<String, dynamic> toJson(CouponResponseModel serializable) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["_id"] = serializable.sId;
    data["coupon"] = serializable.coupon;
    data["discount"] = serializable.discount;
    data["createdAt"] = serializable.createdAt;
    data["updatedAt"] = serializable.updatedAt;
    data["__v"] = serializable.iV;

    return data;
  }
}
