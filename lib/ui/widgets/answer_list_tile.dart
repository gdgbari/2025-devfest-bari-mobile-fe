import 'package:flutter/material.dart';

class AnswerListTile extends StatelessWidget {
  final String value;
  final String? groupValue;
  final void Function(String?)? onChanged;
  final String title;
  final Color color;

  const AnswerListTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => onChanged?.call(value),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: <Widget>[
            Radio<String>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: color,
            ),
            Expanded(child: Text(title)),
          ],
        ),
      ),
    );
  }
}
