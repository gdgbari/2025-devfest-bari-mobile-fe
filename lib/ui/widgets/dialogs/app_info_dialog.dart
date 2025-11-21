import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> showAppInfoDialog(
  BuildContext context,
  String title,
  String content,
) async {
  await showDialog(
    context: context,
    builder: (_) => AppInfoDialog(
      onPressed: () => context.pop(),
      title: title,
      content: content,
    ),
  );
}

class AppInfoDialog extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final String content;

  const AppInfoDialog({
    super.key,
    required this.onPressed,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title.isNotEmpty ? title.toUpperCase() : 'Loading...',
        style: PresetTextStyle.black23w500,
        textAlign: TextAlign.center,
      ),
      content: title.isEmpty && content.isEmpty
          ? SizedBox(height: 80, child: Center(child: CustomLoader()))
          : Text(
              content.replaceAll(r'\n', '\n').replaceAll(r'\t', '\t'),
              style: PresetTextStyle.black19w400,
            ),
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
