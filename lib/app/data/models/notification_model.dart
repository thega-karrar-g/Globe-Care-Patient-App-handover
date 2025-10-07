import 'package:globcare/app/data/models/model_helper.dart';

class NotificationModel {
  NotificationModel(
      {this.id = 0,
      this.nameEn = '',this.nameAr='',this.bodyAr='',this.imageUrl='',this.type='',
      this.bodyEn = '',
     required this.date ,
      this.read = false});

  int id;
  String nameEn, nameAr, bodyEn,bodyAr ,imageUrl,type ;
  DateTime date;
  bool read = false;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json['id'] ?? 0,
        read: json['read'] ?? false,
        nameEn: ModelHelper.checkString(json['name_en']),
        nameAr: ModelHelper.checkString(json['name_ar']),
        bodyAr: ModelHelper.checkString(json['content_ar']),
        bodyEn: ModelHelper.checkString(json['content_en']),
        imageUrl: ModelHelper.checkString(json['image_url']),
        type: ModelHelper.checkString(json['type']),
        date: DateTime.tryParse( json['date'] ) ?? DateTime.now(),


      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameEn,
        "description": bodyEn,
        "date": date,
      };

}
