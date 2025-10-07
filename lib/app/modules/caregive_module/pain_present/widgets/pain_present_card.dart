import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/assets_helper/app_images.dart';
import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../data/models/pain_present.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';
import 'pain_present_item.dart';
class PainPresentCard extends StatelessWidget {
  const PainPresentCard({Key? key,required this.painPresent}) : super(key: key);

  final PainPresent painPresent;
  @override
  Widget build(BuildContext context) {
    return Container(
     // padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.primaryColorOpacity,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primaryColor)

      ),
      child: Column(children: [

        Container(
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),

          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),

          ),


          child: Row(children: [
            SvgPicture.asset(AppImages.calendar,color: AppColors.white,width: 20.w,height: 20.h,),
          UiHelper.horizontalSpaceSmall,
            Text(DateFormat('EEE').format(DateTime.parse( painPresent.date)),style: AppStyles.primaryStyle(color: AppColors.white,bold: true),),

          UiHelper.horizontalSpaceMedium,
          Text(DateFormat('dd  MMM  yyyy  hh:mm a').format(DateTime.parse( painPresent.date)),style: AppStyles.primaryStyle(color: AppColors.white,bold: true),),

        ],),),
UiHelper.verticalSpaceTiny,
        Padding(
           padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          child: Column(
            children: [
              Row(
                children: [

                  PainPresentItem(icon: AppImages.pain,title: 'Score : ',text: painPresent.score,unit: '',),

                ],
              ),
              UiHelper.verticalSpaceSmall,
              Row(
                children: [

                  PainPresentItem(icon: AppImages.scale,title: 'Scale Used : ',text: painPresent.scale,unit: '',),

                ],
              ),
              UiHelper.verticalSpaceSmall,

              Row(
                children: [


                  PainPresentItem(icon: AppImages.comment,title: 'Comment : ',text: painPresent.comment,unit: '',),
                ],
              ),
            ],
          ),
        ),

UiHelper.verticalSpaceSmall
      ],),
    );
  }
}
