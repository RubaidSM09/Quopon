import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final Function(bool isCancelled) onUrlMatched;
  final bool isCancel;
  final String orderId;

  // NEW (optional): dynamic success/cancel URLs
  final String? successUrl;
  final String? cancelUrl;

  const WebViewScreen({
    super.key,
    required this.url,
    required this.onUrlMatched,
    required this.orderId,
    this.isCancel = false,
    this.successUrl,
    this.cancelUrl,
  });

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
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onUrlChange: (UrlChange change) {
            final current = change.url ?? '';
            // Prefer dynamic URLs if provided
            if (widget.successUrl != null && current.startsWith(widget.successUrl!)) {
              Navigator.pop(context);
              widget.onUrlMatched(false); // success
              return;
            }
            if (widget.cancelUrl != null && current.startsWith(widget.cancelUrl!)) {
              Navigator.pop(context);
              widget.onUrlMatched(true); // cancelled
              return;
            }

            // Fallback to previous hardcoded checks (kept for compatibility)
            if (current == 'https://dummy.org/orders/${widget.orderId}/confirmation/') {
              Navigator.pop(context);
              widget.onUrlMatched(false);
            }
            if (current == 'https://your-frontend-app.com/payment-cancel/') {
              Navigator.pop(context);
              widget.onUrlMatched(true);
            }
          },
          onWebResourceError: (WebResourceError error) {},
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
