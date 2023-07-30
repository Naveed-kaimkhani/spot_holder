import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spot_holder/presentation/user/user_homepage.dart';
import '../../style/images.dart';
import '../../style/styling.dart';

class UserNavigation extends StatefulWidget {
  const UserNavigation({Key? key}) : super(key: key);
  @override
  State<UserNavigation> createState() => _UserNavigationState();
}

class _UserNavigationState extends State<UserNavigation> {
  List pages = [
    UserHomepage(),
    // DonateFood(),
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
  Widget currentScreen = UserHomepage();
  @override
  Widget build(BuildContext context) {
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
                              currentScreen = UserHomepage();
                              currentindex = 0;
                            });
                          },
                          child: Image.asset(
                            Images.home,
                            height: 26.h,
                            width: 26.w,
                            color:
                                currentindex == 0 ? Colors.white : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ])),
        ));
  }
}
