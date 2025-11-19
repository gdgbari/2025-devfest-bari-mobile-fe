import 'package:devfest_bari_2025/logic.dart';
import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.black,
        toolbarHeight: 0,
      ),
      backgroundColor: ColorPalette.black,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Column(
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/images/devfest_logo.svg',
                      width: MediaQuery.of(context).size.width,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          BlocBuilder<AuthenticationCubit, AuthenticationState>(
                            builder: (context, state) {
                              late final String fileName;
                              switch (state.status) {
                                case AuthenticationStatus.checkInRequired:
                                case AuthenticationStatus.checkInInProgress:
                                case AuthenticationStatus.checkInFailure:
                                  fileName = 'welcome_content_2';
                                  break;
                                default:
                                  fileName = 'welcome_content_1';
                                  break;
                              }
                              return SvgPicture.asset(
                                'assets/images/$fileName.svg',
                                height: 100,
                              );
                            },
                          ),
                          Expanded(child: SizedBox()),
                          Divider(
                            color: ColorPalette.coreYellow,
                            thickness: 4,
                            height: 0,
                          ),
                          Expanded(child: SizedBox()),
                          _WelcomeButton(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom + 20,
              ),
              child: SvgPicture.asset(
                'assets/images/skyline_10_years.svg',
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WelcomeButton extends StatelessWidget {
  const _WelcomeButton();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final authStatus = context.select(
          (AuthenticationCubit cubit) => cubit.state.status,
        );
        final checkInOpen = context.select(
          (RemoteConfigCubit cubit) => cubit.state.config.checkInOpen,
        );

        switch (authStatus) {
          case AuthenticationStatus.checkInRequired:
          case AuthenticationStatus.checkInInProgress:
          case AuthenticationStatus.checkInFailure:
            return Column(
              spacing: 5,
              children: <Widget>[
                _CustomButton(
                  label: 'Check-in',
                  onPressed: checkInOpen
                      ? () => context.read<AuthenticationCubit>().checkIn()
                      : null,
                ),
                Visibility(
                  visible: !checkInOpen,
                  child: Text(
                    'Check-in is still closed, but... get ready!',
                    style: PresetTextStyle.white13w400.copyWith(
                      color: ColorPalette.pastelYellow,
                    ),
                  ),
                ),
              ],
            );
          default:
            return _CustomButton(
              label: 'Sign in with email',
              onPressed: () {
                context.pushNamed(RouteNames.signUpRoute.name);
              },
            );
        }
      },
    );
  }
}

class _CustomButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;

  const _CustomButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: TextButton.styleFrom(
        backgroundColor: ColorPalette.coreYellow,
        disabledBackgroundColor: ColorPalette.pastelYellow,
        overlayColor: Colors.white,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: Size(double.maxFinite, 60),
      ),
      onPressed: onPressed,
      child: Text(label, style: PresetTextStyle.black21w500),
    );
  }
}
