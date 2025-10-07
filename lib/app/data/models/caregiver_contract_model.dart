
import 'package:globcare/app/data/models/model_helper.dart';

import 'BaseModel.dart';

class CaregiverContractModel {
  final int id;
  final String name;
  final BaseModel patient;
  final String date,startingDate,endingDate;
  final String state;
  final BaseModel service;

  final String question1;
  final String question2;
  final String question2Text;
  final String question3;
  final String question4;
  final String question5;
  final String question6;
  final String question7;
  final String question8;
  final String question9;
  final String question10;
  final String comment;
  final String jitsiLink,pdfLink;

  CaregiverContractModel({
    this.id=0,
    this.name='',
   required this.patient,
  required  this.date,
    this.startingDate='',
    this.endingDate='',
    this.state='',
  required  this.service,

    this.question1='',
    this.question2='',
    this.question2Text='',
    this.question3='',
    this.question4='',
    this.question5='',
    this.question6='',
    this.question7='',
    this.question8='',
    this.question9='',
    this.question10='',
    this.comment='',
    this.jitsiLink='',this.pdfLink=''
  });

  factory CaregiverContractModel.fromJson(Map<String, dynamic> json) => CaregiverContractModel(
    id: json["id"],
    name: json["name"],
    patient: BaseModel.fromJson(json["patient"]),
    date: (json["date"]),
    startingDate:json["starting_date"].toString().toLowerCase()=="false" ?"":   ModelHelper.checkString( json["starting_date"]),
    endingDate: json["ending_date"].toString().toLowerCase()=="false" ?"":  ModelHelper.checkString( json["ending_date"]),
    state: json["state"],
    service: BaseModel.fromJson(json["service"]),

    question1: json["question1"],
    question2: json["question2"],
    question2Text: json["question2_text"],
    question3: json["question3"],
    question4: json["question4"],
    question5: json["question5"],
    question6: json["question6"],
    question7: json["question7"],
    question8: json["question8"],
    question9: json["question9"],
    question10: json["question10"],
    comment: json["comment"],
    jitsiLink: json["jitsi_link"],
    pdfLink: json["pdf_link"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "patient": patient.toJson(),
    "state": state,
    "service": service.toJson(),

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


