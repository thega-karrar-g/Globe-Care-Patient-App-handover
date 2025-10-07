import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../data/models/m_doctors.dart';
import '../../../../global_widgets/shared/dynamic_grid.dart';
import '../../../../utils/grid_aspect_ratio.dart';
import 'doctor_item.dart';

class DoctorsGrid extends StatelessWidget {
  DoctorsGrid({this.deptDoctors, Key? key}) : super(key: key);

  final List<DeptDoctor>? deptDoctors;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: deptDoctors!.length,
        itemBuilder: (bc, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.h),
                border: Border.all(color: AppColors.primaryColor, width: 1)),
            child: Wrap(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8.h),
                          topLeft: Radius.circular(8.h))),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        Get.locale.toString() == 'ar'
                            ? deptDoctors![index].nameAr
                            : deptDoctors![index].name,
                        style: AppStyles.whiteStyle(bold: true, size: 13),
                      ))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  child: DynamicGridView(
                      data: deptDoctors![index].doctors,
                      scrollable: false,
                      paddingTop: 10,
                      paddingBottom: 10,
                      count: 1,
                      aspectRatio:
                          GridAspectRatio.aspectRatio(count: 1, height: 140),
                      mainSpacing: 10,
                      crossSpacing: 10,
                      itemBuilder: (item) {
                        return DoctorItemList(
                          doctor: item as Doctor,
                        );
                      }),
                ),
              ],
            ),
          );
        });

    //   GridView.builder(
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //
    //     crossAxisCount: Get.width~/300,
    //     childAspectRatio: GridAspectRatio.aspectRatio(count: Get.width~/300,height: 145),
    //
    //       mainAxisSpacing: 15,
    //     crossAxisSpacing: 15,
    //
    //   ),
    //   itemCount: deptDoctors?.length,
    //   // physics: NeverScrollableScrollPhysics(),
    //   itemBuilder: (bc, index) => TeleDoctorItemList(
    //
    //     doctor: deptDoctors?[index],
    //   ),
    // );
  }
}
