class Dept {
  Dept({this.id = 0, this.name = '', this.description = '', this.code = 'L'});

  int id;
  String name = '', description = '', code = '';

  factory Dept.fromJson(Map<String, dynamic> json) => Dept(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        description: json['description'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };
}
