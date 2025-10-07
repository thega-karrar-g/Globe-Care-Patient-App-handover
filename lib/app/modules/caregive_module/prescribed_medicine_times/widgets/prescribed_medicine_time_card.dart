import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../data/models/prescribed_medicine.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';

class PrescribedMedicineTimeCard extends StatelessWidget {
  const PrescribedMedicineTimeCard({Key? key,required this.prescribedMedicine}) : super(key: key);

  final PrescribedMedicine prescribedMedicine;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
     //   print(prescribedMedicine.image);
      },

      child: Container(
       // padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.primaryColorOpacity,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.primaryColor)

        ),
        child: Wrap(children: [

          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          //
          //   decoration: BoxDecoration(
          //     color: AppColors.primaryColor,
          //     borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),
          //
          //   ),
          //
          //
          //   child: Row(children: [
          //    SvgPicture.asset(AppImages.calendar,color: AppColors.white,width: 20.w,height: 20.h,),
          //     UiHelper.horizontalSpaceMedium,
          //     Text('${AppStrings.from.tr} :',style: AppStyles.primaryStyle(color: AppColors.white,bold: true),),
          //
          //     UiHelper.horizontalSpaceTiny,
          //    // Text(DateFormat('dd  MMM  yyyy',Get.locale.toString()).format(DateTime.parse( prescribedMedicine.date)),style: AppStyles.primaryStyle(color: AppColors.white,bold: true),),
          //
          //   UiHelper.horizontalSpaceMedium,
          //     Text('${AppStrings.to.tr} :',style: AppStyles.primaryStyle(color: AppColors.white,bold: true),),
          //
          //     UiHelper.horizontalSpaceTiny,
          //   //Text(DateFormat('dd  MMM  yyyy',Get.locale.toString()).format(DateTime.parse( prescribedMedicine.date)),style: AppStyles.primaryStyle(color: AppColors.white,bold: true),),
          //
          // ],),),
UiHelper.verticalSpaceTiny,
          Padding(
             padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [


                Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 8),
                                decoration: BoxDecoration(
                                 // color:  getColor(prescribedMedicine.status),
                                  borderRadius: BorderRadius.circular(5.h)
                                ),

                                child: Row(
                                  children: [
                                    Text(prescribedMedicine.status.capitalizeFirst!.tr,style: AppStyles.primaryStyle(color: getColor(prescribedMedicine.status),fontSize: 11),),
                                 //   UiHelper.horizontalSpaceTiny,
                                    // if(prescribedMedicine.status =='given')
                                    //
                                    //   Icon(getIcon(prescribedMedicine.status,),color: AppColors.white,size: 15.w,)
                                  ],
                                ),
                              ),


                            ],
                          )


                ],
              ),
            ),
          ),

// ListView.builder(
//   physics: NeverScrollableScrollPhysics(),
//     shrinkWrap: true,
//     itemCount: 5,
//     itemBuilder: (bc,index)=>Container(
// margin: EdgeInsets.symmetric(vertical: 5)
// ,height: 50,color: AppColors.primaryColor,)),


