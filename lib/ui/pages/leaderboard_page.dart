import 'package:devfest_bari_2025/logic.dart';
import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeaderboardPage extends StatelessWidget {
  final pageController = PageController();

  LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20).copyWith(bottom: 0),
          child: BlocConsumer<LeaderboardCubit, LeaderboardState>(
            listenWhen: (previous, current) =>
                previous.pageIndex != current.pageIndex,
            listener: (context, state) {
              pageController.jumpToPage(state.pageIndex);
            },
            builder: (context, state) {
              switch (state.status) {
                case LeaderboardStatus.initial:
                case LeaderboardStatus.fetchInProgress:
                  return Center(child: CustomLoader());
                case LeaderboardStatus.fetchFailure:
                  return Center(
                    child: Text(
                      'The leaderboard\nis not available',
                      style: PresetTextStyle.black23w400,
                      textAlign: TextAlign.center,
                    ),
                  );
                case LeaderboardStatus.fetchSuccess:
                  final pageIndex = state.pageIndex;

                  return BlocBuilder<RemoteConfigCubit, RemoteConfigState>(
                    builder: (context, state) {
                      return state.config.leaderboardOpen
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                CustomSegmentedButton(
                                  index: pageIndex,
                                  onValueChanged: (value) => context
                                      .read<LeaderboardCubit>()
                                      .changeLeaderboard(value),
                                ),
                                const SizedBox(height: 20),
                                Expanded(
                                  child: PageView(
                                    controller: pageController,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: const <Widget>[
                                      UserLeaderboardView(),
                                      GroupLeaderboardView(),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Center(
                              child: Text.rich(
                                TextSpan(
                                  text: '🏆 ANNOUNCEMENT 🏆\n\n',
                                  style: PresetTextStyle.black23w700,
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text:
                                          'The final leaderboard will be shown in ',
                                      style: PresetTextStyle.black21w400,
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text: state.config.winnerRoom,
                                          style: PresetTextStyle.black21w700,
                                        ),
                                        TextSpan(
                                          text: ' at ',
                                          style: PresetTextStyle.black21w400,
                                        ),
                                        TextSpan(
                                          text: state.config.winnerTime,
                                          style: PresetTextStyle.black21w700,
                                        ),
                                      ],
                                    ),
                                    TextSpan(text: '\n\n'),
                                    TextSpan(
                                      text:
                                          'Join us to discover the winners and get amazing prizes! 🏅',
                                      style: PresetTextStyle.black21w400,
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                    },
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
