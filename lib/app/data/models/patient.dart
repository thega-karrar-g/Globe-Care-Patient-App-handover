import 'package:reactive_forms/reactive_forms.dart';

class Patient {
  int id = 0;
  String name = '', idNumber = '', passportNumber = '';

  final nameKey = 'name';
  final passportKey = 'passport';
  final ssnKey = 'ssn';
  bool hasCertificate = false;
  var formGroup = fb.group(<String, Object>{'': FormControl()});

  var form = FormGroup({
    'name': FormControl<String>(value: 'John Doe'),
    'email': FormControl<String>(),
  });

  Patient(
      {this.id = 0,
      this.name = '',
      this.hasCertificate = true,
      this.idNumber = '',
      this.passportNumber = '',
      required this.form});
}
