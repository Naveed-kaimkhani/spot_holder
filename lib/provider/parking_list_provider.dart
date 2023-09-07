
import 'package:flutter/material.dart';
import 'package:spot_holder/Domain/models/user_model.dart';
import 'package:spot_holder/utils/utils.dart';

import '../Data/FirebaseUserRepository.dart';
import '../Domain/models/parking_model.dart';
class ParkingListProvider with ChangeNotifier {
  List<ParkingModel>? _parkingList;
  List<ParkingModel>? get parkingList => _parkingList;


    final FirebaseUserRepository firebaseRepository = FirebaseUserRepository();
  Future getUserLocally() async {

    // _parkingList = await StorageService.readUser();
    // notifyListeners();
  }


  
  Future getParkingList(context) async {
   _parkingList = await FirebaseUserRepository.getParkingSpots(context);
print("parking lsitttttt");
print(_parkingList);
    if (_parkingList == null) {
  
      utils.flushBarErrorMessage("No parking found",context);
    }
    notifyListeners();
  }


}
