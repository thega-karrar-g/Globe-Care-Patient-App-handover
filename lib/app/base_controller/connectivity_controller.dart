import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../data/eunums/enums.dart';
import '../global_widgets/project_widget/no_connection_flush_bar.dart';

class ConnectivityController extends GetxService {
  final Connectivity _connectivity = Connectivity();

  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>();

   ConnectivityStatus currentConnectivityStatus=ConnectivityStatus.mobileData;

  @override
  void onInit() {
    super.onInit();
    initializeConnectivity();
  }

  initializeConnectivity() async {
    await checkWhenStreamIsNull();
    // Subscribe to the connectivity Changed Stream
    // _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
    //   // Use Connectivity() here to gather more info if you need t
    //   connectionStatusController.sink.add(_getStatusFromResult(result));
    // });



    StreamSubscription<List<ConnectivityResult>> subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {

      // currentConnectivityStatus=result;



      // Received changes in available connectivity types!
    });
  }

  Future checkWhenStreamIsNull() async {
    var connectivityResult = await (_connectivity.checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      currentConnectivityStatus = ConnectivityStatus.offline;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      currentConnectivityStatus = ConnectivityStatus.wiFi;
    } else if (connectivityResult == ConnectivityResult.mobile) {
      currentConnectivityStatus = ConnectivityStatus.mobileData;
    }
  }

  @override
  onClose() {
    connectionStatusController.close();
    return super.onClose();
  }

  // Convert from the third part enum to our own enum

  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        {
          NoConnectionSnackBar.hideNoConnectionSnackBar();
          return currentConnectivityStatus = ConnectivityStatus.mobileData;
        }
      case ConnectivityResult.wifi:
        {
          NoConnectionSnackBar.hideNoConnectionSnackBar();
          return currentConnectivityStatus = ConnectivityStatus.wiFi;
        }
      case ConnectivityResult.none:
        {
          NoConnectionSnackBar.instance.showNoConnectionSnackBar();
          return currentConnectivityStatus = ConnectivityStatus.offline;
        }
      default:
        return ConnectivityStatus.offline;
    }
  }
}
