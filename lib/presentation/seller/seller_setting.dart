import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spot_holder/presentation/widget/custom_divider.dart';
import 'package:spot_holder/presentation/widget/home_header.dart';
import 'package:spot_holder/utils/routes/routes_name.dart';
import '../../Domain/models/user_model.dart';
import '../../provider/user_provider.dart';
import '../../style/custom_text_style.dart';
import '../../style/styling.dart';
import '../../utils/Dialogues/logout_popup.dart';
import '../widget/services_setting_header.dart';
import 'package:provider/provider.dart';

class SellerSetting extends StatelessWidget {
  const SellerSetting({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel? seller =
        Provider.of<UserProvider>(context, listen: false).seller;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            HomeHeader(
                profile: seller!.profileImage!,
                barTitle: "Settings",
                height: 84.h),
            SizedBox(
              height: 20.h,
            ),
            SettingServicesScreenWidget(
              text: "profile",
              icon: Icons.admin_panel_settings,
              routeName: RoutesName.UpdateSellerProfile,
            ),
            //  ServicesNSettingHeade(text: 'Setting Available'),
            const CustomDivider(),
            SettingServicesScreenWidget(
              text: "Change Password",
              icon: Icons.password_outlined,
              routeName: "SellerPasswordOption",
            ),
            const CustomDivider(),
            SettingServicesScreenWidget(
              text: "Privacy Policy",
              // imageURL: Images.wheel,
              icon: Icons.privacy_tip_outlined,
              routeName: "PrivacyPolicyScreen",
            ),
            const CustomDivider(),
            SettingServicesScreenWidget(
              text: "Contact Us",
              // imageURL: Images.mechanic_pic,
              icon: Icons.phone,
              routeName: RoutesName.contactUs,
            ),
            const CustomDivider(),
            SettingServicesScreenWidget(
              text: "About Us",
              // imageURL: Images.mechanic_pic,
              icon: Icons.admin_panel_settings,
              routeName: RoutesName.aboutUs,
            ),
            const CustomDivider(),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
              child: Row(
                children: [
                  SizedBox(
                    width: 20.w,
                  ),
                  Icon(
                    Icons.logout_outlined,
                    color: Styling.primaryColor,
                    size: 25.h,
                  ),
                  Text(
                    "LogOut",
                    style: CustomTextStyle.font_18_primary,
                  )
                ],
              ),
              onTap: () {
                showLogoutPopup(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
