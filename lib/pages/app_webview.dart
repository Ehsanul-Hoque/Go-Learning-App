import "dart:async";

import "package:app/app_config/resources.dart";
import "package:app/components/app_bar/my_app_bar_config.dart";
import "package:app/components/app_bar/my_platform_app_bar.dart";
import "package:app/utils/app_page_nav.dart";
import "package:flutter/material.dart";
import "package:webview_flutter/webview_flutter.dart";

class AppWebView extends StatefulWidget {
  final String url;
  final CookieManager? cookieManager;

  const AppWebView({
    Key? key,
    required this.url,
    this.cookieManager,
  }) : super(key: key);

  @override
  State<AppWebView> createState() => _AppWebView();
}

class _AppWebView extends State<AppWebView> {
  final Completer<WebViewController> _webViewController =
      Completer<WebViewController>();
  late final Future<WebViewController> _webViewControllerFuture;

  @override
  void initState() {
    super.initState();
    _webViewControllerFuture = _webViewController.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Res.color.pageBg,
      body: Column(
        children: <Widget>[
          FutureBuilder<WebViewController>(
            future: _webViewControllerFuture,
            builder: (
              BuildContext context,
              AsyncSnapshot<WebViewController> controllerSnapshot,
            ) {
              return MyPlatformAppBar(
                config: MyAppBarConfig(
                  backgroundColor: Res.color.transparent,
                  shadow: const <BoxShadow>[],
                  title: controllerSnapshot.hasData
                      ? FutureBuilder<String?>(
                          future: controllerSnapshot.data!.currentUrl(),
                          builder: (
                            BuildContext context,
                            AsyncSnapshot<String?> urlSnapshot,
                          ) {
                            return Text(urlSnapshot.data ?? "");
                          },
                        )
                      : const Text(""),
                  startActions: <Widget>[
                    IconButton(
                      // TODO extract this back button as a component
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      iconSize: Res.dimen.iconSizeNormal,
                      color: Res.color.iconButton,
                      onPressed: () {
                        PageNav.back(context);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          Expanded(
            child: WebView(
              initialUrl: widget.url,
              // javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _webViewController.complete(webViewController);
              },
              navigationDelegate: (NavigationRequest request) {
                setState(() {});
                return NavigationDecision.navigate;
              },
              gestureNavigationEnabled: true,
            ),
          ),
        ],
      ),
    );
  }
}
