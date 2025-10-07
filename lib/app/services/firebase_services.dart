//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class FireBaseService{
//
//
//  static FirebaseAuth auth = FirebaseAuth.instance;
//
// static sendPhoneNumberCode({String phoneNumber='+967770366480'})async {
//   try {
//     var d = await auth.verifyPhoneNumber(
//       phoneNumber: phoneNumber,
//       verificationCompleted: (PhoneAuthCredential credential) {
//         print('verificationCompleted');
//
//         print('sms code ${credential
//             .smsCode} *********************************************');
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         print('verificationFailed');
//
//         print('sms code ${e
//             .message} *********************************************');
//       },
//       codeSent: (String verificationId, int? resendToken) async{
//         print('codeSent');
//         print(
//             'sms code $verificationId *********************************************');
//
//
//
//         final smsCode = await getSmsCodeFromUser();
//
//         if (smsCode != null) {
//           // Create a PhoneAuthCredential with the code
//           final credential = PhoneAuthProvider.credential(
//             verificationId: verificationId,
//             smsCode: smsCode,
//           );
//
//
//
//           try {
//             // Sign the user in (or link) with the credential
//             var d=await auth.signInWithCredential(credential);
//
//           } on FirebaseAuthException catch (e) {
//         print("***********************  ${e.message}");
//           }
//         }
//
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         print('codeAutoRetrievalTimeout');
//         print(
//             'sms code $verificationId *********************************************');
//       },
//
//     );
//   }on FirebaseAuthException  catch(e){
//     print(e.toString()+' ***************** this exception ******************************************************');
//   }
// }
//
//
//
//
// static Future<String?> getSmsCodeFromUser() async {
//    String? smsCode;
//
//    // Update the UI - wait for the user to enter the SMS code
//    await showDialog<String>(
//      context: Get.context!,
//      barrierDismissible: false,
//      builder: (context) {
//        return AlertDialog(
//          title: const Text('SMS code:'),
//          actions: [
//            ElevatedButton(
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//              child: const Text('Sign in'),
//            ),
//            OutlinedButton(
//              onPressed: () {
//                smsCode = null;
//                Navigator.of(context).pop();
//              },
//              child: const Text('Cancel'),
//            ),
//          ],
//          content: Container(
//            padding: const EdgeInsets.all(20),
//            child: TextField(
//              onChanged: (value) {
//                smsCode = value;
//              },
//              textAlign: TextAlign.center,
//              autofocus: true,
//            ),
//          ),
//        );
//      },
//    );
//
//    return smsCode;
//  }
// }
