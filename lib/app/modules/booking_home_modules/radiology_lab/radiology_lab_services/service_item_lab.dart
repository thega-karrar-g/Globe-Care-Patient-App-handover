import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../data/models/nurse_service.dart';
import '../../../../global_widgets/shared/different_dialogs.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';

class ServiceLabItem extends StatelessWidget {
  ServiceLabItem({Key? key, this.nurseService, this.selected = false})
      : super(key: key);

  NurseService? nurseService;
  bool selected;
  bool ar = Get.locale.toString() == 'ar';

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 120,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.primaryColorOpacity,
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 25,
              height: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.primaryColorGreen,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(ar ? 15 : 0),
                    bottomRight: Radius.circular(ar ? 15 : 0),
                    bottomLeft: Radius.circular(ar ? 0 : 15),
                    topLeft: Radius.circular(ar ? 0 : 15),
                  )),
              child: RotatedBox(
                  quarterTurns: 1,
                  child: Text(
                    '${nurseService!.price} ${AppStrings.currency.tr}',
                    style: AppStyles.whiteStyle(size: 12, bold: true),
                  )),
            ),
            UiHelper.horizontalSpaceSmall,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UiHelper.verticalSpaceSmall,
                    Text(
                      ar ? nurseService!.nameAr : nurseService!.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.primaryStyle(
                          bold: true, fontSize: 12, height: 1.5),
                    ),
                    UiHelper.verticalSpaceSmall,
                    Text(
                      ar
                          ? nurseService!.descriptionAr
                          : nurseService!.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.subTitleStyle(size: 11),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Spacer(),

                // Container(
                //   decoration: BoxDecoration(
                //     color: selected?AppColors.primaryColorGreen:AppColors.primaryColorOpacity,
                //     border: Border.all(color:selected?AppColors.white: AppColors.subTitleColor),
                //     borderRadius: BorderRadius.circular(5)
                //   ),
                //
                //   child: Icon(Icons.check,color: selected?AppColors.white:AppColors.primaryColorOpacity,),
                //
                // ),
                Spacer(),

                GestureDetector(
                  onTap: () {
                    DifferentDialog.nurseBottomSheet(
                        serviceName:
                            ar ? nurseService!.nameAr : nurseService!.name,
                        desc: ar
                            ? nurseService!.descriptionAr
                            : nurseService!.description,
                        instructions: ar
                            ? nurseService!.instructionsAr
                            : nurseService!.instructions);
                  },
                  child: Container(
                    height: 35,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(ar ? 0 : 15),
                          topLeft: Radius.circular(ar ? 0 : 15),
                          topRight: Radius.circular(ar ? 15 : 0),
                          bottomLeft: Radius.circular(ar ? 15 : 0),
                        )),
                    child: Text(
                      AppStrings.showMore.tr,
                      style: AppStyles.whiteStyle(bold: true, size: 11),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
