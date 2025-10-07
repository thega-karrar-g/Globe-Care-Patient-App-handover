import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../global_widgets/shared/loading.dart';
import '../../../../global_widgets/shared/my_appbar.dart';
import '../../../../global_widgets/shared/no_data.dart';
import '../../../../global_widgets/ui.dart';
import '../../../../routes/app_route_names.dart';
import '../../../../core/assets_helper/app_anim.dart';
import '../doctors_controller.dart';
import '../widgets/doctors_grid.dart';

class DoctorsPage extends GetView<DoctorsController> {
  @override
  final controller = Get.put(DoctorsController());

  DoctorsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    PaintingBinding.instance.imageCache.clear();


    // DifferentDialog.showServiceInfoSnackBar(description:controller. slide.description!.tr,title:controller. slide.title!.tr,image: controller.slide.image!);
//DifferentDialog.showPaymentSuccessDialog(msg: '');
    return Ui.myScaffold(child: GetBuilder<DoctorsController>(builder: (logic) {
      return Column(
        children: [
          myAppBarServices(
              title: DoctorsController.doctorType != 'TD'
                  ? AppStrings.homeVisitDoctor.tr.capitalize.toString()
                  : AppStrings.telemedicine.tr.capitalize!,
              code: DoctorsController.doctorType != 'TD' ? 'HVD' : 'TD',onBack: (){
            Get.offAllNamed(AppRouteNames.homeTabs);

          }),
          // UiHelper.verticalSpace(20),
          // if(DoctorsController.doctorType=='TD')
          // SizedBox(
          //   height: 70,
          //   child: Row(children: [
          //
          //     Expanded(
          //       child: Container(
          //         margin: EdgeInsets.symmetric(vertical: 10),
          //         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          //         decoration: BoxDecoration(color: AppColors.primaryColorOpacity,borderRadius: BorderRadius.circular(15)),
          //         child: Row(children: [
          //           UiHelper.horizontalSpaceSmall,
          //
          //           SvgPicture.asset(AppImages.search),
          //           UiHelper.horizontalSpace(15),
          //           Expanded(
          //             child: TextFormField(
          //               style: AppStyles.subTitleStyle(size: 15),
          //
          //               decoration:InputDecoration(
          //                   hintText: AppStrings.search.tr,
          //                 border: Ui.outlineInputBorder,
          //                 focusedBorder: Ui.outlineInputBorder,
          //                 enabledBorder: Ui.outlineInputBorder,
          //                 errorBorder: Ui.outlineInputBorder,
          //                 focusedErrorBorder: Ui.outlineInputBorder,
          //                 hintStyle: AppStyles.subTitleStyle(size: 15),
          //                 labelStyle: AppStyles.subTitleStyle(size: 15),
          //
          //
          //               ),
          //               onChanged: (t){
          //                 logic.search(txt: t);
          //               },
          //
          //             ),
          //           ),
          //
          //
          //         ],),
          //
          //       )
          //
          //       ,
          //     ),
          //     UiHelper.horizontalSpace(16),
          //     GestureDetector(
          //         onTap: (){
          //           DifferentDialog.doctorsFilterBottomSheet(specialties: controller.specialties,);
          //
          //         },
          //
          //         child: SvgPicture.asset(AppImages.filter,)),
          //
          //   ],),
          // ),

// UiHelper.verticalSpace(20),
//           if(DoctorsController.doctorType!='TD')
//
//             Row(children: [
//
//
//
//               TabItem(name: AppStrings.general,selected: logic.isGeneral, onTab: (){
//
//                 logic.updateGeneral(general: true);
//
//               }),
//
//               UiHelper.horizontalSpaceMedium,
//
//
//
//               TabItem(name: AppStrings.specialist,selected: !logic.isGeneral, onTab: (){
//
//                 logic.updateGeneral(general: false);
//
//               }),
//
//
//
//
//
//
//
//             ],),

          logic.noInternetConnection()
              ? NoDataFound(
                  animation: AppAnim.noInternet,
                  msg: AppStrings.checkInternet,
                )
              : Expanded(
                  child: logic.busy
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            MyLoadingWidget(),
                          ],
                        )
                      : logic.deptDoctors.isNotEmpty
                          ? DoctorsGrid(
                              deptDoctors: logic.deptDoctors,
                            )
                          : NoDataFound(
                              animation: AppAnim.noDoctor,
                              msg: AppStrings.noAvailableDoctors,
                            ))
        ],
      );
    }));
  }

// void dispose() {
//   Get.delete<DoctorsController>();
// }
}
