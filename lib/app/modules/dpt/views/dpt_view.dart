import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/dpt_controller.dart';

class DptView extends GetView<DptController> {
  const DptView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    WebViewController webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (!request.url.startsWith('https://cekdptonline.kpu.go.id/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://cekdptonline.kpu.go.id/'));
    return Scaffold(
      appBar: AppBar(title: const Text('Cek DPT Online')),
      body: WebViewWidget(controller: webController),
    );
  }
}
