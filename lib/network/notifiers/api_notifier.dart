import "dart:io" show HttpHeaders;

import "package:app/local_storage/boxes/userbox.dart";
import "package:app/network/models/api_header.dart";
import "package:app/network/network_client.dart";
import "package:flutter/foundation.dart" show ChangeNotifier;

abstract class ApiNotifier extends ChangeNotifier {
  final NetworkClient defaultClient = NetworkClient(
    baseUrl: "https://api.golearningbd.com",
    headers: const ApiHeader().toJson(),
  );

  NetworkClient get defaultAuthenticatedClient {
    return NetworkClient(
      baseUrl: "https://api.golearningbd.com",
      headers: ApiHeader(xAccessToken: UserBox.accessToken).toJson(),
    );
  }
}
