import 'package:devfest_bari_2025/logic.dart';
import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.white,
        forceMaterialTransparency: true,
        title: const Text(
          'Sign in with Email',
          style: PresetTextStyle.black21w500,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back, color: ColorPalette.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Email', style: PresetTextStyle.black13w500),
              const SizedBox(height: 5),
              CustomTextField(
                hint: 'Email',
                controller: emailTextController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              const Text('Password', style: PresetTextStyle.black13w500),
              const SizedBox(height: 5),
              CustomTextField(
                hint: 'Password',
                controller: passwordTextController,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: double.maxFinite,
                child: TextButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    context
                        .read<AuthenticationCubit>()
                        .signInWithEmailAndPassword(
                          email: emailTextController.text.trim(),
                          password: passwordTextController.text,
                        );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: ColorPalette.coreYellow,
                    overlayColor: Colors.white,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'SIGN IN',
                    style: PresetTextStyle.white19w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
