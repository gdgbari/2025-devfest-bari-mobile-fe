import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';

class SocialInfo extends StatelessWidget {
  const SocialInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: EdgeInsets.all(15),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          SocialMediaButton(
            name: 'instagram',
            url: 'https://www.instagram.com/gdgbari/',
            description: 'Follow us on Instagram',
          ),
          Divider(),
          SocialMediaButton(
            name: 'x',
            url: 'https://x.com/gdgbari/',
            description: 'Follow us on X',
          ),
          Divider(),
          SocialMediaButton(
            name: 'linkedin',
            url: 'https://www.linkedin.com/company/gdgbari/',
            description: 'Follow us on LinkedIn',
          ),
        ],
      ),
    );
  }
}
