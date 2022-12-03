// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../network/models/api_coupons/coupon_get_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponGetResponse _$CouponGetResponseFromJson(Map<String, dynamic> json) =>
    CouponGetResponse(
      success: json['success'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : CouponGetResponseData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CouponGetResponseToJson(CouponGetResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.map((e) => e?.toJson()).toList(),
    };

CouponGetResponseData _$CouponGetResponseDataFromJson(
        Map<String, dynamic> json) =>
    CouponGetResponseData(
      sId: json['_id'] as String?,
      coupon: json['coupon'] as String?,
      discount: json['discount'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      iV: json['__v'] as int?,
    );

Map<String, dynamic> _$CouponGetResponseDataToJson(
        CouponGetResponseData instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'coupon': instance.coupon,
      'discount': instance.discount,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.iV,
    };
