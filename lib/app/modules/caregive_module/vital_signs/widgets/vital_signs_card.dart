import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/assets_helper/app_images.dart';
import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../data/models/vital_signs.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'vital_signs_item.dart';
class VitalSignsCard extends StatelessWidget {
  const VitalSignsCard({Key? key,required this.vitalSigns}) : super(key: key);

  final VitalSigns vitalSigns;
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
            Text(DateFormat('EEE').format(DateTime.parse( vitalSigns.date)),style: AppStyles.primaryStyle(color: AppColors.white,bold: true),),

          UiHelper.horizontalSpaceMedium,
          Text(DateFormat('dd  MMM  yyyy  hh:mm a').format(DateTime.parse( vitalSigns.date)),style: AppStyles.primaryStyle(color: AppColors.white,bold: true),),

        ],),),
UiHelper.verticalSpaceMedium,
        Padding(
           padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          child: Column(
            children: [
              Row(
                children: [
                  VitalSignsItem(icon: AppImages.bloodPressure,title: 'B.P',text: '${vitalSigns.bloodPressureSys} / ${vitalSigns.bloodPressureDia}',unit: 'mmHg',),

                  // VitalSignsItem(icon: AppImages.weight,title: 'Weight',text: vitalSigns.weight,unit: 'kg',),
                  UiHelper.horizontalSpaceMedium,
                  VitalSignsItem(icon: AppImages.heartRate,title: 'H.R',text: vitalSigns.heartRate,unit: 'bpm',),

                ],
              ),
              UiHelper.verticalSpaceMedium,

              Row(
                children: [

                  VitalSignsItem(icon: AppImages.temperature,title: 'T',text: vitalSigns.temperature,unit: '°C',),
UiHelper.horizontalSpaceMedium,
                  VitalSignsItem(icon: AppImages.bloodSugar,title: 'B.S',text: vitalSigns.bloodSugar,unit: 'mmol/L',),
                ],
              ),
              UiHelper.verticalSpaceMedium,
              Row(
                children: [
                  VitalSignsItem(icon: AppImages.oxygenSaturation,title: 'O2',text: vitalSigns.oxygenSaturation,unit: '%',),

                  UiHelper.horizontalSpaceMedium,

                  VitalSignsItem(icon: AppImages.respiration,title: 'R',text: vitalSigns.respiration,unit: 'bpm',),
                ],
              ),
            ],
          ),
        ),

        UiHelper.verticalSpaceMedium,

      ],),
    );
  }
}
