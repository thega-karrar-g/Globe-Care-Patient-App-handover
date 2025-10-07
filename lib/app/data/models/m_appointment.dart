import 'dart:convert';

import 'model_helper.dart';

List<Appointment> appointmentFromJson(String str) => List<Appointment>.from(json
        .decode(str)
        .mapUser((x) => Appointment.fromJson(x as Map<String, dynamic>))
    as Iterable<dynamic>);

String appointmentToJson(List<Appointment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Appointment {
  Appointment(
      {this.id,
      this.doctor='',
      this.name='',
      this.appointmentType,
      this.timeAllot,
      this.fees,
      required this.appointmentDate,this.cancellationRequested=false,
      this.visitTime,
      this.reasonForVisit,
      this.state = '',
      this.videoLink = '',
      this.password = '',
      this.period = ''});

  int? id;
  String doctor, name;
  String? appointmentType;
  String? timeAllot;
  int? fees;
  DateTime appointmentDate;
  String? visitTime;
  String? reasonForVisit;
  String state, videoLink = '', password = '', period;
  bool cancellationRequested;

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
      id: json["id"] == null ? null : json["id"] as int,
      doctor: json["service"] != null
          ? (json["service"] as List)[1]
          : json["doctor"] == null
              ? ''
              : (json["doctor"]),
      name: ModelHelper.checkString( json["name"]),
      appointmentType: json["type"] != null
          ? (json["type"] is bool)
              ? 'N'
              : '${json["type"]}'
          : 'N',
      timeAllot: "1 hour",
      fees: 100,
      cancellationRequested: json['cancellation_requested'] ?? false,

      appointmentDate: DateTime.tryParse(json["appointment_date"].toString() )?? DateTime.now(),
      visitTime: '${json["appointment_end"]}',
      reasonForVisit: '${json["comments"]}',
      state: '${json["state"]}',
      videoLink: ModelHelper.checkString(json["jitsi_link"]),
      password: '${json["apw"]}',
      period: ModelHelper.checkString(json["period"]));

  Map<String, dynamic> toJson() => {
        "id": id,
        "doctor": doctor,
        "visit_type": appointmentType,
        "time_allot": timeAllot,
        "fees": fees,
        "visit_date": appointmentDate,
        "visit_time": visitTime,
        "reason_for_visit": reasonForVisit,
        "state": state,
        "video_link": videoLink,
      };
}



class AppointmentGroup{

  AppointmentGroup({required this.dateTime,this.appointments=const[]});
  DateTime dateTime;
  List<Appointment> appointments=[];



}

// // To parse this JSON data, do
// //
// //     final appointment = appointmentFromJson(jsonString);
//
// import 'dart:convert';
//
// import 'm_doctors.dart';
//
// List<Appointment> appointmentFromJson(String str) =>
//     List<Appointment>.from(json.decode(str).map((x) => Appointment.fromJson(x as Map<String, dynamic>)) as Iterable<dynamic>);
//
// String appointmentToJson(List<Appointment> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class Appointment {
//   Appointment({
//     this.id,
//     this.doctor,
//     this.visitType,
//     this.timeAllot,
//     this.fees,
//     this.visitDate,
//     this.visitTime,
//     this.reasonForVisit,
//     this.upcoming,
//   });
//
//   int? id;
//   Doctor? doctor;
//   int? visitType;
//   String? timeAllot;
//   int? fees;
//   DateTime? visitDate;
//   String? visitTime;
//   String? reasonForVisit;
//   bool? upcoming;
//
//   factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
//         id: json["id"] == null ? null : json["id"] as int,
//         doctor: json["doctor"] == null ? null : Doctor.fromJson(json["doctor"] as Map<String, dynamic>),
//         visitType: json["visit_type"] == null ? null : json["visit_type"] as int,
//         timeAllot: json["time_allot"] == null ? null : json["time_allot"] as String,
//         fees: json["fees"] == null ? null : json["fees"] as int,
//         visitDate: json["visit_date"] == null ? null : DateTime.parse(json["visit_date"] as String),
//         visitTime: json["visit_time"] == null ? null : json["visit_time"] as String,
//         reasonForVisit: json["reason_for_visit"] == null ? null : json["reason_for_visit"] as String,
//         upcoming: json["upcoming"] == null ? null : json["upcoming"] as bool,
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "doctor": doctor == null ? null : doctor!.toJson(),
//         "visit_type": visitType,
//         "time_allot": timeAllot,
//         "fees": fees,
//         "visit_date": visitDate == null
//             ? null
//             : "${visitDate!.year.toString().padLeft(4, '0')}-${visitDate!.month.toString().padLeft(2, '0')}-${visitDate!.day.toString().padLeft(2, '0')}",
//         "visit_time": visitTime,
//         "reason_for_visit": reasonForVisit,
//         "upcoming": upcoming,
//       };
// }
