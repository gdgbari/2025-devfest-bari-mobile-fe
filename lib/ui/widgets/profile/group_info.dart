import 'package:devfest_bari_2025/data.dart';
import 'package:devfest_bari_2025/logic.dart';
import 'package:devfest_bari_2025/ui.dart';
import 'package:devfest_bari_2025/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupInfo extends StatelessWidget {
  const GroupInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        final group = state.isAuthenticated ? state.userProfile.group : Group();

        return CustomCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 21 / 9,
                child: Image.asset(
                  'assets/images/team_${group.name}.png',
                  errorBuilder: (context, error, stackTrace) =>
                      Image.asset('assets/images/team_null.png'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: RichText(
                  text: TextSpan(
                    text: 'Team ${group.name.capitalize()}\n',
                    style: PresetTextStyle.black17w700,
                    children: <InlineSpan>[
                      TextSpan(
                        text: 'Current position: #${group.position}',
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
    );
  }
}
