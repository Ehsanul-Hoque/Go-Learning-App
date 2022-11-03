import "dart:io" show HttpHeaders;

import "package:app/network/network_client.dart";
import "package:flutter/foundation.dart" show ChangeNotifier;

abstract class ApiNotifier extends ChangeNotifier {
  final NetworkClient defaultClient = const NetworkClient(
    baseUrl: "https://api.golearningbd.com",
    headers: <String, String>{
      HttpHeaders.contentTypeHeader: "application/json",
    },
  );
}
