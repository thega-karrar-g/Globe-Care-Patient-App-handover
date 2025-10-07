
import 'package:get/get.dart';
import 'package:globcare/app/core/theme_helper/app_colors.dart';
import 'package:globcare/app/data/models/m_appointment.dart';
import 'package:globcare/app/data/models/request_model.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../base_controller/base_controller.dart';

class WebviewController extends BaseController {

  late final WebViewController webViewController;

  RequestModel appointment=Get.arguments;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();


    initWebViewController();

  }



  initWebViewController()async{


    late final PlatformWebViewControllerCreationParams params;
    params = WebViewPlatform.instance is WebKitWebViewPlatform
        ? WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true, mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{})
        : const PlatformWebViewControllerCreationParams();

    webViewController = WebViewController.fromPlatformCreationParams(
      params,
      onPermissionRequest: (request) {
        request.grant();
      },
    )

      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.black)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},

          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   return NavigationDecision.prevent;
            // }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(appointment.jitsiLink));


  }

}
