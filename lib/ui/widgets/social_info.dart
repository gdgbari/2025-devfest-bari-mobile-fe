import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/material.dart';

class SocialInfo extends StatelessWidget {
  const SocialInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Seguici sui social',
          style: PresetTextStyle.black23w500,
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SocialMediaButton(
              name: 'instagram',
              url: 'https://www.instagram.com/gdgbari/',
            ),
            SocialMediaButton(
              name: 'x',
              url: 'https://x.com/gdgbari/',
            ),
            SocialMediaButton(
              name: 'linkedin',
              url: 'https://www.linkedin.com/company/gdgbari/',
            ),
          ],
        ),
      ],
    );
  }
}
