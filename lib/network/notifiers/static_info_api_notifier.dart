// ignore_for_file: always_specify_types

import "package:app/network/converters/default_converters/json_object_converter.dart";
import "package:app/network/models/api_static_info/static_info_get_response_model.dart";
import "package:app/network/network_call.dart";
import "package:app/network/network_request.dart";
import "package:app/network/network_response.dart";
import "package:app/network/notifiers/api_notifier.dart";
import "package:app/network/serializers/api_static_info/static_info_get_response_serializer.dart";
import "package:flutter/widgets.dart" show BuildContext;
import "package:provider/provider.dart" show ChangeNotifierProvider;
import "package:provider/single_child_widget.dart" show SingleChildWidget;

class StaticInfoApiNotifier extends ApiNotifier {
  /// API network responses
  late NetworkResponse<StaticInfoGetResponseModel> staticInfoGetResponse =
      NetworkResponse<StaticInfoGetResponseModel>();

  /// Constructor
  StaticInfoApiNotifier();

  /// Static method to create simple provider
  static SingleChildWidget createProvider() =>
      ChangeNotifierProvider<StaticInfoApiNotifier>(
        create: (BuildContext context) => StaticInfoApiNotifier(),
      );

  /// Method to get the static info
  Future<NetworkResponse<StaticInfoGetResponseModel>>
      getAllCategories() async => await NetworkCall(
            client: defaultClient,
            request: const NetworkRequest.get(
              apiEndPoint: "/static/get",
              serializer: StaticInfoGetResponseSerializer(),
              converter: JsonObjectConverter<StaticInfoGetResponseModel>(),
            ),
            response: staticInfoGetResponse,
            updateListener: () => notifyListeners(),
          ).execute();
}
