// To parse this JSON data, do
//
//     final doctor = doctorFromJson(jsonString);

class ScheduleModel {
  ScheduleModel({
    this.id,
    this.name,
    this.times = const [],
    required this.date,
  });

  int? id;
  String? name;
  DateTime date;

  List<String>? times;

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        id: json["id"],
        name: json["name"],
        date: json["date"] == null
            ? DateTime.now()
            : DateTime.parse(json["date"] as String),
        times: json["list"] == false
            ? null
            : List<String>.from(json["list"].map((x) => (x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "date": date,
        "list": times == null ? [] : List<dynamic>.from(times!.map((x) => x)),
      };
}
