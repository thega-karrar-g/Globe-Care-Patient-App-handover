// To parse this JSON data, do
//
//     final requestdPayment = requestdPaymentFromJson(jsonString);

import 'dart:convert';

import 'model_helper.dart';

RequestedPayment requestdPaymentFromJson(String str) =>
    RequestedPayment.fromJson(json.decode(str));

String requestdPaymentToJson(RequestedPayment data) =>
    json.encode(data.toJson());

class RequestedPayment {
  RequestedPayment({
    this.id = 0,
    this.name = '',
    this.state = '',
    this.paymentAmount = "0",
    this.paymentReference = '',
    this.date,
    this.details = '',
    this.type = '',
    this.hhcAppointment = '',
    this.teleAppointment = '',
    this.hvdAppointment = '',
    this.phyAppointment = '',
    this.pcrAppointment = '',
  });

  int id = 0;
  String name;
  String state;
  String paymentAmount;
  String paymentReference;
  DateTime? date = DateTime.now();
  String details;
  String type;
  String hhcAppointment;
  String teleAppointment;
  String hvdAppointment;
  String phyAppointment;
  String pcrAppointment;

  factory RequestedPayment.fromJson(Map<String, dynamic> json) =>
      RequestedPayment(
        id: json["id"],
        name: ModelHelper.checkString(json["name"]),
        state: ModelHelper.checkString(json["state"]),
        paymentAmount:
            ModelHelper.checkString(json["payment_amount"].toString()),
        paymentReference: ModelHelper.checkString(json["payment_reference"]),
        date: ModelHelper.checkDate(json["date"]),
        details: ModelHelper.checkString(json["details"]),
        type: ModelHelper.checkString(json["type"]),
        hhcAppointment: ModelHelper.checkString(json["hhc_appointment"]),
        teleAppointment: ModelHelper.checkString(json["tele_appointment"]),
        hvdAppointment: ModelHelper.checkString(json["hvd_appointment"]),
        phyAppointment: ModelHelper.checkString(json["phy_appointment"]),
        pcrAppointment: ModelHelper.checkString(json["pcr_appointment"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "state": state,
        "payment_amount": paymentAmount,
        "payment_reference": paymentReference,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "details": details,
        "type": type,
        "hhc_appointment": hhcAppointment,
        "tele_appointment": teleAppointment,
        "hvd_appointment": hvdAppointment,
        "phy_appointment": phyAppointment,
        "pcr_appointment": pcrAppointment,
      };
}

class RequestedPaymentGroup{

  RequestedPaymentGroup({required this.dateTime,this.requestedPayment=const[]});
  DateTime dateTime;
  List<RequestedPayment> requestedPayment=[];



}
