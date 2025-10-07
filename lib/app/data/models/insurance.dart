import 'model_helper.dart';

class Insurance {
  Insurance({this.id = 0, this.name = '', this.nameAr = '', this.image = ''});

  int id;
  String name = '', nameAr = '', image = '';

  factory Insurance.fromJson(Map<String, dynamic> json) => Insurance(
        id: json['id'] ?? 0,
        image: json['image'] ?? '',
        name: ModelHelper.checkString(json['name']),
        nameAr: ModelHelper.checkString(json['name_ar']),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": nameAr,
      };
}
