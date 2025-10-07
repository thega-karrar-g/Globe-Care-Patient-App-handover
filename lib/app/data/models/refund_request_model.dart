
import 'BaseModel.dart';

class RefundRequestModel {
  final int id;
  final String name,type,reason;
  final BaseModel patient,appointment;
  final DateTime date;
  final String state;

  final String comment;

  RefundRequestModel({
    this.id=0,
    this.name='',
   required this.patient,
   required this.appointment,
  required  this.date,
    this.state='',

    this.comment='',
    this.reason='',this.type=''
  });

  factory RefundRequestModel.fromJson(Map<String, dynamic> json) => RefundRequestModel(
    id: json["id"],
    name: json["name"],
    patient: BaseModel.fromJson(json["patient"]),
    appointment:json["appointment"] !=null ? BaseModel.fromJson(json["appointment"]):BaseModel(),
    date: DateTime.parse(json["date"]),
    state: json["state"],

    type: json["type"] ?? '',
    reason: json["reason"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "patient": patient.toJson(),
    "state": state,

    "comment": comment,
  };
}


