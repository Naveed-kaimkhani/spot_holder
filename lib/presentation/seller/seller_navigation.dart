import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spot_holder/presentation/seller/parking_status.dart';
import 'package:spot_holder/presentation/seller/seller_homepage.dart';
import 'package:spot_holder/presentation/seller/seller_setting.dart';
import 'package:spot_holder/presentation/seller/seller_wallet.dart';
import 'package:spot_holder/presentation/user/booking.dart';
import 'package:spot_holder/presentation/user/user_homepage.dart';
import 'package:spot_holder/presentation/user/user_wallet.dart';
import '../../style/images.dart';
import '../../style/styling.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SellerNavigation extends StatefulWidget {
  const SellerNavigation({Key? key}) : super(key: key);
  @override
  State<SellerNavigation> createState() => _SellerNavigationState();
}

class _SellerNavigationState extends State<SellerNavigation> {
  List pages = [
    const SellerHomepage(),
    const ParkingStatus(),
    const SellerWallet(),
    const SellerSetting()
    // const DonarDonationsScreen(),
    // const DonarSetting(),
  ];
  int currentindex = 0;
  void onTap(int index) {
    setState(() {
      currentindex = index;
    });
  }

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const SellerHomepage();
  @override
  Widget build(BuildContext context) {
    SizedBox k = SizedBox(
      width: 30.w,
    );
    return Scaffold(
        // backgroundColor: Styling.primaryColor,
        body: PageStorage(bucket: bucket, child: currentScreen),
        bottomNavigationBar: BottomAppBar(
          color: Styling.primaryColor,
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: SizedBox(
              height: 60.h,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            setState(() {
                              currentScreen = const SellerHomepage();
                              currentindex = 0;
                            });
                          },
                          child: SvgPicture.asset(
                            Images.home,
                            height: 26.h,
                            width: 26.w,
                            colorFilter: ColorFilter.mode(
                                currentindex == 0 ? Colors.white : Colors.grey,
                                BlendMode.srcIn),
                          ),
                        ),
                        k,
                        MaterialButton(
                          minWidth: 44,
                          onPressed: () {
                            setState(() {
                              currentScreen = const ParkingStatus();
                              currentindex = 1;
                            });
                          },
                          child: SvgPicture.asset(
                            Images.fat,
                            height: 26.h,
                            width: 26.w,
                            colorFilter: ColorFilter.mode(
                                currentindex == 1 ? Colors.white : Colors.grey,
                                BlendMode.srcIn),
                          ),
                        ),
                        k,
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            setState(() {
                              currentScreen = const SellerWallet();
                              currentindex = 2;
                            });
                          },
                          child: SvgPicture.asset(
                            Images.wallet,
                            height: 26.h,
                            width: 26.w,
                            colorFilter: ColorFilter.mode(
                                currentindex == 2 ? Colors.white : Colors.grey,
                                BlendMode.srcIn),
                          ),
                        ),
                        k,
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            setState(() {
                              currentScreen = const SellerSetting();
                              currentindex = 3;
                            });
                          },
                          child: Icon(
                            size: 36.w,
                            Icons.settings,
                            color:
                                currentindex == 3 ? Colors.white : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ])),
        ));
  }
}
