
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spot_holder/utils/routes/routes_name.dart';
import '../style/images.dart';
import 'presentation/widget/user_seller_component.dart';

class UserSellerScreen extends StatelessWidget {
  const UserSellerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: const Color(0xffF5AD0D),
        //        appBar: custom_appbar(),
        body: Padding(
          padding: EdgeInsets.only(left: 80.w, top: 40.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UserSellerComponent(
                image: 'assets/user.png',
                text: "User",
                ontap: () {
                  Navigator.pushNamed(context, RoutesName.userLogin);
                },
              ),
              SizedBox(
                height: 50.h,
              ),
              UserSellerComponent(
                  image: Images.parking,
                  text: "Parking Provider",
                  ontap: () {
                    Navigator.pushNamed(context, RoutesName.sellerLogin);
                  }),
              SizedBox(
                height: 80.h,
              ),
              Image.asset(
                Images.logo,
                height: 37.h,
                width: 129.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
