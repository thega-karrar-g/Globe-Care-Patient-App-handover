import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../../../core/assets_helper/app_images.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../data/models/about_model.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import 'about_logic.dart';
import 'widgets/about_item.dart';

class AboutPage extends StatelessWidget {
  final AboutLogic logic = Get.put(AboutLogic());

  AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(
        child: Column(
      children: [
        myAppBar2(title: AppStrings.about),
        Expanded(
            child: SingleChildScrollView(
          child: Wrap(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: AboutModel.aboutList.length,
                  itemBuilder: (bc, index) =>
                      AnimationConfiguration.staggeredList(
                          position: index,
                          duration: Duration(milliseconds: 500),
                          child: SlideAnimation(
                              verticalOffset: 100,
                              duration: Duration(milliseconds: 500),
                              child: AboutItem(
                                aboutModel: AboutModel.aboutList[index],
                              )))),
              Column(
                children: [
                  UiHelper.verticalSpaceMedium,
                  Image.asset(
                    AppImages.logoSvg,
                    width: 100.w,
                    height: 100.h,
                  ),
                  UiHelper.verticalSpaceSmall,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.appVersion,
                        style: AppStyles.primaryStyle(
                            bold: true, fontSize: 13, opacity: .7),
                      ),
                    ],
                  ),
                  UiHelper.verticalSpaceLarge,
                ],
              )
            ],
          ),
        )),
      ],
    ));
  }
}
