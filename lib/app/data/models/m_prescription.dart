class Prescription {
  Prescription({
    this.id,
    this.name,
    this.patient,
    this.doctor,
    this.info,
    required this.date,
    this.prescriptionLines = const [],
  });

  int? id;
  String? name;
  String? patient, doctor, info;
  List<PrescriptionLine> prescriptionLines;
  DateTime date;

  factory Prescription.fromJson(Map<String, dynamic> json) => Prescription(
      id: json["id"] as int,
      name: '${json["name"]}',
      patient: '${json["patient"]}',
      doctor: '${json["doctor"]}',
      date: json["date"] == null
          ? DateTime.now()
          : DateTime.parse(json["date"] as String),
      info: '${json["info"]}',
      prescriptionLines: json["prescription_line"] == null
          ? []
          : List<PrescriptionLine>.from(json["prescription_line"]
              .map((x) => PrescriptionLine.fromJson(x)))

      // prescriptionLine: List<SubCategory>.from(json["prescription_line"].map((x) => PrescriptionLine.fromJson(x as Map<String, dynamic>)) as Iterable<dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "patient": patient,
        "doctor": doctor,
        "date": date,
        "info": info,
        "prescription_line":
            List<dynamic>.from(prescriptionLines.map((x) => x.toJson())),
      };
}

class PrescriptionLine {
  PrescriptionLine({
    this.name,
    this.indication,
    this.dose,
    this.startTreatment,
    this.endTreatment,
  });

  String? name;
  String? indication;
  String? dose;
  DateTime? startTreatment;
  DateTime? endTreatment;

  factory PrescriptionLine.fromJson(Map<String, dynamic> json) =>
      PrescriptionLine(
        name: json["name"],
        indication: json["indication"],
        dose: json["dose"],
        startTreatment: json["start_treatment"] == null ||
                json["start_treatment"].toString().isEmpty
            ? DateTime.now()
            : DateTime.parse(json["start_treatment"] as String),
        endTreatment: json["end_treatment"] == null ||
                json["end_treatment"].toString().isEmpty
            ? DateTime.now()
            : DateTime.parse(json["end_treatment"] as String),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "indication": indication,
        "dose": dose,
        "start_treatment": startTreatment,
        "end_treatment": endTreatment,
      };
}
