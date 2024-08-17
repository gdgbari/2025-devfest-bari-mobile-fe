import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuizResultsDialog extends StatelessWidget {
  final void Function()? onPressed;
  final Widget content;

  const QuizResultsDialog({
    super.key,
    required this.onPressed,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('RISULTATI'),
      content: SizedBox(
        height: MediaQuery.of(context).size.height / 8,
        width: MediaQuery.of(context).size.width - 40,
        child: content,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const SizedBox(
            height: 50,
            width: double.maxFinite,
            child: Center(
              child: Text(
                'OK',
                style: PresetTextStyle.white15w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
