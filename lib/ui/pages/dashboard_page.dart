import 'package:devfest_bari_2025/logic.dart';
import 'package:devfest_bari_2025/ui.dart';
import 'package:devfest_bari_2025/ui/widgets/dashboard/dashboard_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final buttons = [
      {
        'icon': Icons.leaderboard_outlined,
        'iconColor': ColorPalette.coreGreen,
        'title': 'Leaderboard',
        'subtitle': 'Rise to the top',
        'onTap': () => context.pushNamed(RouteNames.leaderboardRoute.name),
      },
      {
        'icon': Icons.calendar_month_outlined,
        'iconColor': ColorPalette.coreBlue,
        'title': 'Schedule',
        'subtitle': 'See what\'s on',
        'onTap': () => launchUrl(Uri.parse('https://bari.devfest.it/schedule')),
      },
      {
        'icon': Icons.rocket_launch_outlined,
        'iconColor': ColorPalette.coreRed,
        'title': 'Activities',
        'subtitle': 'Dive into the action',
        'onTap': () {},
      },
      {
        'icon': Icons.emoji_events_outlined,
        'iconColor': ColorPalette.coreYellow,
        'title': 'Final contest',
        'subtitle': 'Claim the glory',
        'onTap': () {},
      },
    ];

    return Container(
      decoration: BoxDecoration(color: ColorPalette.gray),
      child: ListView(
        padding: EdgeInsets.all(15),
        children: <Widget>[
          BlocSelector<AuthenticationCubit, AuthenticationState, String>(
            selector: (state) => state.userProfile.name,
            builder: (context, name) {
              return CustomCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      color: ColorPalette.black,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 140,
                      child: SvgPicture.asset('assets/images/devfest_logo.svg'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: RichText(
                        text: TextSpan(
                          text: 'Hello $name!\n',
                          style: PresetTextStyle.black19w700,
                          children: <InlineSpan>[
                            TextSpan(
                              text: 'Ready to build, learn and connect?',
                              style: PresetTextStyle.black15w400.copyWith(
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 15),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: MediaQuery.widthOf(context) < 400 ? 1.4 : 1.6,
            children: List.generate(
              buttons.length,
              (index) => DashboardButton(
                icon: buttons[index]['icon'] as IconData,
                iconColor: buttons[index]['iconColor'] as Color,
                title: buttons[index]['title'] as String,
                subtitle: buttons[index]['subtitle'] as String,
                onTap: buttons[index]['onTap'] as VoidCallback,
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
