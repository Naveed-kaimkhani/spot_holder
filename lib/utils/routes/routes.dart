import 'package:flutter/material.dart';
import 'package:spot_holder/presentation/seller/add_new_parking.dart';
import 'package:spot_holder/presentation/seller/seller_sign.dart';
import 'package:spot_holder/presentation/user/change_password.dart';
import 'package:spot_holder/presentation/user/user_navigation.dart';
import 'package:spot_holder/utils/routes/routes_name.dart';

import '../../presentation/user/user_login.dart';

class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.userLogin:
        return _buildRoute(const UserLogin(), settings);
      case RoutesName.sellerSignup:
        return _buildRoute(const SellerSignUp(), settings);
      case RoutesName.addNewParking:
        return _buildRoute(const AddNewParking(), settings);

      case RoutesName.userNavigation:
        return _buildRoute(const UserNavigation(), settings);

      case RoutesName.passwordOption:
        return _buildRoute(const PasswordOption(), settings);

      // case RoutesName.trackDonation:
      //   return _buildRoute( TrackDonation(), settings);

      // case RoutesName.userSingup:
      //   return _buildRoute(const UserSignup(), settings);

      // case RoutesName.sellerSignup:
      //   return _buildRoute(const SellerSignUp(), settings);

      // case RoutesName.userLogin:
      //   return _buildRoute(const UserLogin(), settings);

      // case RoutesName.petrolProviders:
      //   return _buildRoute(const PetrolProviders(), settings);

      // case RoutesName.generalMechanic:
      //   return _buildRoute(const GeneralMechanic(), settings);

      // case RoutesName.punctureMaker:
      //   return _buildRoute(const PunctureMaker(), settings);
      default:
        return _buildRoute(
            const Scaffold(
              body: Center(
                child: Text("NO Route Found"),
              ),
            ),
            settings);
    }
  }

  static _buildRoute(Widget widget, RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => widget, settings: settings);
  }
}
