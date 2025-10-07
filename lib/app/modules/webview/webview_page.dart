import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'webview_controller.dart';

class WebviewPage extends StatelessWidget {
  final controller = Get.put(WebviewController());

   WebviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

body: WebViewWidget(controller: controller.webViewController),
    );
  }
}
