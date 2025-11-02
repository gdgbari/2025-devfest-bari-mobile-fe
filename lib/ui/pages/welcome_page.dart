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
      appBar: AppBar(backgroundColor: ColorPalette.black, toolbarHeight: 0),
      backgroundColor: ColorPalette.black,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: SvgPicture.asset(
                  'assets/images/devfest_logo.svg',
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  'Join the celebration of\n10 years of innovation!',
                  style: PresetTextStyle.white23w500.copyWith(
                    fontSize: 25,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Center(child: _WelcomeButton()),
              ),
            ),
            SvgPicture.asset(
              'assets/images/skyline_10_years.svg',
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              color: ColorPalette.black,
              height: 20 + MediaQuery.of(context).padding.bottom,
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
            return _CustomButton(
              label: 'Check-in',
              onPressed: checkInOpen
                  ? () => context.read<AuthenticationCubit>().checkIn()
                  : null,
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
