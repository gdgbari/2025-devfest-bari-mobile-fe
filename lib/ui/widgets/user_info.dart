import 'package:devfest_bari_2024/data.dart';
import 'package:devfest_bari_2024/ui/theme/preset_text_style.dart';
import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  final UserProfile userProfile;

  const UserInfo({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '${userProfile.name} ${userProfile.surname}',
          style: PresetTextStyle.black15w400,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        Text(
          userProfile.email,
          style: PresetTextStyle.black15w400,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}
