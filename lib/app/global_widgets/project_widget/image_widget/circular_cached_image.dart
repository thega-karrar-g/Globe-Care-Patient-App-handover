import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/assets_helper/app_images.dart';
import '../../shared/ui_helpers.dart';

class CircularCachedImageWidget extends StatelessWidget {
  final String url;
  final double radius;
  final bool isMemberTemplate;

  const CircularCachedImageWidget({
    Key? key,
    required this.url,
    this.radius = 50,
    this.isMemberTemplate = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProfileAvatar(
      url,
      cacheImage: true,
      radius: radius,
      backgroundColor: Get.theme.cardColor,
      elevation: 3,
      placeHolder: (context, url) {
        return UiHelper.spinKitProgressIndicator();
      },
      errorWidget: (context, url, error) {
        return buildErrorAndNullUrlWidget();
      },
      child: (url == '') ? buildErrorAndNullUrlWidget() : null,
    );
  }

  Widget buildErrorAndNullUrlWidget() {
    if (isMemberTemplate) {
      return Image.asset(
        AppImages.profilePlaceholderImage,
        fit: BoxFit.contain,
        color: Get.theme.primaryColor,
        colorBlendMode: BlendMode.color,
      );
    }

    return Image.asset(
      AppImages.logoPng,
      fit: BoxFit.contain,
    );
  }
}
