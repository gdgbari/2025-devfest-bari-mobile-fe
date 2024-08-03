import 'package:devfest_bari_2024/data.dart';
import 'package:devfest_bari_2024/ui/theme/preset_text_style.dart';
import 'package:flutter/material.dart';

class GroupInfo extends StatelessWidget {
  final Group group;

  const GroupInfo({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
            ),
            child: const Icon(
              Icons.photo_camera_outlined,
              color: Colors.black,
              size: 30,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            group.name,
            style: PresetTextStyle.black15w400,
          ),
        ],
      ),
    );
  }
}
