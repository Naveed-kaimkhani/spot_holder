import 'package:flutter/material.dart';
import 'package:spot_holder/style/styling.dart';

class custom_appbar extends StatelessWidget implements PreferredSizeWidget {
final String title;
  const custom_appbar({
   required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Styling.primaryColor,
      title: Text(title),
      actions: [Icon(Icons.person_3_outlined)],
      leading: IconButton(
        onPressed: (() => Navigator.pop(context)),
        icon: Icon(Icons.menu),

        // SvgPicture.asset('asset/backIcon.png')
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60);
}
