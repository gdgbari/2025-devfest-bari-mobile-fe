import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> showCustomSuccessDialog(
  BuildContext context,
  String message,
) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) =>
        CustomSuccessDialog(onPressed: () => context.pop(), message: message),
  );
}

class CustomSuccessDialog extends StatelessWidget {
  final void Function()? onPressed;
  final String message;

  const CustomSuccessDialog({
    super.key,
    required this.onPressed,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'SUCCESS',
        style: PresetTextStyle.black23w500.copyWith(
          color: ColorPalette.coreGreen,
        ),
      ),
      content: Text(message, style: PresetTextStyle.black19w400),
      actions: <Widget>[
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: ColorPalette.coreYellow,
            overlayColor: Colors.white,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const SizedBox(
            height: 40,
            width: double.maxFinite,
            child: Center(
              child: Text('OK', style: PresetTextStyle.white19w500),
            ),
          ),
        ),
      ],
    );
  }
}
