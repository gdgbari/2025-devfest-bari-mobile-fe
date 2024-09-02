import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.black,
        title: const Text(
          'DevFest Bari 2024',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: SvgPicture.asset(
                  'assets/images/devfest_logo.svg',
                  width: double.maxFinite,
                ),
              ),
              const SizedBox(height: 20),
              const OAuthButton('email'),
              const SizedBox(height: 10),
              const OAuthButton('google'),
              const SizedBox(height: 10),
              const OAuthButton('apple'),
            ],
          ),
        ),
      ),
    );
  }
}
