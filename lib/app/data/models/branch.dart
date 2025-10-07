class Branch {
  Branch({this.id = 0, this.nameAr = '', this.nameEn = '', this.code=''});

  int id;
  String nameAr = '', nameEn = '',code='';

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json['id'] ?? 0,
        nameAr: json['name_ar'] ?? '',
        nameEn: json['name_en'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameAr,
        "description": nameEn,
      };
}
