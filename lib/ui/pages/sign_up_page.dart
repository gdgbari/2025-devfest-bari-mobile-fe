import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatelessWidget {
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: ColorPalette.black,
        title: const Text(
          'Registrazione',
          style: PresetTextStyle.white23w500,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const Text(
                'Unisciti alla DevFest Bari 2024!',
                style: PresetTextStyle.black19w500,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                hint: 'Nome',
                controller: nameController,
                onChanged: (name) => nameController.text = name,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hint: 'Cognome',
                controller: surnameController,
                onChanged: (surname) => surnameController.text = surname,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hint: 'Email',
                controller: emailTextController,
                onChanged: (email) => emailTextController.text = email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hint: 'Password',
                controller: passwordTextController,
                onChanged: (email) => passwordTextController.text = email,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: double.maxFinite,
                child: TextButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    // TODO
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: ColorPalette.black,
                    overlayColor: Colors.white,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'ISCRIVITI',
                    style: PresetTextStyle.white21w400,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: 'Hai già un account? ',
                  style: PresetTextStyle.black17w400,
                  children: <InlineSpan>[
                    TextSpan(
                      text: 'Accedi',
                      style: const TextStyle(
                        color: ColorPalette.coreRed,
                        fontWeight: FontWeight.w500,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => context.pushNamed(
                              RouteNames.loginRoute.name,
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
