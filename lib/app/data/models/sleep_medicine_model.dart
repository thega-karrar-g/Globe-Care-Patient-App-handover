
import 'BaseModel.dart';

class SleepMedicineModel {
  final int id;
  final String name;
  final BaseModel patient;
  final DateTime date;
  final String state;
  final BaseModel service;
  final double height;
  final double weight;
  final String question1;
  final String question2;
  final String question3;
  final String question4;
  final String question5;
  final String question6;
  final String comment;
  final String jitsiLink;

  SleepMedicineModel({
    this.id=0,
    this.name='',
   required this.patient,
  required  this.date,
    this.state='',
  required  this.service,
    this.height=0.0,
    this.weight=0.0,
    this.question1='',
    this.question2='',
    this.question3='',
    this.question4='',
    this.question5='',
    this.question6='',
    this.comment='',
    this.jitsiLink='',
  });

  factory SleepMedicineModel.fromJson(Map<String, dynamic> json) => SleepMedicineModel(
    id: json["id"],
    name: json["name"],
    patient: BaseModel.fromJson(json["patient"]),
    date: DateTime.parse(json["date"]),
    state: json["state"],
    service: BaseModel.fromJson(json["service"]),
    height: json["height"],
    weight: json["weight"],
    question1: json["question1"],
    question2: json["question2"],
    question3: json["question3"],
    question4: json["question4"],
    question5: json["question5"],
    question6: json["question6"],
    comment: json["comment"],
    jitsiLink: json["jitsi_link"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "patient": patient.toJson(),
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "state": state,
    "service": service.toJson(),
    "height": height,
    "weight": weight,
    "question1": question1,
    "question2": question2,
    "question3": question3,
    "question4": question4,
    "question5": question5,
    "question6": question6,
    "comment": comment,
    "jitsi_link": jitsiLink,
  };
}


