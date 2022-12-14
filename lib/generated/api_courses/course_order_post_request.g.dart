// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../network/models/api_courses/course_order_post_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseOrderPostRequest _$CourseOrderPostRequestFromJson(
        Map<String, dynamic> json) =>
    CourseOrderPostRequest(
      courseId: json['course_id'] as String,
      bkashTransactionId: json['bkash_transaction_id'] as String,
      paymentProvider: json['payment_provider'] as String,
      providerNumber: json['provider_number'] as String,
      phone: json['phone'] as String,
      coupon: json['coupon'] as String? ?? "",
    );

Map<String, dynamic> _$CourseOrderPostRequestToJson(
        CourseOrderPostRequest instance) =>
    <String, dynamic>{
      'course_id': instance.courseId,
      'bkash_transaction_id': instance.bkashTransactionId,
      'payment_provider': instance.paymentProvider,
      'provider_number': instance.providerNumber,
      'phone': instance.phone,
      'coupon': instance.coupon,
    };
