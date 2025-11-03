import 'package:devfest_bari_2025/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaButton extends StatelessWidget {
  final String name;
  final String url;
  final String description;

  const SocialMediaButton({
    super.key,
    required this.name,
    required this.url,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 15,
      minLeadingWidth: 0,
      minTileHeight: 40,
      minVerticalPadding: 15,
      dense: true,
      splashColor: ColorPalette.gray,
      onTap: () => launchUrl(Uri.parse(url)),
      leading: SvgPicture.asset(
        'assets/images/icons/${name}_logo.svg',
        width: 30,
      ),
      title: Text(description, style: PresetTextStyle.black15w400),
      trailing: Icon(
        Icons.chevron_right_rounded,
        size: 26,
        color: ColorPalette.coreYellow,
      ),
    );
  }
}
