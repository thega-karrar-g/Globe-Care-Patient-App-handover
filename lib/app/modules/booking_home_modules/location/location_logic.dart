import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../base_controller/base_controller.dart';
import '../../../core/assets_helper/app_images.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/constants/booking_constants.dart';
import '../../../data/models/home_service.dart';
import '../../../data/models/nurse_service.dart';
import '../../../data/repositories/appointment_repository.dart';
import '../../../global_widgets/shared/different_dialogs.dart';
import '../../../routes/app_route_names.dart';
import '../../doctor_module/doctors/doctors_controller.dart';

class LocationLogic extends BaseController {
  Completer<GoogleMapController> controller = Completer();
  final AppointmentRepository _appointmentRepository = AppointmentRepository();

  String selectedLocality="";

  List<String> allAllowedLocalities=["Riyadh","الرياض","الدرعية","Diriyah","الدمام","Dammam","الخبر","Al Khobar","القطيف","Al Qatif"];

  List<String> riyadh=["Riyadh","الرياض"];
  List<String> diriyah=["Diriyah","الدرعية"];
  List<String> dammam=["Dammam","الدمام"];
  List<String> khobar=["Al Khobar","الخبر"];
  List<String> qatif=["Al Qatif","القطيف"];


  GoogleMapController? mapController;

