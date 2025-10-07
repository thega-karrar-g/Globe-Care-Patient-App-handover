import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/models/about_model.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/ui.dart';
import '../aboutus/widgets/about_item.dart';
import 'faq_logic.dart';

class FAQPage extends StatelessWidget {
  final FAQLogic logic = Get.put(FAQLogic());

  FAQPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(
        child: Column(
      children: [
        myAppBar2(title: AppStrings.faq),
        Expanded(
            child: SingleChildScrollView(
          child: Wrap(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: AboutModel.faqList.length,
                  itemBuilder: (bc, index) =>
                      AnimationConfiguration.staggeredList(
                          position: index,
                          duration: Duration(milliseconds: 500),
                          child: SlideAnimation(
                              verticalOffset: 100,
                              duration: Duration(milliseconds: 500),
                              child: AboutItem(
                                aboutModel: AboutModel.faqList[index],
                              )))),
            ],
          ),
        )),
      ],
    ));
  }
}
