import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';

class ActivityListPage extends StatelessWidget {
  const ActivityListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.gray,
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(15).copyWith(bottom: 40),
          itemBuilder: (context, index) {
            return ActivityListItem();
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 10);
          },
          itemCount: 5,
        ),
      ),
    );
  }
}
