import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ColorPalette.gray),
      child: ListView(
        padding: EdgeInsets.all(15),
        children: <Widget>[
          GroupInfo(),
          SizedBox(height: 15),
          UserInfo(),
          SizedBox(height: 15),
          SocialInfo(),
          SizedBox(height: 15),
          Text(
            'Developed with ❤️ by GDG Bari dev team',
            style: PresetTextStyle.black13w400,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
