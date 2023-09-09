import 'package:flutter/material.dart';
import 'package:spot_holder/Domain/models/user_model.dart';
import 'package:spot_holder/utils/utils.dart';

import '../Data/FirebaseUserRepository.dart';

class UserProvider with ChangeNotifier {
  UserModel? _userDetails;
  UserModel? get user => _userDetails;

  UserModel? _sellerDetails;
  UserModel? get seller => _sellerDetails;

  final FirebaseUserRepository firebaseRepository = FirebaseUserRepository();
  Future getUserLocally() async {
    // _userDetails = await StorageService.readUser();
    // notifyListeners();
  }

  Future getUserFromServer(context) async {
    _userDetails = await firebaseRepository.getUser();

    if (_userDetails == null) {
      utils.flushBarErrorMessage("No user found", context);
    }
    notifyListeners();
  }

  Future getSellerFromServer(context) async {
    _sellerDetails = await firebaseRepository.getSeller();

    if (_userDetails == null) {
      utils.flushBarErrorMessage("No user found", context);
    }
    notifyListeners();
  }
}
