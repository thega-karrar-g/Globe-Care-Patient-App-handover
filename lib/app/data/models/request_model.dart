// To parse this JSON data, do
//
//     final requestdPayment = requestdPaymentFromJson(jsonString);

import 'dart:convert';

import 'model_helper.dart';

RequestModel requestdPaymentFromJson(String str) =>
    RequestModel.fromJson(json.decode(str));

String requestdPaymentToJson(RequestModel data) => json.encode(data.toJson());

class RequestModel {
  RequestModel(
      {this.id = 0,
      this.name = '',
      this.doctor = '',
      this.patient = '',
      this.doctorImgUrl = '',
      this.doctorToken = '',
      this.doctorDeviceType = '',
      this.patientImgUrl = '',
      this.status = '',
      this.gender = '',
      this.jitsiLink = '',
      this.prescriptionLink = '',
      this.age = '',
      this.date = '',
      this.price = 0,
      this.discount = 0});

  int id = 0;
  String name, doctor,doctorToken,doctorDeviceType, patient, doctorImgUrl, patientImgUrl;
  String status;

  String gender;
  String age;
  String date, jitsiLink, prescriptionLink;
  int price, discount;

  factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
        id: json["id"],
        name: ModelHelper.checkString(json["name"]),
        doctor:(json["doctor"] is bool) ?'': ModelHelper.checkString(json["doctor"][0]['doctor']),
        doctorToken:(json["doctor"] is bool) ?'': ModelHelper.checkString(json["doctor"][0]['doctor_fcm_token']),
        doctorDeviceType:(json["doctor"] is bool) ?'': ModelHelper.checkString(json["doctor"][0]['device_type']),
        patient: ModelHelper.checkString(json["patient"][0]['patient']),
        doctorImgUrl: ModelHelper.checkString(json["doctor_image_url"]),
        patientImgUrl: ModelHelper.checkString(json["patient_image_url"]),
        jitsiLink: ModelHelper.checkString(json["jitsi_link"]),
        prescriptionLink: ModelHelper.checkString(json["link"]),
        status: ModelHelper.checkString(json["state"]),
        date: ModelHelper.checkString(json["date"]),
        gender: ModelHelper.checkString(json["gender"]),
        age: ModelHelper.checkString(json["age"]),
        price: ModelHelper.checkInt(json["price"]),
        discount: ModelHelper.checkInt(json["discount"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "gender": gender,
        "age": age,
      };
}
