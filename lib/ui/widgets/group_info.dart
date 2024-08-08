import 'package:devfest_bari_2024/data.dart';
import 'package:flutter/material.dart';

class GroupInfo extends StatelessWidget {
  final Group group;

  const GroupInfo({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 21/9,
      child: Container(
        color: Colors.grey,
        width: MediaQuery.of(context).size.width,
        child: const Icon(
          Icons.photo_camera_outlined,
          color: Colors.black,
          size: 50,
        ),
      ),
    );
  }
}
