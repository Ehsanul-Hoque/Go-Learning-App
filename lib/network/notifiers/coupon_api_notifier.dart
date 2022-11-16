// ignore_for_file: always_specify_types

import "package:app/network/converters/default_converters/json_object_converter.dart";
import "package:app/network/models/api_coupons/coupon_response_model.dart";
import "package:app/network/models/base_api_response_model.dart";
import "package:app/network/network.dart";
import "package:app/network/network_request.dart";
import "package:app/network/network_response.dart";
import "package:app/network/notifiers/api_notifier.dart";
import "package:app/network/serializers/api_coupons/coupon_response_serializer.dart";
import "package:app/network/serializers/base_api_response_serializer.dart";
import "package:flutter/widgets.dart" show BuildContext;
import "package:provider/provider.dart" show ChangeNotifierProvider;
import "package:provider/single_child_widget.dart" show SingleChildWidget;

class CouponApiNotifier extends ApiNotifier {
  /// API endpoints
  static String couponGetApiEndpoint(String? coupon) {
    return (coupon == null)
        ? "/coupon/get"
        : (coupon.trim().isEmpty
            ? "/coupon/get"
            : "/coupon/get?coupon=${coupon.trim().toLowerCase()}");
  }

  /// Constructor
  CouponApiNotifier();

  /// Static method to create simple provider
  static SingleChildWidget createProvider() =>
      ChangeNotifierProvider<CouponApiNotifier>(
        create: (BuildContext context) => CouponApiNotifier(),
      );

  /// Methods to get coupon
  Future<NetworkResponse<BaseApiResponseModel<CouponResponseModel>>> getCoupon(
    String? coupon,
  ) {
    return Network(updateListener: () => notifyListeners()).createExecuteCall(
      client: defaultClient,
      request: NetworkRequest.get(
        apiEndPoint: couponGetApiEndpoint(coupon),
        serializer: const BaseApiResponseSerializer<CouponResponseModel>(
          CouponResponseSerializer(),
        ),
        converter: const JsonObjectConverter<
            BaseApiResponseModel<CouponResponseModel>>(),
      ),
    );
  }

  NetworkResponse<BaseApiResponseModel<CouponResponseModel>> couponGetResponse(
    String? coupon,
  ) {
    return Network.getOrCreateResponse(
      defaultClient.baseUrl + couponGetApiEndpoint(coupon),
    );
  }
}
