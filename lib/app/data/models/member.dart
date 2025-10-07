class Member {
  Member(
      {this.id = 0,
      this.name = '',
      this.relation = '',
      this.gender = '',
      this.age = '',
      this.phone = '',
      this.idNumber = ''});

  int id;
  String name;
  String relation, gender;
  String age, phone, idNumber;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["id"],
        name: json["name"],
        relation: json["relation"],
        age: json["age"],
        phone: json["mobile"],
        idNumber: json["ssn"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "relation": relation,
        "age": age,
        "mobile": phone,
        "ssn": idNumber,
      };
}
