
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';

class ObservationItem extends StatelessWidget {
  const ObservationItem({Key? key,this.icon='',this.title='',this.text='',this.unit=''}) : super(key: key);
final String icon,title,text,unit;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: IntrinsicHeight(
            child: Row(children: [

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: 18.w,
                          child: SvgPicture.asset(icon,width: 18.w,height: 20.h,color: AppColors.primaryColorGreen,fit: BoxFit.fill,)),
UiHelper.horizontalSpaceSmall,

                      Text( title,style: AppStyles.primaryStyle(color: AppColors.primaryColorGreen,bold: false,fontSize: 13,height: 1.5)),
                    ],
                  ),

                  Spacer()

                ],
              ),

             Expanded(
               child: Text.rich(TextSpan(text: text,style:AppStyles.primaryStyle(bold: false,color: AppColors.primaryColor,fontSize: 13,height: 1.5) ,children: [
                 WidgetSpan(child: UiHelper.horizontalSpaceSmall),
                 TextSpan(text: unit,style: AppStyles.primaryStyle(bold: false,color: AppColors.primaryColorGreen,fontSize: 12,height: 1.5)),


               ])),
             ),



            ],),
          ),
        ),
      ],
    );
  }
}
