import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.pastelRed,
        toolbarHeight: 0,
      ),
      backgroundColor: ColorPalette.pastelRed,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 15,
              child: SvgPicture.asset(
                'assets/images/welcome.svg',
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
              ),
            ),
            Flexible(
              flex: 3,
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: OAuthButton(
                      method: 'email',
                      onPressed: () =>
                          context.pushNamed(RouteNames.signUpRoute.name),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).padding.bottom,
            ),
            // TODO: future implementation
            // const SizedBox(height: 10),
            // OAuthButton(
            //   method: 'google',
            //   onPressed: () => context.pushNamed(RouteNames.loginRoute.name),
            // ),
            // const SizedBox(height: 10),
            // OAuthButton(
            //   method: 'apple',
            //   onPressed: () => context.pushNamed(RouteNames.loginRoute.name),
            // ),
          ],
        ),
      ),
    );
  }
}
