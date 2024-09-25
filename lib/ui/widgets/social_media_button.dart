import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaButton extends StatelessWidget {
  final String name;
  final String url;

  const SocialMediaButton({
    super.key,
    required this.name,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => launchUrl(Uri.parse(url)),
      child: SvgPicture.asset(
        'assets/images/icons/${name}_logo.svg',
        width: 50,
      ),
    );
  }
}
