// ignore_for_file: always_specify_types

import "package:app/network/converters/default_converters/json_object_converter.dart";
import "package:app/network/models/api_coupons/coupon_response_model.dart";
import "package:app/network/models/base_api_response_model.dart";
import "package:app/network/network_call.dart";
import "package:app/network/network_request.dart";
import "package:app/network/network_response.dart";
import "package:app/network/notifiers/api_notifier.dart";
import "package:app/network/serializers/api_coupons/coupon_response_serializer.dart";
import "package:app/network/serializers/base_api_response_serializer.dart";
import "package:flutter/widgets.dart" show BuildContext;
import "package:provider/provider.dart" show ChangeNotifierProvider;
import "package:provider/single_child_widget.dart" show SingleChildWidget;

class CouponApiNotifier extends ApiNotifier {
  /// API network responses
  late NetworkResponse<BaseApiResponseModel<CouponResponseModel>>
      couponGetInfo = NetworkResponse();

  /// Constructor
  CouponApiNotifier();

  /// Static method to create simple provider
  static SingleChildWidget createProvider() =>
      ChangeNotifierProvider<CouponApiNotifier>(
        create: (BuildContext context) => CouponApiNotifier(),
      );

  /// Method to get coupon
  Future<NetworkResponse<BaseApiResponseModel<CouponResponseModel>>> getCoupon(
    String? coupon,
  ) async =>
      await NetworkCall(
        client: defaultClient,
        request: NetworkRequest.get(
          apiEndPoint: (coupon == null)
              ? "/coupon/get"
              : (coupon.trim().isEmpty
                  ? "/coupon/get"
                  : "/coupon/get?coupon=${coupon.trim()}"),
          serializer: const BaseApiResponseSerializer<CouponResponseModel>(
            CouponResponseSerializer(),
          ),
          converter: const JsonObjectConverter<
              BaseApiResponseModel<CouponResponseModel>>(),
        ),
        response: couponGetInfo,
        updateListener: () => notifyListeners(),
      ).execute();
}
