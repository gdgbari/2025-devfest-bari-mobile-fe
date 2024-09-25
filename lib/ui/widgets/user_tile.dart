import 'package:devfest_bari_2024/data/models/user_profile.dart';
import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final UserProfile userProfile;

  const UserTile({
    super.key,
    required this.userProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: userProfile.group.colors.secondaryColor,
        border: Border.all(
          color: userProfile.group.colors.primaryColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 50,
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: userProfile.group.colors.primaryColor,
            radius: 15,
            child: Text(
              '${userProfile.position}°',
              style: PresetTextStyle.white13w400,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              userProfile.nickname,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              maxLines: 1,
              style: PresetTextStyle.black17w400,
            ),
          ),
          const SizedBox(width: 15),
          RichText(
            text: TextSpan(
              text: '${userProfile.score}',
              style: PresetTextStyle.black17w500,
              children: const <InlineSpan>[
                TextSpan(
                  text: ' punti',
                  style: PresetTextStyle.black17w400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
