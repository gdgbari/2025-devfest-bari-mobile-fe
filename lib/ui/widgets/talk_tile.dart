import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/Material.dart';

class TalkTile extends StatelessWidget {
  final void Function()? onTap;
  final Color color;
  final String title;

  const TalkTile({
    super.key,
    this.onTap,
    this.color = Colors.blue,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            title,
            style: PresetTextStyle.black15w400,
          ),
        ),
      ),
    );
  }
}