//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ExpandablePanel(
//               theme: const ExpandableThemeData(
//                 headerAlignment:
//                 ExpandablePanelHeaderAlignment.center,
//
//
// //tapBodyToExpand: true,
// //tapBodyToCollapse: true,
//                 hasIcon: false,
//               ),
//
//
//
//               header: Expandable(
//                 collapsed: Container(
//                   padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
//                   decoration: BoxDecoration(
//                   color: AppColors.primaryColor,borderRadius: BorderRadius.circular(5)
//                 ), child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                   Text(AppStrings.showTimes.tr,textAlign: TextAlign.center,style: AppStyles.primaryStyle(color: AppColors.white),),
//                   Icon(Icons.keyboard_arrow_down,color: AppColors.white,)
//                 ],),), // widget header when the widget is Collapsed
//                 expanded:
//
//                 Container(
//                   padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
//                   margin: EdgeInsets.only(bottom: 0),
//                   decoration: BoxDecoration(
//                       color: AppColors.primaryColorGreen,borderRadius: BorderRadius.circular(5)
//                   ), child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(AppStrings.hideTimes.tr,textAlign: TextAlign.center,style: AppStyles.primaryStyle(color: AppColors.white),),
//                     Icon(Icons.keyboard_arrow_up,color: AppColors.white,)
//                   ],),)
//               ),
//               collapsed: Container(), // body when the widget is Collapsed, I didnt need anything here.
//               expanded:  Padding(
//                 padding:  EdgeInsets.symmetric(horizontal: 10.w),
//                 child: Column(children: PrescribedMedicine.dates.map((e) => Container(
//                   margin: EdgeInsets.symmetric(vertical: 5),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: AppColors.primaryColor)
//                   ),
//
//                   padding: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
// Icon(Icons.access_alarm,color: AppColors.primaryColor,),
//                           UiHelper.horizontalSpaceSmall,
//                           Expanded(child: Text(DateFormat('EEE ,yyyy MMM dd  hh:mm a',Get.locale.toString()).format(e),style: AppStyles.primaryStyle(size: 13,height: 1.2),)),
//
//                           if(prescribedMedicine.status !='wait')
//                           Row(
//                             children: [
//                               Container(
//                                 padding: EdgeInsets.symmetric(vertical: 5,horizontal: 8),
//                                 decoration: BoxDecoration(
//                                  // color:  getColor(prescribedMedicine.status),
//                                   borderRadius: BorderRadius.circular(5.h)
//                                 ),
//
//                                 child: Row(
//                                   children: [
//                                     Text(prescribedMedicine.status.capitalizeFirst!.tr,style: AppStyles.primaryStyle(color: getColor(prescribedMedicine.status),size: 11),),
//                                  //   UiHelper.horizontalSpaceTiny,
//                                     // if(prescribedMedicine.status =='given')
//                                     //
//                                     //   Icon(getIcon(prescribedMedicine.status,),color: AppColors.white,size: 15.w,)
//                                   ],
//                                 ),
//                               ),
//
//
//                             ],
//                           )
//                           else
//                               Row(
//                                 children: [
//
//                                   GestureDetector(
//                                     onTap: (){
//                                       DifferentDialog.showThankMsgDialog();
//                                     },
//                                     child: Container(
//                                       padding: EdgeInsets.symmetric(vertical: 5,horizontal: 8),
//                                       decoration: BoxDecoration(
//                                           color:  getColor(prescribedMedicine.status),
//                                           borderRadius: BorderRadius.circular(5.h)
//                                       ),
//
//                                       child: Row(
//                                         children: [
//                                           Text('Done' ,style: AppStyles.primaryStyle(color: AppColors.white,size: 11),),
//                                           UiHelper.horizontalSpaceTiny,
//                                           Icon(getIcon(prescribedMedicine.status,),color: AppColors.white,size: 15.w,)
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//
//
//                                   UiHelper.horizontalSpaceSmall,
//
//                                   GestureDetector(
//                                     onTap: (){
//                                       DifferentDialog.showThankMsgDialog();
//                                     },
//                                     child: Container(
//                                       padding: EdgeInsets.symmetric(vertical: 5,horizontal: 8),
//                                       decoration: BoxDecoration(
//                                           color:  getColor('canceled'),
//                                           borderRadius: BorderRadius.circular(5.h)
//                                       ),
//
//                                       child: Row(
//                                         children: [
//                                           Text(AppStrings.canceled.toLowerCase().tr,style: AppStyles.primaryStyle(color: AppColors.white,size: 11),),
//                                           UiHelper.horizontalSpaceTiny,
//                                           Icon(getIcon('missed'),color: AppColors.white,size: 15.w,)
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               )
//
//
//
//
//
//                         ],
//
//
//                       ),
//
//
//                     ],
//                   ),
//                 )).toList(),),
//               )// body when the widget is Expanded
//           ),
//         ),
          UiHelper.verticalSpaceLarge
        ],),
      ),
    );
  }

}

Color getColor(String status){

  switch (status){
    case 'done':{
      return AppColors.primaryColorGreen;
    }

    case 'given':{
      return AppColors.green;
    }



    case 'missed':{
      return AppColors.red;
    }


    case 'canceled':{
      return AppColors.orange;
    }

    default: return AppColors.primaryColor;
  }

}


IconData getIcon(String status){

  switch(status){

    case 'done':{
      return Icons.send_outlined;
    }

    case 'given':{
      return Icons.check;
    }



    case 'missed':{
      return Icons.close;
    }


    case 'canceled':{
      return Icons.rotate_left_rounded;
    }

    default: return Icons.send;
  }


}
