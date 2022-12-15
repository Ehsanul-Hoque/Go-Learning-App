// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../network/models/api_orders/all_orders_get_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllOrdersGetResponse _$AllOrdersGetResponseFromJson(
        Map<String, dynamic> json) =>
    AllOrdersGetResponse(
      success: json['success'] as String?,
      msg: json['msg'] as String?,
      data: json['data'] == null
          ? null
          : AllOrdersGetResponsePage.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AllOrdersGetResponseToJson(
        AllOrdersGetResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'msg': instance.msg,
      'data': instance.data?.toJson(),
    };

AllOrdersGetResponsePage _$AllOrdersGetResponsePageFromJson(
        Map<String, dynamic> json) =>
    AllOrdersGetResponsePage(
      totalDocuments: json['total_documents'] as int?,
      totalPage: json['total_page'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : AllOrdersGetResponseOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllOrdersGetResponsePageToJson(
        AllOrdersGetResponsePage instance) =>
    <String, dynamic>{
      'total_documents': instance.totalDocuments,
      'total_page': instance.totalPage,
      'data': instance.data?.map((e) => e?.toJson()).toList(),
    };

AllOrdersGetResponseOrder _$AllOrdersGetResponseOrderFromJson(
        Map<String, dynamic> json) =>
    AllOrdersGetResponseOrder(
      sId: json['_id'] as String?,
      bkashTransactionId: json['bkash_transaction_id'] as String?,
      paymentProvider: json['payment_provider'] as String?,
      status: json['status'] as String?,
      coupon: json['coupon'] as String?,
      phone: json['phone'] as String?,
      shortId: json['short_id'] as String?,
      coursePrice: (json['course_price'] as num?)?.toDouble(),
      discount: (json['discount'] as num?)?.toDouble(),
      subtotal: (json['subtotal'] as num?)?.toDouble(),
      details: json['details'] == null
          ? null
          : AllOrdersGetResponseOrderContent.fromJson(
              json['details'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      iV: json['__v'] as int?,
    );

Map<String, dynamic> _$AllOrdersGetResponseOrderToJson(
        AllOrdersGetResponseOrder instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'bkash_transaction_id': instance.bkashTransactionId,
      'payment_provider': instance.paymentProvider,
      'status': instance.status,
      'coupon': instance.coupon,
      'phone': instance.phone,
      'short_id': instance.shortId,
      'course_price': instance.coursePrice,
      'discount': instance.discount,
      'subtotal': instance.subtotal,
      'details': instance.details?.toJson(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.iV,
    };

AllOrdersGetResponseOrderContent _$AllOrdersGetResponseOrderContentFromJson(
        Map<String, dynamic> json) =>
    AllOrdersGetResponseOrderContent(
      course: json['course'] == null
          ? null
          : CourseGetResponse.fromJson(json['course'] as Map<String, dynamic>),
      courseId: json['course_id'] as String?,
    );

Map<String, dynamic> _$AllOrdersGetResponseOrderContentToJson(
        AllOrdersGetResponseOrderContent instance) =>
    <String, dynamic>{
      'course': instance.course?.toJson(),
      'course_id': instance.courseId,
    };
