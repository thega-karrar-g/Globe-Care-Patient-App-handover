import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:globcare/app/core/assets_helper/app_images.dart';
import 'package:globcare/app/core/language_and_localization/app_strings.dart';
import 'package:globcare/app/core/theme_helper/app_colors.dart';
import 'package:globcare/app/core/theme_helper/app_styles.dart';
import 'package:globcare/app/global_widgets/shared/ui_helpers.dart';

typedef ItemBuilder<T> = Widget Function(
  T item,
);

class DynamicListView<T> extends StatefulWidget {
  final Axis axis;
  final List<dynamic> data;
  final ItemBuilder<dynamic> itemBuilder;
  @override
  final GlobalKey? key;

  DynamicListView(
      {required this.data,
      this.axis = Axis.vertical,
      required this.itemBuilder,
      this.key});

  @override
  _DynamicListViewState createState() => _DynamicListViewState();
}

class _DynamicListViewState<T> extends State<DynamicListView<T>> {
  final duration = 500;
  final delay = 0;

  @override
  Widget build(BuildContext context) {
    return  widget.data.isNotEmpty ? ListView.builder(
      // key:  widget.key?? UniqueKey(),
      key: widget.key,
      scrollDirection: widget.axis,
      itemCount: widget.data.length,
      itemBuilder: (context, index) {
        return AnimationConfiguration.staggeredList(
          position: index,
          //  width: 200,
          //  height: 200,
          duration: Duration(milliseconds: duration),
          delay: Duration(milliseconds: delay),

          // color: Colors.blue[index * 100],
          child: SlideAnimation(
            duration: Duration(milliseconds: duration),
            verticalOffset: 50,
            delay: Duration(milliseconds: 0),
            child: FadeInAnimation(
              duration: Duration(milliseconds: duration),
              delay: Duration(milliseconds: delay),
              curve: Curves.easeInOut,
              child: widget.itemBuilder(
                widget.data[index],
              ),
            ),
          ),
        );
      },
    ):Column(

      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      
      SvgPicture.asset(AppImages.empty,width: 150.w,height: 150.h,color: AppColors.primaryColor,),
      UiHelper.verticalSpaceMedium,
      Text(AppStrings.noDataFound.tr,style: AppStyles.primaryStyle(),)
      
      
    ],);
  }
}
