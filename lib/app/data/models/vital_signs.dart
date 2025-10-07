
class VitalSigns {
  final int id;
  final String recordId,caregiverId,weight,oxygenSaturation,oxygenSaturationStatus,temperature,bloodPressureSys,bloodPressureDia,bloodSugar,heartRate,respiration,date;

  VitalSigns({
    this.id = 0,
    this.recordId='',this.caregiverId='',this.oxygenSaturationStatus='',
    this.weight = '',this.oxygenSaturation='',this.temperature='',this.bloodPressureSys='',this.bloodPressureDia='',this.heartRate='',this.bloodSugar='',this.respiration='',
    this.date=''
  });
  Map<String, dynamic> toJson() => {
    "id": id.toString(),
    // "weight": weight,
    "record_id": recordId,
    "caregiver_id": caregiverId,

    "temperature": temperature,
    "oxygen": oxygenSaturation,

    "systolic": bloodPressureSys,
    "diastolic": bloodPressureDia,
    "blood_sugar": bloodSugar,
    "heart_rate": heartRate,
    "respiratory_rate": respiration,
    "o2_sat": oxygenSaturationStatus,

  };

  factory VitalSigns.fromJson(Map<String, dynamic> json) => VitalSigns(
    id: json['id'] ??0,
    // weight:'${ json['diastolic_br']}',
    oxygenSaturation:'${ json['oxygen_saturation']}',
    temperature:'${ json['temperature']}',
    bloodPressureSys:'${ json['systolic']}',
    bloodPressureDia:'${ json['diastolic']}',
    bloodSugar:'${ json['blood_sugar']}',
    heartRate:'${ json['heart_rate']}',
    respiration:'${ json['respiratory_rate']}',
    date:'${ json['date']}',



  );


}
