import "package:app/local_storage/boxes/userbox.dart";
import "package:app/network/converters/default_converters/json_object_converter.dart";
import "package:app/network/interceptors/default_interceptors/auth_interceptor.dart";
import "package:app/network/interceptors/network_interceptor.dart";
import "package:app/network/models/api_orders/all_orders_get_response.dart";
import "package:app/network/models/api_orders/course_order_post_request.dart";
import "package:app/network/models/api_orders/course_order_post_response.dart";
import "package:app/network/network.dart";
import "package:app/network/network_callback.dart";
import "package:app/network/network_request.dart";
import "package:app/network/network_response.dart";
import "package:app/network/notifiers/api_notifier.dart";
import "package:flutter/widgets.dart" show BuildContext;
import "package:provider/provider.dart" show ChangeNotifierProvider;
import "package:provider/single_child_widget.dart" show SingleChildWidget;

class OrderApiNotifier extends ApiNotifier {
  /// API endpoints
  static const String allOrdersGetApiEndpoint = "/order/get_by_student";
  static const String courseOrderPostApiEndpoint = "/order/create";

  /// Constructor
  OrderApiNotifier();

  /// Static method to create simple provider
  static SingleChildWidget createProvider() =>
      ChangeNotifierProvider<OrderApiNotifier>(
        create: (BuildContext context) => OrderApiNotifier(),
      );

  /// Methods to get all orders of current user
  Future<NetworkResponse<AllOrdersGetResponse>> getAllOrders() {
    return const Network().createExecuteCall(
      client: defaultAuthenticatedClient,
      requestInterceptors: <NetworkRequestInterceptor>[AuthInterceptor()],
      request: const NetworkRequest.get(
        apiEndPoint: allOrdersGetApiEndpoint,
      ),
      responseConverter: const JsonObjectConverter<AllOrdersGetResponse>(
        AllOrdersGetResponse.fromJson,
      ),
      callback: NetworkCallback<AllOrdersGetResponse>(
        onUpdate: (_) => notifyListeners(),
      ),
    );
  }

  NetworkResponse<AllOrdersGetResponse> get allOrdersGetResponse =>
      Network.getOrCreateResponse(
        defaultAuthenticatedClient.baseUrl + allOrdersGetApiEndpoint,
      );

  void _resetAllOrdersGetResponse() => Network.resetResponse(
        defaultAuthenticatedClient.baseUrl + allOrdersGetApiEndpoint,
      );

  /// Methods to place order for a course
  Future<NetworkResponse<CourseOrderPostResponse>> postCourseOrder(
    CourseOrderPostRequest requestBody,
  ) {
    return const Network().createExecuteCall(
      client: defaultAuthenticatedClient,
      requestInterceptors: <NetworkRequestInterceptor>[AuthInterceptor()],
      request: NetworkRequest.post(
        apiEndPoint: courseOrderPostApiEndpoint,
        body: requestBody.toJson(),
      ),
      responseConverter: const JsonObjectConverter<CourseOrderPostResponse>(
        CourseOrderPostResponse.fromJson,
      ),
      callback: NetworkCallback<CourseOrderPostResponse>(
        onSuccess: (_) => refreshOrdersList(),
        onUpdate: (_) => notifyListeners(),
      ),
      checkCacheFirst: false,
    );
  }

  NetworkResponse<CourseOrderPostResponse> get courseOrderPostResponse =>
      Network.getOrCreateResponse(
        defaultAuthenticatedClient.baseUrl + courseOrderPostApiEndpoint,
      );

  void _resetCourseOrderPostResponse() => Network.resetResponse(
        defaultAuthenticatedClient.baseUrl + courseOrderPostApiEndpoint,
      );

  /// Method to reload the order list after a successful course order.
  void refreshOrdersList() {
    // Delay the reset to make sure notifyListeners() is fired
    Future<void>.delayed(
      const Duration(milliseconds: 500),
      () {
        if (UserBox.isLoggedIn) {
          _resetCourseOrderPostResponse();
          _resetAllOrdersGetResponse();
          getAllOrders();
        }
      },
    );
  }
}
