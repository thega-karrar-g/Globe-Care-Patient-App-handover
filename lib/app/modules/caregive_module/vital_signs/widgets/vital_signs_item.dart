
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VitalSignsItem extends StatelessWidget {
  const VitalSignsItem({Key? key,this.icon='',this.title='',this.text='',this.unit=''}) : super(key: key);
final String icon,title,text,unit;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(children: [

        SizedBox(
            width: 18.w,
            child: SvgPicture.asset(icon,width: 18.w,height: 20.h,color: AppColors.primaryColor,fit: BoxFit.fill,)),
UiHelper.horizontalSpaceSmall,
       Expanded(
         child: Text.rich(TextSpan(text: title,style:AppStyles.primaryStyle(bold: true,color: AppColors.subTitleColor,fontSize: 11) ,children: [
           WidgetSpan(child: UiHelper.horizontalSpaceSmall),
           TextSpan(text: text,style: AppStyles.primaryStyle(bold: true)),
           WidgetSpan(child: UiHelper.horizontalSpaceSmall),
           TextSpan(text: unit,style: AppStyles.primaryStyleGreen()),


         ])),
       ),



      ],),
    );
  }
}
