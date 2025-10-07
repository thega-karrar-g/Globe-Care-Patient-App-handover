import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/theme_helper/app_colors.dart';
import '../../global_widgets/shared/loading.dart';
import '../../global_widgets/shared/ui_helpers.dart';
import '../booking_home_modules/patient_data/widgets/patient_item.dart';
import 'select_patient_logic.dart';

class SelectPatientPage extends StatelessWidget {
  final logic = Get.put(SelectPatientLogic());
  final ScrollController scrollController=ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectPatientLogic>(builder: (logic) {
      return logic.busy
          ? MyLoadingWidget()
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              decoration: BoxDecoration(
                  color: AppColors.primaryColorOpacity,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Expanded(
                    child: RawScrollbar(
                      thumbVisibility: logic.members.length >2 ,
                      controller: scrollController,
                      thumbColor: AppColors.primaryColor.withOpacity(.5),
                      minThumbLength: 150.w,

                      radius: Radius.circular(5.h),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: 5.h),
                        controller: scrollController,
                        scrollDirection: Axis.horizontal,

                        child: Row(
                          children: [
                            // UiHelper.horizontalSpaceMedium,
                            Row(
                              children: logic.members
                                  .map((e) => GestureDetector(
                                      onTap: () {
                                        logic.updateSelectedPatient(e);
                                      },
                                      child: PatientItem(
                                        user: e,
                                        selected:
                                            SelectPatientLogic.selectedPatient !=
                                                    null &&
                                                SelectPatientLogic
                                                        .selectedPatient!.id ==
                                                    e.id,
                                      )))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  UiHelper.horizontalSpaceSmall,
                  // GestureDetector(
                  //   onTap: () {
                  //     Get.bottomSheet(Padding(
                  //       padding: const EdgeInsets.all(30.0),
                  //       child: AddMemberForm(),
                  //     ),
                  //         isScrollControlled: true,
                  //
                  //         backgroundColor: AppColors.white,
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.only(
                  //                 topLeft: Radius.circular(10),
                  //                 topRight: Radius.circular(10))
                  //         )
                  //     ).then((value) {
                  //       print('***************************   after ');
                  //       logic.fetch();
                  //     });
                  //   },
                  //   child: Container(
                  //     // width: 100.w,
                  //     padding: EdgeInsets.symmetric(horizontal: 5.w),
                  //     height: 30.h,
                  //     alignment: Alignment.center,
                  //     decoration: BoxDecoration(
                  //         color: AppColors.primaryColorGreen,
                  //         borderRadius: BorderRadius.only(
                  //           topRight: Radius.circular(ar ? 5.h : 0),
                  //           bottomRight: Radius.circular(ar ? 5.h : 0),
                  //
                  //           bottomLeft: Radius.circular(ar ? 0 : 5.h),
                  //           topLeft: Radius.circular(ar ? 0 : 5.h),
                  //
                  //
                  //         )
                  //     ),
                  //
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //
                  //         Icon(Icons.add, color: AppColors.white, size: 17.w,),
                  //         UiHelper.horizontalSpaceTiny,
                  //         Text(AppStrings.addNew.tr, textAlign: TextAlign.center,
                  //           style: AppStyles.whiteStyle(bold: false, size: 11),),
                  //
                  //         UiHelper.horizontalSpaceTiny,
                  //
                  //       ],
                  //     ),
                  //
                  //   ),
                  // )
                  // ,
                ],
              ),
            );
    });
  }
}
