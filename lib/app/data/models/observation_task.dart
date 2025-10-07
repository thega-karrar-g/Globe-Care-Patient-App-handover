
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';

class ObservationTask {
  ObservationTask({
    this.id=0,
    this.title='',this.key='',this.textKey='',this.textTitle='',
    this.dropdownCtrl,this.reasonCtrl,this.dropdownList=const[]

  });

  int id;
String title,key,textKey,textTitle;

List<Item>  dropdownList;

static List<String> titles=[
  'Bathing/Shower (toilet)',
  'Bed Bath',
  'Hair Care',
  'Mouth Care',
  'Nail Care',
  'Shaving (needs consent)',
  'Bowel/Bladder Care',
  'Dressing/Grooming',
  'Meals/Feeding',
  'Ambulation',
  'Positioning (Bed)',

  'Positioning (wheelchair)',
  'Permitted exercise',
  'Transfers (Bed to chair)',
  'Medication',

  ];




  TextEditingController? reasonCtrl,dropdownCtrl;
static List<ObservationTask> tasks=_init();
//static List<ObservationTask> tasks=List.generate(titles.length, (index) => ObservationTask(id: index+1,title:titles[index] ,dropdownCtrl: TextEditingController(),reasonCtrl: TextEditingController()));



 static List<ObservationTask> _init(){

  List<ObservationTask> tasks1=[];
  tasks1.add(ObservationTask(key: 'bathing_shower',title: 'Bathing/Shower (toilet)',textKey: 'bathing_text',dropdownCtrl: TextEditingController(),reasonCtrl: TextEditingController()));
  tasks1.add(ObservationTask(key: 'bed_bath',title: 'Bed Bath',textKey: 'bed_bath_text',dropdownCtrl: TextEditingController(),reasonCtrl: TextEditingController()));
  tasks1.add(ObservationTask(key: 'hair_care',title: 'Hair Care',textKey: 'hair_care_text',dropdownCtrl: TextEditingController(),reasonCtrl: TextEditingController()));
  tasks1.add(ObservationTask(key: 'mouth_care',title: 'Mouth Care',textKey: 'mouth_care_text',dropdownCtrl: TextEditingController(),reasonCtrl: TextEditingController()));
  tasks1.add(ObservationTask(key: 'nail_care',title: 'Nail Care',textKey: 'nail_care_text',dropdownCtrl: TextEditingController(),reasonCtrl: TextEditingController()));
  tasks1.add(ObservationTask(key: 'shaving',title: 'Shaving (needs consent)',textKey: 'shaving_text',dropdownCtrl: TextEditingController(),reasonCtrl: TextEditingController()));
  tasks1.add(ObservationTask(key: 'bowel_care',title: 'Bowel/Bladder Care',textKey: 'bowel_text',dropdownCtrl: TextEditingController(),reasonCtrl: TextEditingController()));
  tasks1.add(ObservationTask(key: 'ambulation',title: 'Ambulation',textKey: 'ambulation_text',dropdownCtrl: TextEditingController(),reasonCtrl: TextEditingController()));
  tasks1.add(ObservationTask(key: 'meals_feeding',title: 'Meals/Feeding',textKey: 'meals_feeding_text',dropdownCtrl: TextEditingController(),reasonCtrl: TextEditingController()));
  tasks1.add(ObservationTask(key: 'dressing_grooming',title: 'Dressing/Grooming',textKey: 'dressing_grooming_text',dropdownCtrl: TextEditingController(),reasonCtrl: TextEditingController()));
  tasks1.add(ObservationTask(key: 'positioning_bed',title: 'Positioning (Bed)',textKey: 'positioning_bed_text',dropdownCtrl: TextEditingController(),reasonCtrl: TextEditingController()));
  tasks1.add(ObservationTask(key: 'positioning_wheelchair',title: 'Positioning (wheelchair)',textKey: 'positioning_wheelchair_text',dropdownCtrl: TextEditingController(),reasonCtrl: TextEditingController()));
  tasks1.add(ObservationTask(key: 'permitted_exercise',title: 'Permitted exercise',textKey: 'permitted_exercise_text',dropdownCtrl: TextEditingController(),reasonCtrl: TextEditingController()));
  tasks1.add(ObservationTask(key: 'transfers_chair',title: 'Transfers (Bed to chair)',textKey: 'transfers_chair_text',dropdownCtrl: TextEditingController(),reasonCtrl: TextEditingController()));
  tasks1.add(ObservationTask(key: 'medication',title: 'Medication',textKey: 'medication_text',dropdownCtrl: TextEditingController(),reasonCtrl: TextEditingController()));
 // tasks.add(ObservationTask(key: '',title: '',textKey: '',dropdownCtrl: TextEditingController(),reasonCtrl: TextEditingController()));

  return tasks1;

}





}




