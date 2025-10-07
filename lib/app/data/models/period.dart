class Period {
  Period(
      {this.id = 0,
      this.type = '',
      required this.date,
      this.hour = '',
      this.period = '',
      this.gender = '',
      this.branch = '',
      this.available = 0});

  int id, available = 0;
  String type = '', period = '', gender = '', hour = '',branch='';
  DateTime date;

  factory Period.fromJson(Map<String, dynamic> json) => Period(
        id: json['id'] ?? 0,
        type: json['type'] ?? '',
        date: json["date"] == null
            ? DateTime.now()
            : DateTime.parse(json["date"] as String),
        period: json['period'] ?? '',
        gender: json['gender'] ?? '',
    branch: json['branch'] ?? '',
        available: json['available'] ?? 0,
      );

  factory Period.fromJsonPcr(Map<String, dynamic> json) => Period(
        id: json['id'] ?? 0,
        type: json['type'] ?? '',
        date: json["date"] == null
            ? DateTime.now()
            : DateTime.parse(json["date"] as String),
        period: json['period'] ?? '',
        hour: '${json['hour']}',
        available: json['available'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "date": date,
        "period": period,
      };
}

class PeriodItem {
  DateTime date = DateTime.now();

  List<Period> periods = [];

  PeriodItem({required this.date, this.periods = const []});
}
