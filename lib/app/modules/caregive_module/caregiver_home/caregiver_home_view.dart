import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:globcare/app/global_widgets/shared/my_appbar.dart';

import '../../../core/assets_helper/app_images.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/models/home_service.dart';
import '../../../global_widgets/shared/dynamic_grid.dart';
import '../../../global_widgets/shared/info_item.dart';
import '../../../global_widgets/shared/line_item.dart';
import '../../../global_widgets/shared/loading.dart';
import '../../../global_widgets/shared/no_data.dart';
import '../../../global_widgets/shared/tab_item.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../core/assets_helper/app_anim.dart';
import '../../../utils/grid_aspect_ratio.dart';
import '../../medical_file_module/medical_file/widgets/medical_file_item.dart';
import 'caregiver_home_logic.dart';

class CaregiverHomePage extends StatelessWidget {
  final logic = Get.put(CaregiverHomeLogic());
  static const routeName='/CaregiverHomePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: UiHelper.safeAreaPaddingHome,
        child: SizedBox(
          // color: AppColors.bodyBgColor.withOpacity(.9),
          child: GetBuilder<CaregiverHomeLogic>(builder: (logic) {
            return Column(
              children: [


                myAppBar2(
                    title: logic.user.name, h: 10),


                UiHelper.verticalSpace(40),


                Row(
                  children: [
                    Expanded(child: TabItem(
                      name: AppStrings.recordInfo, onTab: (){
                      logic.updateIndex(0);
                    },
                      selected: logic.index == 0,
                    )),

                    UiHelper.horizontalSpaceMedium,
                    Expanded(child: TabItem(
                      name: AppStrings.followup, onTab: (){
                      logic.updateIndex(1);
                    },
                      selected: logic.index == 1,
                    )),

                  ],
                ),
                UiHelper.verticalSpace(20),


                if(logic.index==1)
                  Expanded(child:

                      logic.patientRecord ==null  ?NoDataFound(
                        animation: AppAnim.search,
                        msg: AppStrings.noAvailableFiles,
                      ):


                  DynamicGridView(
                    data: logic.services,
                    count: 2,
                    mainSpacing: 50,
                    crossSpacing: 15,

                    aspectRatio: GridAspectRatio.aspectRatio(count: 2,height: 180.h),
                    itemBuilder: (item){
                      var     homeService =item as HomeService;

                      return MedicalFileItem(homeService: homeService,onTab: (){
                        logic.onTabItem(homeService);
                      },);
                    },
                  )
                  ),
                if(logic.index==0)

                  Expanded(
                      child:

                      logic.busy ? MyLoadingWidget() :
                      SingleChildScrollView(
                        child:

                        logic.patientRecord != null ?
                        Wrap(
                          children: <Widget>[


                            InfoItem(title: AppStrings.diagnosis,

                              child: Column(children: [


                                LineItem(text: logic.patientRecord!
                                    .provisionalDiagnosis,
                                  showIcon: false,
                                  icon: AppImages.gender,
                                  showLine: logic.patientRecord!
                                      .provisionalDiagnosis.isNotEmpty,
                                  fontSize: 13,
                                  isFontBold: false,
                                  vPadding: 10,),
                                LineItem(text: logic.patientRecord!
                                    .provisionalDiagnosisAdd,
                                  showIcon: false,
                                  icon: AppImages.gender,
                                  showLine: logic.patientRecord!
                                      .provisionalDiagnosisAdd.isNotEmpty,
                                  fontSize: 13,
                                  isFontBold: false,
                                  vPadding: 10,),
                                LineItem(text: logic.patientRecord!
                                    .provisionalDiagnosisAdd2,
                                  showIcon: false,
                                  icon: AppImages.gender,
                                  showLine: logic.patientRecord!
                                      .provisionalDiagnosisAdd2.isNotEmpty,
                                  fontSize: 13,
                                  isFontBold: false,
                                  vPadding: 10,),
                                LineItem(text: logic.patientRecord!
                                    .provisionalDiagnosisAdd3,
                                  showIcon: false,
                                  icon: AppImages.gender,
                                  showLine: logic.patientRecord!
                                      .provisionalDiagnosisAdd3.isNotEmpty,
                                  fontSize: 13,
                                  isFontBold: false,
                                  vPadding: 10,),


                              ],),
                            ),
                            InfoItem(title: AppStrings.medicalCarePlan,

                              child: Column(children: [

                                LineItem(
                                  text: logic.patientRecord!.medicalCarePlan,
                                  showIcon: false,
                                  icon: AppImages.gender,
                                  showLine: false,
                                  fontSize: 13,
                                  isFontBold: false,
                                  vPadding: 10,),


                              ],),
                            ),
                            InfoItem(title: AppStrings.specialInstructions,

                              child: Column(children: [

                                LineItem(text: logic.patientRecord!
                                    .specialInstructions,
                                  showIcon: false,
                                  icon: AppImages.gender,
                                  showLine: false,
                                  fontSize: 13,
                                  isFontBold: false,
                                  vPadding: 10,),


                              ],),
                            ),


                          ],
                        ) : NoDataFound(
                          animation: AppAnim.search,
                          msg: AppStrings.noAvailableFiles,
                        ),
                      )
                  ),


//           Container(
//             height: 60,
//             margin: EdgeInsets.symmetric(horizontal: 55,vertical: 5),
// //padding: EdgeInsets.symmetric(vertical: 5,),
//             decoration: BoxDecoration(
//               color: Colors.red.withOpacity(0),
//               borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(25), topLeft: Radius.circular(25)),
//               boxShadow: [
//                 BoxShadow(color: AppColors.primaryColor.withOpacity(.20), spreadRadius: 0, blurRadius: 1),
//               ],
//             ),
//
//             child: ClipRRect(
//
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(25.0),
//                 topRight: Radius.circular(25.0),
//               ),
//
//               child: Container(
//                 decoration: BoxDecoration(borderRadius: BorderRadius.only(
//     topLeft: Radius.circular(25.0),
//                   topRight: Radius.circular(25.0),
//
//
//                 ),
//
//                     boxShadow: [
//                       BoxShadow(color: AppColors.primaryColor.withOpacity(.20), spreadRadius: 0, blurRadius: 1),
//                     ],
//                   color: AppColors.white
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(child:                         GestureDetector(
//                         onTap: (){
//                           Get.toNamed(AppRouteNames.homeBooking);
//
//                         },
//                         child: svgIcon( AppImages.tabBook)),),
//                     Expanded(child:                         svgIcon( AppImages.myHome,),),
//                     Expanded(child:                         GestureDetector(
//
//                         onTap: (){
//                           Get.toNamed(AppRouteNames.account);
//                         },
//                         child: svgIcon( AppImages.settingsOut)),),
//                   ],
//                 ),
//               ),
//             ),
//           )

              ],
            );
          }),
        ),
      ),
    );
  }
}
