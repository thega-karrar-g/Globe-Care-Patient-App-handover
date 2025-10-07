
class BaseModel {
  final int id;
  final String name;

  BaseModel({
    this.id=0,
    this.name='',
  });

  factory BaseModel.fromJson(Map<String, dynamic> json) => BaseModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
