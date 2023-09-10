import 'package:flutter/material.dart';

class SettingServicesScreenWidget extends StatelessWidget {
  String text;
  String? imageURL;
  IconData? icon;
  String routeName;
  SettingServicesScreenWidget({super.key, 
    this.imageURL,
    this.icon,
    required this.routeName,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: InkWell(
        child: ListTile(
          title: Text(text),
          leading: imageURL != null ? Image.asset(imageURL!) : Icon(icon),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        onTap: () {
          Navigator.pushNamed(context, routeName);

          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => PasswordOption()));
        },
      ),
    );
  }
}
