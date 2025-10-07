import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../global_widgets/shared/my_appbar.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';
import '../../../../global_widgets/ui.dart';
import '../../../my_profile_module/members/widgets/reactive_add_member_form.dart';
import '../patient_data_logic.dart';
import 'patient_item.dart';

class SelectPatientWidget extends StatelessWidget {
  const SelectPatientWidget({Key? key,required  this.logic}) : super(key: key);

final  PatientDataLogic logic;
  @override
  Widget build(BuildContext context) {
    return Column(children: [

      if(logic.currentUser !=null && !logic.isSend)

        Row(
          children: [
            Ui.titleGreenUnderLine(
                AppStrings.selectPatient.tr,
                bottomPadding: 8),
          ],
        ),


      Text(AppStrings.ifPatientNotExist.tr,style: AppStyles.primaryStyle(color: AppColors.primaryColorGreen,fontSize: 13),),



      if(logic.currentUser !=null && !logic.isSend)
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: 0, vertical: 10),
          decoration: BoxDecoration(
              color: AppColors.primaryColorOpacity,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // UiHelper.horizontalSpaceMedium,
                      Row(
                        children: logic.members
                            .map((e) => GestureDetector(
                            onTap: () {
                              logic
                                  .updateSelectedPatient(
                                  e);
                            },
                            child: PatientItem(
                              user: e,
                              selected: logic
                                  .selectedPatient !=
                                  null &&
                                  logic.selectedPatient!
                                      .id ==
                                      e.id,
                            )))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
              UiHelper.horizontalSpaceSmall,
              GestureDetector(
                onTap: () {

                  addMemberSheet();

                },
                child: Container(
                  // width: 100.w,
                  padding:
                  EdgeInsets.symmetric(horizontal: 5.w),
                  height: 30.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColorGreen,
                      borderRadius: BorderRadius.only(
                        topRight:
                        Radius.circular(ar ? 5.h : 0),
                        bottomRight:
                        Radius.circular(ar ? 5.h : 0),
                        bottomLeft:
                        Radius.circular(ar ? 0 : 5.h),
                        topLeft:
                        Radius.circular(ar ? 0 : 5.h),
                      )),

                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    crossAxisAlignment:
                    CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: AppColors.white,
                        size: 17.w,
                      ),
                      UiHelper.horizontalSpaceTiny,
                      Text(
                        AppStrings.addNew.tr,
                        textAlign: TextAlign.center,
                        style: AppStyles.whiteStyle(
                            bold: false, size: 11),
                      ),
                      UiHelper.horizontalSpaceTiny,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),



    ],);
  }


  addMemberSheet(){
    Get.bottomSheet(
        Padding(
          padding:
          const EdgeInsets.all(30.0),
          child: AddMemberForm(),
        ),
        isScrollControlled: true,
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.only(
                topLeft:
                Radius.circular(
                    10),
                topRight:
                Radius.circular(
                    10))))
        .then((value) {
      print(
          '***************************   after ');
      logic.fetch();
    });
  }

}
