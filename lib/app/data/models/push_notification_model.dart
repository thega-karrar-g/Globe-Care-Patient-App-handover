import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:globcare/app/data/models/model_helper.dart';

class PushNotification {
  String titleAr,titleEn;
  String bodyAr,bodyEn;
  String image;


  PushNotification({
    this.titleAr='',this.titleEn='',
    this.bodyAr='',this.bodyEn='',this.image=''
  });

  factory PushNotification.fromMap(Map<String, dynamic> map) {
    return PushNotification(
      titleAr: map['title'] ?? ModelHelper.checkString(map['title_ar']),
      titleEn:map['title'] ?? ModelHelper.checkString(map['title_en']),
      bodyAr:map['body'] ?? ModelHelper.checkString(map['body_ar']),
      bodyEn:map['body'] ?? ModelHelper.checkString(map['body_en']),
      image: ModelHelper.checkString(map['image']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': titleAr,
      'body': bodyAr,
    };
  }



}
