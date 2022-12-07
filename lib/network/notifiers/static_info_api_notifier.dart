import "package:app/network/converters/default_converters/json_object_converter.dart";
import "package:app/network/models/api_static_info/static_info_get_response.dart";
import "package:app/network/network.dart";
import "package:app/network/network_callback.dart";
import "package:app/network/network_request.dart";
import "package:app/network/network_response.dart";
import "package:app/network/notifiers/api_notifier.dart";
import "package:flutter/widgets.dart" show BuildContext;
import "package:provider/provider.dart" show ChangeNotifierProvider;
import "package:provider/single_child_widget.dart" show SingleChildWidget;

class StaticInfoApiNotifier extends ApiNotifier {
  /// API endpoints
  static const String staticInfoGetApiEndpoint = "/static/get";

  /// Constructor
  StaticInfoApiNotifier();

  /// Static method to create simple provider
  static SingleChildWidget createProvider() =>
      ChangeNotifierProvider<StaticInfoApiNotifier>(
        create: (BuildContext context) => StaticInfoApiNotifier(),
      );

  /// Methods to get the static info
  Future<NetworkResponse<StaticInfoGetResponse>> getStaticInfo() =>
      const Network().createExecuteCall(
        client: defaultClient,
        request: const NetworkRequest.get(
          apiEndPoint: staticInfoGetApiEndpoint,
        ),
        responseConverter: const JsonObjectConverter<StaticInfoGetResponse>(
          StaticInfoGetResponse.fromJson,
        ),
        callback: NetworkCallback<StaticInfoGetResponse>(
          onUpdate: (_) => notifyListeners(),
        ),
      );

  NetworkResponse<StaticInfoGetResponse> get staticInfoGetResponse =>
      Network.getOrCreateResponse(
        defaultClient.baseUrl + staticInfoGetApiEndpoint,
      );
}
