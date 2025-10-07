
class RecordModel {
  RecordModel({
    this.id=0,
    this.patientName='',
    this.provisionalDiagnosis='',this.provisionalDiagnosisAdd='',this.provisionalDiagnosisAdd2='',this.provisionalDiagnosisAdd3='',
    this.medicalCarePlan='',this.specialInstructions=''
  });

  int id;
  String patientName='',provisionalDiagnosis='',provisionalDiagnosisAdd='',provisionalDiagnosisAdd2='',provisionalDiagnosisAdd3='',medicalCarePlan='',specialInstructions='';


  factory RecordModel.fromJson(Map<String, dynamic> json) => RecordModel(
    id: json['id'] ??0,
    patientName: json['patient']??'',
    provisionalDiagnosis: json['provisional_diagnosis']??'',
    provisionalDiagnosisAdd: json['provisional_diagnosis_add']??'',
    provisionalDiagnosisAdd2: json['provisional_diagnosis_add2']??'',
    provisionalDiagnosisAdd3: json['provisional_diagnosis_add3']??'',
    medicalCarePlan: json['medical_care_plan']??'',
    specialInstructions: json['special_instructions']??'',

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": patientName,
    "medical_care_plan": medicalCarePlan,
    "special_instructions": specialInstructions,
    "provisional_diagnosis": provisionalDiagnosis,

  };
}

