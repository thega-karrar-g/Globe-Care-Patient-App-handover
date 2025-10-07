import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_colors.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../data/models/home_service.dart';
import '../../../global_widgets/shared/dynamic_grid.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import '../../../utils/grid_aspect_ratio.dart';
import '../medical_file/widgets/medical_file_item.dart';
import 'member_medical_file_logic.dart';

class MemberMedicalFilePage extends StatelessWidget {
  final logic = Get.put(MemberMedicalFileLogic());

  static const routeName = '/MemberMedicalFilePage';

  MemberMedicalFilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(
      child: SizedBox(
        // color: AppColors.bodyBgColor.withOpacity(.9),
        child: Column(
          children: [
            myAppBar2(title: AppStrings.medicalFile, withBack: true, h: 20),
            UiHelper.verticalSpaceSmall,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                  color: AppColors.primaryColorOpacity,
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    logic.user.name,
                    style: AppStyles.primaryStyle(
                        color: AppColors.primaryColor, fontSize: 16, bold: true),
                  )),
                ],
              ),
            ),
            Expanded(
                child: DynamicGridView(
              data: logic.services,
              count: 2,
              mainSpacing: 50,
              crossSpacing: 15,
              aspectRatio: GridAspectRatio.aspectRatio(count: 2, height: 180.h),
              itemBuilder: (item) {
                var     homeService =item as HomeService;

                return MedicalFileItem(
                  homeService: homeService,
                  onTab: (){
                    Get.toNamed(homeService.route, arguments: homeService);

                  },
                );
              },
            )

                // GridView.builder(
                //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 2,
                //     crossAxisSpacing: 15.0,
                //     mainAxisSpacing: 35.0,
                //     childAspectRatio: GridAspectRatio.aspectRatio(count: 2,height: 240),
                //   ),
                //   itemCount: logic.services.length,
                //   itemBuilder: (bc,index)=>MedicalFileItem(homeService: logic.services[index],),
                //
                //   padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 20),
                //
                //
                //   primary: false,
                //
                // ),

                ),
          ],
        ),
      ),
    );
  }
}
