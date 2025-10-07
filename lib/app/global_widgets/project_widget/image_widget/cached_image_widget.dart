import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/assets_helper/app_images.dart';
import '../../shared/ui_helpers.dart';

class RectangularCachedImage extends StatelessWidget {
  const RectangularCachedImage({
    Key? key,
    required this.imageUrl,
    this.height,
    this.fit,
    this.width,
    this.radius,
    this.placeholder,
    this.showErrText = false,
  }) : super(key: key);

  final String imageUrl;
  final Widget? placeholder;
  final double? height;
  final BoxFit? fit;
  final double? width;
  final double? radius;
  final bool showErrText;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 0),
          image: DecorationImage(
            image: imageProvider,
            fit: fit ?? BoxFit.cover,
          ),
        ),
      ),
      imageUrl: imageUrl,
      fit: fit ?? BoxFit.cover,
      errorWidget: (context, url, error) => SizedBox(
        height: height,
        width: width ?? double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Image.asset(AppImages.logoOnly,width: 100.w,height: 100.h,),

              Visibility(
                visible: showErrText,
                child: Text(
                  error.toString(),
                ),
              )
            ],
          ),
        ),
      ),
      placeholder: (context, url) => SizedBox(
        height: height,
        width: width ?? double.infinity,
        child: placeholder ??
            Center(
              child: UiHelper.spinKitProgressIndicator(),
            ),
      ),
    );
  }
}
