// To parse this JSON data, do
//
//     final doctor = doctorFromJson(jsonString);

import 'dart:convert';

import 'model_helper.dart';

List<Doctor> doctorFromJson(String str) =>
    List<Doctor>.from(json.decode(str).mapUser((x) => Doctor.fromJson(x)));

String doctorToJson(List<Doctor> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Doctor {
  Doctor(
      {this.id,
      this.name = '',
      this.nameAr = '',
        this.branch='',
      this.jobTitle = '',
      this.jobTitleAr = '',
      this.employer = '',
      this.employerAr = '',
      this.practicalExpertise = '',
      this.practicalExpertiseAr = '',
      this.scientificExpertise = '',
      this.scientificExpertiseAr = '',
      this.languages,
      this.image,
      this.speciality,
      this.specialityAr = '',
      this.medicalLicense = '',
      this.rating,
      this.distance,
      this.reviewCount,
      this.experience,
      this.address,
      this.isFeatured,
      this.country,
      this.countryAr,
      this.location,
      this.degreeId,
      this.roleType,
      this.price = '50',
      this.doctorType = 'General',
      this.hvdPrice = '0',
      this.telePrice = '0',
      this.consultancyType = '',
      this.availableLines});

  int? id;
  String? name, nameAr;
  String? image, telePrice = '', hvdPrice = '';
  String? speciality,
      specialityAr,
      doctorType,
      jobTitle,
      jobTitleAr,
      languages,
      employer,
      employerAr,
      yearsOfExperience,
      practicalExpertise,
      practicalExpertiseAr,
      scientificExpertise,
      scientificExpertiseAr,
      licenseTitle,
      licenseTitleAr,
      medicalLicense,
      country,
      countryAr;
String branch='';
  dynamic rating;
  dynamic distance;
  dynamic reviewCount;
  dynamic experience;
  String? address, roleType, price, consultancyType = '';
  bool? isFeatured;
  Location? location;
  List<String>? degreeId;
  List<Line>? availableLines;

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: json["id"],
        name: ModelHelper.checkString(json["name"]),
        nameAr: ModelHelper.checkString(json["name_ar"]),

        branch: ModelHelper.checkString(json["branch"]),
        speciality: ModelHelper.checkString(json["speciality"]),
        specialityAr: ModelHelper.checkString(json["speciality_ar"]),
        medicalLicense: '${json["license_no"]}',
        telePrice: ModelHelper.checkPriceDouble(json["tele_price"]),
        hvdPrice: ModelHelper.checkPriceDouble(json["hvd_price"]),

        jobTitle: ModelHelper.checkString(json["job"]),
        jobTitleAr: ModelHelper.checkString(json["job_ar"]),

        country: ModelHelper.checkString(json["country"]),
        countryAr: ModelHelper.checkString(json["country_ar"]),

        employer: ModelHelper.checkString(json["employer"]),
        employerAr: ModelHelper.checkString(json["employer_ar"]),

        practicalExpertise:
            ModelHelper.checkString(json["practical_expertise"]),
        practicalExpertiseAr:
            ModelHelper.checkString(json["practical_expertise_ar"]),

        scientificExpertise:
            ModelHelper.checkString(json["scientific_expertise"]),
        scientificExpertiseAr:
            ModelHelper.checkString(json["scientific_expertise_ar"]),

        doctorType: ModelHelper.checkString(json["dr_categories_mobile"]),
        rating: json["rating"] ?? '4.5',
        distance: json["distance"] ?? '',
        roleType: '${json["role_type"]}',
        consultancyType: '${json["consultancy_type"]}',
        reviewCount: json["review_count"] ?? '0',
        experience: ModelHelper.checkString(json["experience"]),
        image: json["image_url"] ?? '',
        address: json["address"] ?? '',
        price: '${json["consultancy_price"]}',

        //languages: ModelHelper.checkString(json["languages"]),
        languages: json["languages"] != null && (json["languages"] is List)
            ? ModelHelper.checkListString(
                List<String>.from(json["languages"].map((x) => (x))))
            : '',
        // isFeatured: json["is_featured"] == null ? null : json["is_featured"],
        // location: json["location"] == null ? null : Location.fromJson(json["location"]),
        degreeId: json["degree_id"] == null
            ? null
            : List<String>.from(json["degree_id"].map((x) => (x))),
        availableLines: json["available_lines"] == null
            ? null
            : List<Line>.from(
                json["available_lines"].map((x) => Line.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "speciality": speciality,
        "doctor_type": doctorType,
        "rating": rating,
        "price": price,
        "role_type": roleType,
        "distance": distance,
        "review_count": reviewCount,
        "experience": experience,
        "address": address,
        "is_featured": isFeatured,
        "location": location == null ? null : location!.toJson(),
        "available_lines": availableLines == null
            ? null
            : List<dynamic>.from(availableLines!.map((x) => x.toJson())),
      };
}

class DeptDoctor {
  String name = '', nameAr = '';

  List<Doctor> doctors = [];

  DeptDoctor({this.name = '', this.nameAr = '', this.doctors = const []});
}

class Location {
  Location({
    this.latitude,
    this.longitude,
  });

  double? latitude;
  double? longitude;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json['latitude'] == null ? null : json["latitude"].toDouble(),
        longitude:
            json['longitude'] == null ? null : json["longitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Line {
  Line({
    this.day,
    this.startTime,
    this.endTime,
  });

  String? day;
  String? startTime;
  String? endTime;

  factory Line.fromJson(Map<String, dynamic> json) => Line(
        day: json["day"] ?? '',
        startTime: json["start_time"] ?? '',
        endTime: json["end_time"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "start_time": startTime,
        "end_time": endTime,
      };
}
