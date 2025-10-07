class PcrModel {
  PcrModel(
      {this.id = 0,
      this.quantity = 1,
      this.name = '',
      this.nameAr = '',
      this.description = '',
      this.descriptionAr = '',
      this.type = '',
      this.price = '20',
      this.instructions = '',
      this.instructionsAr = '',
      this.code = ''});

  int id, quantity;
  String name = '',
      nameAr = '',
      description = '',
      descriptionAr = '',
      type = '',
      code = '',
      price = '',
      instructions = '',
      instructionsAr = '';

  factory PcrModel.fromJson(Map<String, dynamic> json) => PcrModel(
        id: json['id'] ?? 0,
        quantity: json['quantity'] ?? 1,
        name: json['name'],
        nameAr: '${json['name_ar']}',
        code: '${json['service_code']}',
        description: '${json['description']}',
        descriptionAr: '${json['description_ar']}',
        instructions: '${json['instructions']}',
        instructionsAr: '${json['instructions_ar']}',
        price: '${json['price']}',
        type: '${json['type']}',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
      };

  static List<PcrModel> pcrs = [];
}
