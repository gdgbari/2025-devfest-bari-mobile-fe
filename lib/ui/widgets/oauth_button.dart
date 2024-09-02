import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class OAuthButton extends StatelessWidget {
  final String iconName;

  const OAuthButton(this.iconName, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.pushNamed(RouteNames.loginRoute.name),
      style: TextButton.styleFrom(
        backgroundColor: ColorPalette.black,
        overlayColor: Colors.white,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(left: 40, right: 10, top: 10, bottom: 10),
            child: SvgPicture.asset(
              'assets/images/icons/$iconName.svg',
              width: 30,
            ),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Text(
              'Accedi con ${iconName.capitalize()}',
              style: PresetTextStyle.white19w400,
            ),
          ),
        ],
      ),
    );
  }
}
