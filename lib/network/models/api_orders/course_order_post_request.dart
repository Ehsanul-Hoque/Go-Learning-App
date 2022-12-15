import "package:app/network/models/api_model.dart";
import "package:json_annotation/json_annotation.dart";

part "../../../generated/api_orders/course_order_post_request.g.dart";

@JsonSerializable()
class CourseOrderPostRequest extends ApiModel {
  @JsonKey(name: "course_id")
  String courseId;

  @JsonKey(name: "bkash_transaction_id")
  String bkashTransactionId;

  @JsonKey(name: "payment_provider")
  String paymentProvider;

  @JsonKey(name: "provider_number")
  String providerNumber;

  @JsonKey(name: "phone")
  String phone;

  @JsonKey(name: "coupon")
  String coupon;

  CourseOrderPostRequest({
    required this.courseId,
    required this.bkashTransactionId,
    required this.paymentProvider,
    required this.providerNumber,
    required this.phone,
    this.coupon = "",
  });

  factory CourseOrderPostRequest.blank() {
    return CourseOrderPostRequest(
      courseId: "",
      bkashTransactionId: "",
      paymentProvider: "",
      providerNumber: "",
      phone: "",
      coupon: "",
    );
  }

  factory CourseOrderPostRequest.fromJson(Map<String, dynamic> json) =>
      _$CourseOrderPostRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CourseOrderPostRequestToJson(this);
}
