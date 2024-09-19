import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OAuthButton extends StatelessWidget {
  final String method;
  final void Function()? onPressed;

  const OAuthButton({
    super.key,
    required this.method,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: ColorPalette.black,
          overlayColor: Colors.white,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: 40,
                right: 10,
                top: 10,
                bottom: 10,
              ),
              child: SvgPicture.asset(
                'assets/images/icons/$method.svg',
                width: 30,
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: Text(
                'Accedi con ${method.capitalize()}',
                style: PresetTextStyle.white19w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
