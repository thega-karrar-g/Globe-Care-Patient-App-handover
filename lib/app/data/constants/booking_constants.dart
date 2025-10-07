import 'dart:io';

import 'package:flutter/material.dart';

import '../eunums/enums.dart';
import '../../data/models/branch.dart';
import '../../data/models/m_doctors.dart';
import '../../data/models/nurse_service.dart';
import '../../data/models/user_model.dart';
import '../../modules/qr_scanner/qr_scanner_logic.dart';

class BookingConstants {
  static AppUser? patient;

  static File? audioFile;
  static File? attachFile;
  static File? cameraFile;
  static File? voiceNote;

  static String appointmentType = '';
  static String discountCategory = 'hhc';
  static String patientFollowers = '';
  static double price = 0,percentDiscount=0.0,vat=0.0,subTotal=0.0,transportingFee=0.0;
  static int homeVisitPrice = 0;
  static int discount = 0;
  static int discountId = 0;
  static int doctorId = 0;
  static String? branch ;
  static Doctor doctor = Doctor();
  static NurseService service = NurseService();
  static NurseService service2 = NurseService();
  static NurseService service3 = NurseService();


  static int patientId = 0;
  static int serviceId = 0;
  static int serviceId2 = 0;
  static int serviceId3 = 0;
  static String serviceName = '';
  static String doctorName = '';
  static String serviceType = 'N';
  static String serviceCode = 'N';
  static String paymentType = 'pay';
  static String consultancyType = '';
  static DateTime appointmentDate = DateTime.now();
  static String appointmentTime = '';
  static String period = 'morning';
  static String hour = '';
  static String location = '';
  static String textNote = '';
  static String doctorGender = 'Male';
  static bool showFiles = true;
  static bool isPcr = false;
  static bool paymentFromInstantCons = false;
  static bool showTransportingFee = false;

  static PaymentAppointmentTypes paymentAppointmentType =
      PaymentAppointmentTypes.hhc;

  static bool? fromPatientData;
  static TextEditingController patientComment = TextEditingController();


  static reset(){

    patientComment.clear();
     appointmentType = '';
     discountCategory = 'hhc';
     patientFollowers = '';
     price = 0;percentDiscount=0.0;vat=0.0;
     homeVisitPrice = 0;
     discount = 0;
     discountId = 0;
     doctorId = 0;
     doctor = Doctor();
     service = NurseService();
     service2 = NurseService();
     service3 = NurseService();

    patientId = 0;
     serviceId = 0;
     serviceId2 = 0;
     serviceId3 = 0;
    serviceName = '';
     doctorName = '';
     serviceType = 'N';
     serviceCode = 'N';
     paymentType = 'pay';
     consultancyType = '';
    appointmentDate = DateTime.now();
     appointmentTime = '';
     period = '';
     hour = '';
    location = '';
     textNote = '';
   doctorGender = 'Male';
    showFiles = true;
   isPcr = false;
    paymentFromInstantCons = false;
    QrScannerLogic.qrCtrl.clear();
    // transportingFee=0.0;

  }

}
