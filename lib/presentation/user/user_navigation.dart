import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spot_holder/presentation/user/booking.dart';
import 'package:spot_holder/presentation/user/parking_spots_onMap.dart';
import 'package:spot_holder/presentation/user/user_homepage.dart';
import 'package:spot_holder/presentation/user/user_setting.dart';
import 'package:spot_holder/presentation/user/user_wallet.dart';
import '../../style/images.dart';
import '../../style/styling.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserNavigation extends StatefulWidget {
  const UserNavigation({Key? key}) : super(key: key);
  @override
  State<UserNavigation> createState() => _UserNavigationState();
}

class _UserNavigationState extends State<UserNavigation> {
  List pages = [
    const UserHomepage(),
    const ParkingSpotsOnMap(),
    const UserWallet(),
    const UserSetting()
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
  Widget currentScreen = const UserHomepage();
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
                              currentScreen = const UserHomepage();
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
                          minWidth: 40,
                          onPressed: () {
                            setState(() {
                              currentScreen = const ParkingSpotsOnMap();
                              currentindex = 1;
                            });
                          },
                          child: SvgPicture.asset(
                            Images.dashboard,
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
                              currentScreen = const UserWallet();
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
                              currentScreen = const UserSetting();
                              currentindex = 3;
                            });
                          },
                          child: Icon(
                            size: 38.w,
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
