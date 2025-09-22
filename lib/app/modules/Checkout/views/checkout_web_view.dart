import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final Function(bool isCancelled) onUrlMatched;
  final bool isCancel;
  final String orderId;

  const WebViewScreen({super.key, required this.url, required this.onUrlMatched, required this.orderId, this.isCancel = false});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading progress if needed
          },
          onPageStarted: (String url) {
            // Handle page start if needed
          },
          onUrlChange: (UrlChange change) {
            print('::::::::::::::::::::::::::::::URL::::${change.url}');
            if (change.url == 'https://dummy.org/orders/${widget.orderId}/confirmation/') {
              // Navigate back to the previous screen
              Navigator.pop(context);
              widget.onUrlMatched(false);
            }
            if (change.url == 'https://your-frontend-app.com/payment-cancel/') {
              // Navigate back to the previous screen
              Navigator.pop(context);
              widget.onUrlMatched(true);
            }
          },
          onWebResourceError: (WebResourceError error) {
            // Handle web resource errors
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: WebViewWidget(controller: _controller)),
    );
  }
}