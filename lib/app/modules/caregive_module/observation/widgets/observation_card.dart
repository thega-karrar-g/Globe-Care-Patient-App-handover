import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';


import '../../../../core/assets_helper/app_images.dart';
import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../data/models/observation.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';
import '../../prescribed_medicine/widgets/prescribed_medicine_item.dart';


class ObservationCard extends StatelessWidget {
  const ObservationCard({Key? key,required this.observation}) : super(key: key);

  final Observation observation;
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
            Text(DateFormat('EEE').format(DateTime.parse( observation.date)),style: AppStyles.primaryStyle(color: AppColors.white,bold: true),),

          UiHelper.horizontalSpaceMedium,
          Text(DateFormat('dd  MMM  yyyy  hh:mm a').format(DateTime.parse( observation.date)),style: AppStyles.primaryStyle(color: AppColors.white,bold: true),),

        ],),),
UiHelper.verticalSpaceTiny,
        Padding(
           padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          child: Column(
            children: [
              PrescribedMedicineItem(icon: AppImages.food,title: 'Nutritional Status : ',text: observation.nutritionalStatus,unit: '',),
              UiHelper.verticalSpaceSmall,
              PrescribedMedicineItem(icon: AppImages.sleep,title: 'Sleeping Pattern : ',text: observation.sleepingPattern,unit: '',),
              UiHelper.verticalSpaceSmall,


              PrescribedMedicineItem(icon: AppImages.comment,title: 'Progress Noted : ',text: observation.comment,unit: '',),
            ],
          ),
        ),

UiHelper.verticalSpaceSmall
      ],),
    );
  }
}
