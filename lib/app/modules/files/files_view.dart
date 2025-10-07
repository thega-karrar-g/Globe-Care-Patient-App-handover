import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:group_list_view/group_list_view.dart';

import '../../core/language_and_localization/app_strings.dart';
import '../../core/theme_helper/app_colors.dart';
import '../../core/theme_helper/app_styles.dart';
import '../../global_widgets/shared/loading.dart';
import '../../global_widgets/shared/my_appbar.dart';
import '../../global_widgets/shared/no_data.dart';
import '../../global_widgets/shared/tab_item.dart';
import '../../global_widgets/shared/ui_helpers.dart';
import '../../global_widgets/ui.dart';
import '../../core/assets_helper/app_anim.dart';
import '../../utils/download_controller.dart';
import 'files_logic.dart';
import 'widgets/file_item.dart';

class FilesPage extends StatelessWidget {
  final logic = Get.put(FilesLogic());
  final download = Get.put(DownloadController());

   FilesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(child: GetBuilder<FilesLogic>(builder: (logic) {
      return Column(
        children: [
          myAppBar2(
            title: logic.title,
          ),
          logic.busy
              ? MyLoadingWidget()
              : Expanded(
                  child: Column(
                    children: [
                      UiHelper.verticalSpaceSmall,



                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        decoration: BoxDecoration(
                            color: AppColors.primaryColorOpacity,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              logic.user.name,
                              style: AppStyles.primaryStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 16,
                                  bold: true),
                            )),
                          ],
                        ),
                      ),
                      logic.isLabOrImage
                          ? UiHelper.verticalSpaceLarge
                          : UiHelper.verticalSpaceSmall,
                      if (logic.isLabOrImage)
                        Container(
                          // height: 60,
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: Row(
                            children: [
                              Spacer(),

                              //  UiHelper.horizontalSpaceMedium,
                              TabItem(
                                  name: logic.isLab
                                      ? AppStrings.labRequests
                                      : AppStrings.imageRequests,
                                  fontSize: 16,
                                  selected: logic.isRequest,
                                  onTab: () {
                                    logic.updateLabImageStatus(isRequestValue: true);
                                  }),
                              Spacer(),
                              TabItem(
                                  name: logic.isLab
                                      ? AppStrings.labResult
                                      : AppStrings.imageResult,
                                  fontSize: 16,
                                  selected: logic.isRequest == false,
                                  onTab: () {
                                    logic.updateLabImageStatus(isRequestValue: false);
                                  }),
                              Spacer(),

                              // UiHelper.horizontalSpaceMedium,
                            ],
                          ),
                        ),
                      UiHelper.verticalSpaceSmall,
                      Expanded(
                          child: (logic.granted)
                              ? logic.filesGroup.isNotEmpty
                                  ?

                          // DynamicListView(
                          //             //key: logic.key,
                          //             data: logic.filesGroup,
                          //             itemBuilder: (item) => FileItem(
                          //                   myFile: item as MyFile,
                          //                   dir: logic.dir,
                          //                   logic: logic,
                          //                 ))

                          GroupListView(
                            sectionsCount: logic.filesGroup.length,
                            countOfItemInSection: (int section) {
                              return logic.filesGroup[section].files.length;
                            },
                            itemBuilder: (BuildContext context, IndexPath index) {
                              return

                              FileItem(
                                                file:logic.filesGroup[index.section].files[index.index] ,
                                                dir: logic.dir,
                                                logic: logic,
                                              );                            },

                            groupHeaderBuilder: (BuildContext context, int section) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                child: Text(
                                  logic.dateConverter(
                                      logic.filesGroup[section].dateTime).tr,
                                  style: AppStyles.primaryStyle(bold: false,fontSize: 15),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(height: 2.h),
                            sectionSeparatorBuilder: (context, section) => SizedBox(height: 10.h),
                          )






                                  : NoDataFound(
                                      animation: AppAnim.noFilesFound,
                                      msg: AppStrings.noAvailableFiles,
                                    )
                              : Center(child: Container())),
                    ],
                  ),
                ),
        ],
      );
    }));
  }
}
