import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme_helper/app_colors.dart';
import '../../core/theme_helper/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/assets_helper/app_images.dart';
import 'ui_helpers.dart';
class LineItem extends StatelessWidget {
   LineItem({Key? key,required  this.text,this.icon=AppImages.email,this.fontSize=16,this.vPadding=0,this.isFontBold=false,this.showLine=true,this.showIcon=true}) : super(key: key);
final String text,icon;
final bool showLine,showIcon,isFontBold;
final double fontSize,vPadding;
  @override
  Widget build(BuildContext context) {
    return  text.isNotEmpty? Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: vPadding.h),
      child: Column(children: [


        Row(
          children: [
            if(showIcon)
            SvgPicture.asset(icon,width: 20.w,height: 20.h,color: AppColors.primaryColorGreen,),

            if(showIcon)
           UiHelper.horizontalSpaceSmall,
           // Text('-',style: AppStyles.primaryStyle(bold: true),),
            Expanded(child: Text(text,style: AppStyles.primaryStyle(fontSize: fontSize,bold: isFontBold,opacity: .8),)),
          ],
        ),

        if(showLine)

          UiHelper.verticalSpaceTiny,

        if(showLine)
        DottedLine(
          direction: Axis.horizontal,
          lineLength: double.infinity,
          lineThickness: 1.0,
          dashLength: 4.0,
          dashColor: AppColors.primaryColorGreen,
         // dashGradient: [Colors.red, Colors.blue],
          dashRadius: 0.0,
          dashGapLength: 4.0,
          dashGapColor: Colors.transparent,
         // dashGapGradient: [Colors.red, Colors.blue],
          dashGapRadius: 0.0,
        )

      ],),
    ):SizedBox();
  }
}
