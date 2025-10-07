import 'model_helper.dart';

class NurseService {
  NurseService(
      {this.id = 0,
      this.quantity = 1,
      this.name = '',
      this.nameAr = '',
      this.description = '',
      this.descriptionAr = '',
      this.type = '',
      this.price = '0',
      this.instructions = '',
      this.instructionsAr = '',
      this.code = ''});

  int id, quantity = 1;
  String name = '',
      nameAr = '',
      description = '',
      descriptionAr = '',
      type = '',
      code = '',
      price = '',
      instructions = '',
      instructionsAr = '';

  factory NurseService.fromJson(Map<String, dynamic> json) => NurseService(
        id: json['id'] ?? 0,
        name: ModelHelper.checkString(json['name']),
        nameAr: ModelHelper.checkString(json['name_ar']),
        code: '${json['service_type']}',
        description: ModelHelper.checkString(json['description']),
        descriptionAr: ModelHelper.checkString(json['description_ar']),
        instructions: ModelHelper.checkString(json['more_details']),
        instructionsAr: ModelHelper.checkString(json['more_details_ar']),
        price: ModelHelper.convertToPrice(json['list_price']),
        type: '${json['service_type']}',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nameAr": nameAr,
        "description": description,
        "type": type,
        "instructions": instructions,
        "price": price,
      };
}
