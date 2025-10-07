import 'package:get/get.dart';

class GridAspectRatio {
  static double aspectRatio({int count = 2, double height = 120}) {
    var crossAxisSpacing = 8;
    var width = (Get.width - ((count - 1) * crossAxisSpacing)) / count;
    var aspectRatio = width / height;

    return aspectRatio;
  }
}