  // final kInitialPosition = LatLng(15.3579753, 44.2004929);

  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(24.7098869, 46.681247),
    zoom: 12.4746,
    bearing: 0,
  );

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId selectedMarkerId = MarkerId('markerId_1');

  LatLng? markerPosition;

  static LatLng? currentLatLng = LatLng(24.7098869, 46.681247);
  String? _currentAddress;
  static final addressController = TextEditingController(text: '');

  String nextRoute = '', code = '';

  var markerIcon = BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(30, 30)), AppImages.marker);
  var greenIcon = BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(50, 50)), AppImages.markerSelected);

  updateMapController(GoogleMapController controller) {
    mapController = controller;
    update();
  }
  //
  // getCurrentLocation2() async {
  //   setBusy(true);
  //   await Future.delayed(Duration(milliseconds: 1500), () {
  //     CameraPosition(
  //       target: LatLng(15.3579753, 44.2004929),
  //       zoom: 12.4746,
  //       bearing: 0,
  //     );
  //     setBusy(false);
  //   });
  // }
  //
  // getCurrentLocation() async {
  //   setBusy(true);
  //   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
  //       .then((Position position) async {
  //     currentLatLng = LatLng(position.latitude, position.longitude);
  //
  //     kGooglePlex = CameraPosition(
  //       target: currentLatLng!,
  //       zoom: 12.4746,
  //       bearing: 0,
  //     );
  //
  //     await getAddress(currentLatLng!);
  //     setBusy(false);
  //     update();
  //   }).catchError((e) {});
  // }

  getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      currentLatLng = LatLng(position.latitude, position.longitude);

      var ff = await controller.future;
      ff.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: currentLatLng!,
        zoom: 12.4746,
        bearing: 0,
      )));
      getAddress(currentLatLng!);
    }).catchError((e) {});
  }

  // Method for retrieving the current address
  getAddress(LatLng latLng) async {
    try {
      currentLatLng = latLng;
      List<Placemark> p = await placemarkFromCoordinates(
          latLng.latitude, latLng.longitude,


          );

      setLocaleIdentifier( Get.locale.toString());


      Placemark place = p[0];

      _currentAddress =
          "${place.street}, ${place.subLocality ?? ''}, ${place.locality ?? ''} , ${place.administrativeArea ?? ''}, ${place.country}";
      addressController.text = _currentAddress!;

// print(place.locality);

      final Marker marker = Marker(
        markerId: selectedMarkerId,
        position: currentLatLng!,
        // icon: bitmapIcon,
        //  infoWindow: InfoWindow(title: AppStrings.selectedLocation.tr,
        //
        //       snippet: addressController.text
        //  ,onTap: ()async{
        // var c= await  controller.future;
        // c.hideMarkerInfoWindow(selectedMarkerId);
        //
        //      }
        //  ),
        onTap: () => _onMarkerTapped2(selectedMarkerId),
        // consumeTapEvents: true,
        // draggable: true
        // onDragEnd: (LatLng position) => _onMarkerDragEnd(markerId, position),
        //onDrag: (LatLng position) => _onMarkerDrag(markerId, position),
      );
      markers[selectedMarkerId] = marker;

      update();
    } catch (_) {}
  }
  HomeService homeService = Get.arguments;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();


    BookingConstants.reset();


    //logger.i([...riyadh,...diriyah]);


    nextRoute = homeService.next;


    getCurrentLocation();

    // var slide=Slide.slides.where((element) => element.code==homeService.code,).first;
    //
    //
    // Future<Null>.delayed(Duration.zero, () {
    //   DifferentDialog.showServiceInfoSnackBar(description: slide.description!.tr,title: slide.title!.tr,image: slide.image!);
    // });


}







  void _onMarkerTapped2(MarkerId markerId) async {
    DifferentDialog.selectedLocationBottomSheet(desc: addressController.text);
  }

  Future<bool> isLocationAvailable() async {
    List<Placemark> p = await placemarkFromCoordinates(
        currentLatLng!.latitude, currentLatLng!.longitude,
     );

    setLocaleIdentifier( Get.locale.toString());

    Placemark place = p[0];


    selectedLocality=place.locality ??"";
 if(homeService.code=='Car'){

   if(place.isoCountryCode=='SA'){

     return true;}
   else{

     buildFailedSnackBar(
         msg: AppStrings.caregiverSelectLocationOutRangeMsg.tr, duration: 8);
     return false;}



 }
  else  if(homeService.code=='SM' ){


   if([...riyadh,...diriyah].contains(place.locality.toString()))
      {

        return true;}
      else{

        buildFailedSnackBar(
            msg: AppStrings.sleepMedicineSelectLocationOutRangeMsg.tr, duration: 8);
        return false;}



    }
  else  if( homeService.code=='HVD'){


   if([...riyadh,...dammam].contains(place.locality.toString()))
      {

        return true;}
      else{

        buildFailedSnackBar(
            msg: AppStrings.sleepMedicineSelectLocationOutRangeMsg.tr, duration: 8);
        return false;}



    }



 else {
   if (allAllowedLocalities.contains(place.locality)) {
     return true;
   } else {

     buildFailedSnackBar(
         msg: AppStrings.selectLocationOutRangeMsg.tr, duration: 8);
     return false;
   }
 }

  }

  navToNext() async {


    if (addressController.text.isNotEmpty) {
      BookingConstants.location = addressController.text;

      if (await isLocationAvailable()) {
        if (nextRoute == AppRouteNames.register) {
          Get.back(result: addressController.text);
        } else {
          if (nextRoute == AppRouteNames.doctors) {
            DoctorsController.doctorType = 'HVD';
          }


          if(homeService.code=='Car'){

            BookingConstants.showTransportingFee=true;
            await getTransportingFee();

          }
          else{
            BookingConstants.showTransportingFee=false;

            BookingConstants.transportingFee=0.0;
          }

          Get.offAndToNamed(nextRoute, arguments: homeService);
        }
      } else {

      }
    } else {
      buildFailedSnackBar(msg: AppStrings.selectLocationMsg.tr);
    }
  }

  Future<bool> loading() async {
    await Future.delayed(Duration(seconds: 6));
    return true;
  }



 Future<void>  getTransportingFee()async{



    if(![...riyadh,...diriyah].contains(selectedLocality)) {
      // DifferentDialog.showProgressDialog();

      BookingConstants.transportingFee =
      await _appointmentRepository.getTransportFee();
      // DifferentDialog.hideProgressDialog();
    }
    else{
      BookingConstants.transportingFee=0.0;
    }

  }

}
