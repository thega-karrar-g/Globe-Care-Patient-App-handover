import 'package:reactive_forms/reactive_forms.dart';

import '../../data/api/api_keys.dart';

mixin AuthFormsMixin{


 final FormGroup registerForm = FormGroup(
    {
      ApiKeys.nameKey: FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(3),

        ],
      ),
      ApiKeys.formMobile: FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(9),

        ],
      ),
      ApiKeys.formPassword: FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(8),
          Validators.pattern(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$'),
        ],
      ),

      ApiKeys.ageKey: FormControl<String>(
        validators: [
          Validators.required,
        ],
      ),

      ApiKeys.idNumberKey: FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(10),
        ],
      ),

    },
// asyncValidatorsDebounceTime: 2000
  );


final  FormGroup loginForm = FormGroup(

      {
        ApiKeys.smsUserName.toLowerCase():
        FormControl<String>(
          validators: [
            Validators.required,
            Validators.minLength(10)

          ],
        ),

        ApiKeys.formPassword: FormControl<String>(validators: [
          Validators.required,
          // Validators.,
          Validators.minLength(4)
        ]),


        'rememberMe': FormControl<bool>(),
      },
      asyncValidatorsDebounceTime: 2000
  );


  final FormGroup forgetPasswordForm = fb.group(<String, Object>{
    ApiKeys.idNumberKey: FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
    ApiKeys.formMobile: [
      '',
      Validators.required,
    ],
  },);

final  FormGroup addMemberForm = fb.group(<String, Object>{
    ApiKeys.nameKey : FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),

    ApiKeys. ageKey: FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
    // passwordKey: ['', Validators.required, Validators.minLength(6)],
    // confirmPasswordKey: ['', Validators.required, Validators.minLength(6)],
    ApiKeys. idNumberKey: [
      '',
      Validators.required,
      Validators.minLength(10),

    ],
  });

final FormGroup changePasswordForm = fb.group(<String, Object>{
   ApiKeys.formPassword: FormControl<String>(
     validators: [
       Validators.required,
       //  Validators.minLength(6),
     ],
   ),
   ApiKeys.formNewPassword: FormControl<String>(),
 });



}