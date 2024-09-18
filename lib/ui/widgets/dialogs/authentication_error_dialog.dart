import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> showAuthenticationErrorDialog(
  BuildContext context,
  String errorMessage,
) async {
  showDialog(
    context: context,
    builder: (_) => AuthenticationErrorDialog(
      onPressed: () => context.pop(),
      errorMessage: errorMessage,
    ),
  );
}

class AuthenticationErrorDialog extends StatelessWidget {
  final void Function()? onPressed;
  final String errorMessage;

  const AuthenticationErrorDialog({
    super.key,
    required this.onPressed,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'ERRORE',
        style: PresetTextStyle.black23w500.copyWith(
          color: ColorPalette.coreRed,
        ),
      ),
      content: Text(
        errorMessage,
        style: PresetTextStyle.black19w400,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: ColorPalette.black,
            overlayColor: Colors.white,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const SizedBox(
            height: 40,
            width: double.maxFinite,
            child: Center(
              child: Text(
                'OK',
                style: PresetTextStyle.white19w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
