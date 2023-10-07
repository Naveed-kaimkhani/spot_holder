import 'package:flutter/material.dart';
import 'package:spot_holder/presentation/about_us.dart';
import 'package:spot_holder/presentation/seller/add_new_parking.dart';
import 'package:spot_holder/presentation/seller/seller_login.dart';
import 'package:spot_holder/presentation/seller/seller_password_option.dart';
import 'package:spot_holder/presentation/seller/seller_sign.dart';
import 'package:spot_holder/presentation/seller/update_seller_profile.dart';
import 'package:spot_holder/presentation/user/change_password.dart';
import 'package:spot_holder/presentation/user/privacy_policy.dart';
import 'package:spot_holder/presentation/user/update_user_profile.dart';
import 'package:spot_holder/presentation/user/user_navigation.dart';
import 'package:spot_holder/presentation/user/user_signup.dart';
import 'package:spot_holder/utils/routes/routes_name.dart';
import '../../presentation/contact_us.dart';
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

      case RoutesName.userSignup:
        return _buildRoute(const UserSignUp(), settings);

      case RoutesName.contactUs:
        return _buildRoute(ContactUs(), settings);

      case RoutesName.aboutUs:
        return _buildRoute(AboutUs(), settings);
      case RoutesName.UpdateSellerProfile:
        return _buildRoute(const UpdateSellerProfile(), settings);
      case RoutesName.sellerPasswordOption:
        return _buildRoute(const SellerPasswordOption(), settings);
      case RoutesName.PrivacyPolicyScreen:
        return _buildRoute(const PrivacyPolicyScreen(), settings);
     case RoutesName.UpdateUserProfile:
        return _buildRoute(UpdateUserProfile(), settings);
     case RoutesName.sellerLogin:
        return _buildRoute(SellerLogin(), settings);

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
