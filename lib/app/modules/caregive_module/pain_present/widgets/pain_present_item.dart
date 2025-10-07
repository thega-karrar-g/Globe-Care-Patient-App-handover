
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PainPresentItem extends StatelessWidget {
  const PainPresentItem({Key? key,this.icon='',this.title='',this.text='',this.unit=''}) : super(key: key);
final String icon,title,text,unit;
  @override
  Widget build(BuildContext context) {
    return Expanded(
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

                  Text( title,style: AppStyles.primaryStyle(color: AppColors.primaryColorGreen,bold: false,fontSize: 15,height: 1.5)),
                ],
              ),

              Spacer()

            ],
          ),

         Expanded(
           child: Text.rich(TextSpan(text: text,style:AppStyles.primaryStyle(bold: false,color: AppColors.primaryColor,fontSize: 15,height: 1.5) ,children: [
             // WidgetSpan(child: UiHelper.horizontalSpaceSmall),
             // TextSpan(text: text,style: AppStyles.primaryStyle(bold: false,size: 15,height: 1.5)),


           ])),
         ),



        ],),
      ),
    );
  }
}
