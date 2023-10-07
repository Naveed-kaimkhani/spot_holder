import 'package:flutter/material.dart';
import 'package:spot_holder/presentation/widget/profile_pic.dart';
import 'package:spot_holder/style/styling.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class custom_appbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String profile;

  const custom_appbar({
    required this.title,
    required this.profile,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Styling.primaryColor,
      title: Text(title),
      actions: [ProfilePic(url: profile, height: 30.h, width: 52.w)],
      leading: IconButton(
        // onPressed: (() => Navigator.pop(context)),
        onPressed: () {},
        icon: Icon(Icons.menu),

        // SvgPicture.asset('asset/backIcon.png')
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60);
}
