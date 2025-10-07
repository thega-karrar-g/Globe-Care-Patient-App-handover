import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:globcare/app/global_widgets/shared/ui_helpers.dart';

import '../../../core/assets_helper/app_images.dart';
import '../../../core/theme_helper/app_colors.dart';
import '../../../data/models/slides_model.dart';
import '../../../global_widgets/project_widget/image_widget/cached_image_widget.dart';




class ImageSliderWidget extends StatefulWidget {
  final double height;
  final bool isFromLocalAssets;
  final List<SliderModel> sliders;
  final double radius;
  final VoidCallback? onImageTap;

  const ImageSliderWidget({
    Key? key,
    this.height = 140,
    required this.sliders,
    this.radius = 16.0,
    this.onImageTap,
    this.isFromLocalAssets = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<ImageSliderWidget> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          margin: EdgeInsets.all(1.0),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.radius),

          ),
          color: Colors.white,
          child: CarouselSlider(
            carouselController: _controller,

            options: CarouselOptions(
              height: widget.height.h,

              autoPlay: true,
              // pageSnapping: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              viewportFraction:
                  listIsNotEmptyAndHasMoreThanOneItem ? 1 : 1.0,
              // disableCenter: true,
              enableInfiniteScroll: listIsNotEmptyAndHasMoreThanOneItem,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            items: widget.sliders.isNotEmpty
                ? widget.sliders
                    .map(
                      (e) => RectangularCachedImage(
                        height: widget.height.h,
                        imageUrl: e.image,
                        width: double.infinity,
                        radius: 10,

                        // onTap: onImageTap,
                        // placeHolderPath: AppImages.logoInSlider,
                        fit: BoxFit.cover,
                        // backGroundColor: Colors.white,
                      ),
                    )
                    .toList()
                : [
                    Image.asset(
                      AppImages.logoOnly,
                      width: double.infinity,
                    )
                  ],

          ),
        ),
        if (listIsNotEmptyAndHasMoreThanOneItem)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.sliders.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: CircleAvatar(
                  radius: 4.0.r,
                  backgroundColor: _current == entry.key
                      ? AppColors.sliderActive
                      : AppColors.sliderDisable,
                ).marginSymmetric(
                  vertical: 8.0.h,
                  horizontal: 2.0.w,
                ),
              );
            }).toList(),
          ),

        UiHelper.verticalSpaceMedium,

      ],
    );
  }

  bool get listIsNotEmptyAndHasMoreThanOneItem {
    return widget.sliders.isNotEmpty && widget.sliders.length > 1;
  }
}

// class ImageSlider extends StatelessWidget {
//   final double? height;
//   final List<String> imageUrl;
//   final double radius;
//   final VoidCallback? onImageTap;
//
//   const ImageSlider({
//     Key? key,
//     this.height,
//     this.imageUrl,
//     this.radius = 16.0,
//     this.onImageTap,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return
//         // Container(
//         // height: height,
//         // width: double.infinity,
//         // clipBehavior: Clip.antiAlias,
//         // decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius)),
//         // child:
//         CarouselSlider(
//       options: CarouselOptions(
//         height: height,
//         // viewportFraction: 1
//       ),
//       items: imageUrl.isNotEmpty
//           ? imageUrl
//               .map(
//                 (e) => RectangularCachedImage(
//                   height: 150,
//                   imageUrl: e,
//                   width: double.infinity,
//                   // onTap: onImageTap,
//                   fit: BoxFit.cover,
//                 ),
//               )
//               .toList()
//           : [
//               Image.asset(
//                 AppImages.logoPng,
//                 width: double.infinity,
//                 height: 150,
//               )
//             ],
//       // dotSize: 3.0,
//       // showIndicator:
//       //     imageUrl?.length == 1 || (imageUrl?.isEmpty ?? true) ? false : true,
//       // boxFit: BoxFit.fitWidth,
//       // dotSpacing: 16.0,
//       // dotHorizontalPadding: 100,
//       // dotVerticalPadding: 4,
//       // onImageTap: (int index) {
//       //   if (onImageTap != null) {
//       //     onImageTap?.call();
//       //     return;
//       //   }
//       // else {
//       //   Get.toNamed(
//       //     MediaDetailsPageView.id,
//       //     parameters: {FieldsQueryBy.imageUrl: imageUrl[index]},
//       //   );
//       //   return;
//       // }
//       // },
//       // animationCurve: Curves.easeInOut,
//       // dotColor: Colors.white,
//       // dotIncreasedColor: Get.theme.primaryColor,
//       // dotBgColor: Colors.transparent,
//       // indicatorBgPadding: 5.0,
//     );
//     // );
//   }
// }
