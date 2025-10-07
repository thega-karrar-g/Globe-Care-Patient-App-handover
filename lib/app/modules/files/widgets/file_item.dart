import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../base_controller/base_controller.dart';
import '../../../core/assets_helper/app_images.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_colors.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../data/models/file_model.dart';
import '../../../global_widgets/shared/different_dialogs.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../utils/ext_storage.dart';

class FileItem extends StatelessWidget {
  FileItem(
      {Key? key, required this.file, required this.dir, required this.logic})
      : super(key: key);
  final String dir;
  final BaseController logic;
  final FileModel file;
  final ext = '.pdf';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ExtStorage.fileExist(file.name + ext),
        initialData: false,
        builder: (bc, snapShot) {
          return
            snapShot.connectionState == ConnectionState.done
              ? GestureDetector(
                  onTap: () async {



                    if (await ExtStorage.fileExist(file.name + ext)) {
                      ExtStorage.openFile(file.name + ext);
                    } else {
                      if (file.link.isNotEmpty) {
                        var res = false;
                        res = await DifferentDialog.showProgressDownloadDialog(
                            file: file,);

                        if (res == true) {
                          logic.update();
                          res = false;
                        }
                      } else {
                        BaseController().buildFailedSnackBar(
                            msg: AppStrings.fileNotReady.tr);
                      }
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.primaryColorOpacity),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppImages.pdf,
                          color: AppColors.primaryColor,
                          width: 30,
                          height: 40,
                        ),
                        UiHelper.horizontalSpaceSmall,
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    file.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppStyles.primaryStyle(fontSize: 15),
                                  )),
                                ],
                              ),
                              UiHelper.verticalSpace(3),
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    DateFormat('dd   MMM  yyyy',
                                            Get.locale.toString())
                                        .format(DateTime.parse(file.date)),
                                    style:
                                        AppStyles.primaryStyleGreen(size: 13),
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                        UiHelper.horizontalSpaceMedium,
                        if (snapShot.data == false)
                          Icon(
                            Icons.arrow_circle_down_outlined,
                            color: AppColors.primaryColorGreen,
                          ),
                        UiHelper.horizontalSpaceSmall,
                      ],
                    ),
                  ),
                )
              : Container();
        });
  }
}
