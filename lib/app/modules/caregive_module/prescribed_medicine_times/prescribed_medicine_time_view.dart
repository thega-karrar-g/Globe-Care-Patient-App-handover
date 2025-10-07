import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:intl/intl.dart';

import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_colors.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../data/models/prescribed_medicine.dart';
import '../../../global_widgets/shared/bottom_sheet_line.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import 'prescribed_medicine_time_logic.dart';
import 'widgets/prescribed_medicine_time_card.dart';

class PrescribedMedicineTimePage extends StatelessWidget {
  final logic = Get.put(PrescribedMedicineTimeLogic());
  static const routeName = '/PrescribedMedicineTimePage';

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(
        child: GetBuilder<PrescribedMedicineTimeLogic>(builder: (logic) {
          return Column(children: [

            myAppBar2(title: logic.medicine.medicine,),

            // Row(children: [
            //
            //   Expanded(
            //     child: TabItem(name: AppStrings.today,
            //         selected: logic.medicineStatus == logic.states[0],
            //         fontSize: 13,
            //         onTab: () {
            //           logic.updateMedicineStatus(logic.states[0]);
            //         }),
            //   ),
            //
            //   Expanded(
            //     child: TabItem(name: AppStrings.given,
            //         fontSize: 13,
            //
            //         selected: logic.medicineStatus == logic.states[1],
            //         onTab: () {
            //           logic.updateMedicineStatus(logic.states[1]);
            //         }),
            //   ),
            //
            //   Expanded(
            //     child: TabItem(name: AppStrings.canceled,
            //         fontSize: 13,
            //
            //         selected: logic.medicineStatus == logic.states[2],
            //         onTab: () {
            //           logic.updateMedicineStatus(logic.states[2]);
            //         }),
            //   ),
            //   Expanded(
            //     child: TabItem(name: AppStrings.missed,
            //         fontSize: 13,
            //
            //         selected: logic.medicineStatus == logic.states[3],
            //         onTab: () {
            //           logic.updateMedicineStatus(logic.states[3]);
            //         }),
            //   ),
            //
            //
            // ],),

            Expanded(child: logic.busy?UiHelper.spinKitProgressIndicator():

            RefreshIndicator(
                onRefresh: ()=>logic.getData(),



                child:

                GroupListView(
                  sectionsCount: logic.medicinesGroup.length,
                  countOfItemInSection: (int section) {
                    return logic.medicinesGroup[section].items.length;
                  },
                  itemBuilder: (BuildContext context, IndexPath index) {

                    var e=logic.medicinesGroup[index.section].items[index.index];
                    var d=     DateTime.tryParse('${e.date} ${e.time}');

var allowed=  d !=null  && d.difference(DateTime.now()).inMinutes<30;


                    return
                      Container(

                    margin: EdgeInsets.symmetric(vertical: 5),

                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(10),

                      border: Border.all(color: AppColors.primaryColor)

                    ),



                    padding: EdgeInsets.symmetric(vertical: 15,horizontal: 5),

                    child: Column(

                      children: [

                        Row(

                          children: [

  Icon(Icons.access_alarm,color: AppColors.primaryColor,),

                            UiHelper.horizontalSpaceSmall,

                            Expanded(child: Text(DateFormat('hh:mm a',Get.locale.toString()).format(DateTime.parse('${e.date} ${e.time}')),style: AppStyles.primaryStyle(fontSize: 13,bold: true,height: 1.2),)),





                                Row(

                                  children: [



                                    if(e.status=='given')
                                      GestureDetector(

                                        onTap: (){

                                         // showGivenSheet(e);
                                          // logic.updateStatus(e.id.toString());
                                          // DifferentDialog.showThankMsgDialog();

                                        },

                                        child: Container(

                                          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 8),

                                          decoration: BoxDecoration(

                                              color:  getColor(e.status),

                                              borderRadius: BorderRadius.circular(5.h)

                                          ),



                                          child: Row(

                                            children: [

                                              Text(AppStrings.given ,style: AppStyles.primaryStyle(color: AppColors.white,fontSize: 11),),

                                              UiHelper.horizontalSpaceTiny,

                                              Icon(Icons.check,color: AppColors.white,size: 15.w,)

                                            ],

                                          ),

                                        ),

                                      ),
   if(e.status=='missed')
                                      GestureDetector(

                                        onTap: (){

                                         // showGivenSheet(e);
                                          // logic.updateStatus(e.id.toString());
                                          // DifferentDialog.showThankMsgDialog();

                                        },

                                        child: Container(

                                          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 8),

                                          decoration: BoxDecoration(

                                              color:  getColor(e.status),

                                              borderRadius: BorderRadius.circular(5.h)

                                          ),



                                          child: Row(

                                            children: [

                                              Text(AppStrings.missed.tr ,style: AppStyles.primaryStyle(color: AppColors.white,fontSize: 11),),

                                              UiHelper.horizontalSpaceTiny,

                                              Icon(Icons.timer_off_outlined,color: AppColors.white,size: 15.w,)

                                            ],

                                          ),

                                        ),

                                      ),
 if(e.status=='canceled')

                                      GestureDetector(

                                        onTap: (){

                                         // showGivenSheet(e);
                                          // logic.updateStatus(e.id.toString());
                                          // DifferentDialog.showThankMsgDialog();

                                        },

                                        child: Container(

                                          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 8),

                                          decoration: BoxDecoration(

                                              color:  getColor(e.status),

                                              borderRadius: BorderRadius.circular(5.h)

                                          ),



                                          child: Row(

                                            children: [

                                              Text(AppStrings.canceledWithReason.tr ,style: AppStyles.primaryStyle(color: AppColors.white,fontSize: 11),),

                                              UiHelper.horizontalSpaceTiny,

                                              Icon(Icons.cancel_outlined,color: AppColors.white,size: 15.w,)

                                            ],

                                          ),

                                        ),

                                      ),




//                                     if(e.status=='')
//                                     GestureDetector(
//
//                                       onTap: (){
//
//
//                                    var d=     DateTime.tryParse('${e.date} ${e.time}');
//
//                                   if(d !=null){
//
// var dd=d.difference(DateTime.now()).inMinutes;
//
// // print(dd);
//                                     if(d.difference(DateTime.now()).inMinutes<30){
//
//                                       showGivenSheet(e);
//
//                                     }
//                                     else{
//                                       logic.buildFailedSnackBar(msg: 'The remaining time of given must be less than 30 minutes');
//
//                                     }
//
//                                   }
//                                   else{
//                                     logic.buildFailedSnackBar(msg: 'invalid date');
//                                   }
//
//
//
//
//
//                                         // logic.updateStatus(e.id.toString());
//                                        // DifferentDialog.showThankMsgDialog();
//
//                                       },
//
//                                       child: Container(
//
//                                         padding: EdgeInsets.symmetric(vertical: 5,horizontal: 8),
//
//                                         decoration: BoxDecoration(
//
//                                             color: allowed? getColor(e.status): AppColors.txtDead,
//
//                                             borderRadius: BorderRadius.circular(5.h)
//
//                                         ),
//
//
//
//                                         child: Row(
//
//                                           children: [
//
//                                             Text('Done' ,style: AppStyles.primaryStyle(color: AppColors.white,size: 11),),
//
//                                             UiHelper.horizontalSpaceTiny,
//
//                                             Icon(getIcon(e.status,),color: AppColors.white,size: 15.w,)
//
//                                           ],
//
//                                         ),
//
//                                       ),
//
//                                     ),
//
//
//
//
//
//                                     UiHelper.horizontalSpaceSmall,
//
//
//                                     if(e.status=='')
//
//                                     GestureDetector(
//
//                                       onTap: (){
//
//
//
//                                         var d=     DateTime.tryParse('${e.date} ${e.time}');
//
//                                         if(d !=null){
//
//                                           var dd=d.difference(DateTime.now()).inMinutes;
//
// // print(dd);
//                                           if(d.difference(DateTime.now()).inMinutes<30){
//
//                                             showCancelSheet(e);
//
//                                           }
//                                           else{
//                                             logic.buildFailedSnackBar(msg: 'The remaining time of cancel must be less than 30 minutes');
//
//                                           }
//
//                                         }
//                                         else{
//                                           logic.buildFailedSnackBar(msg: 'invalid date');
//                                         }
//
//                                       },
//
//                                       child: Container(
//
//                                         padding: EdgeInsets.symmetric(vertical: 5,horizontal: 8),
//
//                                         decoration: BoxDecoration(
//
//                                             color: allowed? getColor('canceled'):AppColors.txtDead,
//
//                                             borderRadius: BorderRadius.circular(5.h)
//
//                                         ),
//
//
//
//                                         child: Row(
//
//                                           children: [
//
//                                             Text(AppStrings.cancel.toLowerCase().tr,style: AppStyles.primaryStyle(color: AppColors.white,size: 11),),
//
//                                             UiHelper.horizontalSpaceTiny,
//
//                                             Icon(getIcon('missed'),color: AppColors.white,size: 15.w,)
//
//                                           ],
//
//                                         ),
//
//                                       ),
//
//                                     ),

                                  ],

                                )











                          ],





                        ),





                      ],

                    ),

                  );


                  },

                  groupHeaderBuilder: (BuildContext context, int section) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                      child: Text(
                        logic.dateConverter(
                            logic.medicinesGroup[section].dateTime).tr,
                        style: AppStyles.primaryStyle(bold: false,fontSize: 15),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 2.h),
                  sectionSeparatorBuilder: (context, section) => SizedBox(height: 5.h),
                )



//                          ListView.builder(
//
//                             itemCount: logic.currentAppointments.length,
//                             itemBuilder: (bc,index){
//
//                           return OdooAppointmentItem(appointment: logic.currentAppointments[index],onMapTab: (){
// var leftTime=logic.currentAppointments[index].appointmentDate.difference(DateTime.now()).inMinutes;
//                             if(leftTime<32 && leftTime >=0)
//                            {
//                              Get.toNamed(LocationDirectionPage.routeName,arguments:logic.currentAppointments[index] );
//                            }
//
//                             else{
//                               logic.buildFailedSnackBar(msg: AppStrings.trackNotAllowedNow.tr);
//                             }
//
//                           },);
//
//                       }).paddingOnly(bottom: 20.h),
            )
            )


          ],);
        }),

        // floatingAction: FloatingActionButton(
        //   backgroundColor: AppColors.primaryColor,
        //   onPressed: () {},
        //   child: Icon(Icons.add, color: AppColors.white,),
        // )
    );
  }


  showGivenSheet(PrescribedMedicine medicine){
    Get.bottomSheet(
        StatefulBuilder(
            builder: (context,StateSetter setState) {
              return SizedBox(
                height: Get.height*.3,
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(

                    children: [

                      UiHelper.verticalSpaceLarge,

                      Text( 'Are you sure you give the  patient   ',textAlign: TextAlign.center,style: AppStyles.primaryStyle(bold: false,fontSize: 16,color: AppColors.primaryColor)),
                      Text( '\n ${logic.medicine.medicine}  \n ',textAlign: TextAlign.center,style: AppStyles.primaryStyle(bold: true,fontSize: 18,color: AppColors.primaryColorGreen)),
                      Text( 'at ${medicine.date}     ${medicine.time}   ',textAlign: TextAlign.center,style: AppStyles.primaryStyle(bold: false,fontSize: 16,color: AppColors.primaryColor)),


                      UiHelper.verticalSpaceSmall,

                    //  Text(medicine.medicine,style: AppStyles.primaryStyle(bold: true,size: 16,color: AppColors.primaryColorGreen) ),



                      UiHelper.verticalSpaceMedium,
                      Ui.primaryButton(title: 'Yes',color: AppColors.primaryColorGreen,paddingV: 10,paddingH: 10,marginV: 5,marginH: 30,

                          onTab: (){

                        logic.updateStatus(medicine.id.toString());
                           // removeDevice(scannedDevice);
                          }


                      ),


                    ],

                  ),
                ),
              );
            }
        ),
        isScrollControlled: true,
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.h)
        )
    );

  }
  showCancelSheet(PrescribedMedicine medicine){
    Get.bottomSheet(
        StatefulBuilder(
            builder: (context,StateSetter setState) {
              return SizedBox(
                height: Get.height*.5,
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.w),
                  child: SingleChildScrollView(
                    child: Column(

                      children: [

                        UiHelper.verticalSpaceLarge,

                        Text( 'Are you sure you want to cancel    ',textAlign: TextAlign.center,style: AppStyles.primaryStyle(bold: false,fontSize: 16,color: AppColors.primaryColor)),
                        Text( '\n ${logic.medicine.medicine}  \n ',textAlign: TextAlign.center,style: AppStyles.primaryStyle(bold: true,fontSize: 18,color: AppColors.primaryColorGreen)),
                        Text( 'at ${medicine.date}     ${medicine.time}   ',textAlign: TextAlign.center,style: AppStyles.primaryStyle(bold: false,fontSize: 16,color: AppColors.primaryColor)),


                        UiHelper.verticalSpaceSmall,

                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.primaryColorOpacity,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            children: [
                              BottomSheetLine(title: 'Reason:',length: 5000,height: 100, paddingH: 10,controller: logic.reasonCtrl,isMultLine: true,unit: '',),
                            ],
                          ),
                        ),
                        UiHelper.verticalSpaceMedium,



                        //  Text(medicine.medicine,style: AppStyles.primaryStyle(bold: true,size: 16,color: AppColors.primaryColorGreen) ),



                        UiHelper.verticalSpaceMedium,
                        Ui.primaryButton(title: 'Yes',color: AppColors.primaryColorGreen,paddingV: 10,paddingH: 10,marginV: 5,marginH: 30,

                            onTab: (){


                          if(logic.reasonCtrl.text.toString().trim().isNotEmpty){
                          logic.updateStatus(medicine.id.toString(),state: 'canceled');}

                          else{
                            logic.buildFailedSnackBar(msg: 'Reason must not be empty ');
                          }
                             // removeDevice(scannedDevice);


                            }


                        ),


                      ],

                    ),
                  ),
                ),
              );
            }
        ),
        isScrollControlled: true,
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.h)
        )
    );

  }


}
