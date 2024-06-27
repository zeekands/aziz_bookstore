import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CustomWebView extends StatefulWidget {
  const CustomWebView({Key? key, required this.url, this.backBtn = true, this.title}) : super(key: key);

  final bool? backBtn;
  final String url;
  final String? title;

  @override
  State<CustomWebView> createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;

  late PullToRefreshController pullToRefreshController;
  String url = "";
  final double _progress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      settings: PullToRefreshSettings(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  InAppWebViewController? webView;
  String pageTitle = 'Read Book';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        leading: widget.backBtn!
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
        title: Text(widget.title ?? pageTitle,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            )),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          InAppWebView(
            key: webViewKey,
            initialUrlRequest: URLRequest(
              url: WebUri(
                widget.url,
              ),
            ),
          ),
          _progress != 1.0
              ? LinearProgressIndicator(
                  value: _progress,
                  backgroundColor: Colors.white,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
