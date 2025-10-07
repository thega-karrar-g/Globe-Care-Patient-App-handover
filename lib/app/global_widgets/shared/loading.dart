import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../core/assets_helper/app_anim.dart';

class MyLoadingWidget extends StatelessWidget {
  const MyLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Lottie.asset(
                AppAnim.loaderGetData,
                width: Get.width * .7,
                height: Get.height * .3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
