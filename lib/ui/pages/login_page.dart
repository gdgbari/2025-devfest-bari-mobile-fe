import 'package:devfest_bari_2024/logic.dart';
import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              CustomTextField(
                hint: 'Email',
                controller: emailTextController,
                onChanged: (email) => emailTextController.text = email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                hint: 'Password',
                controller: passwordTextController,
                onChanged: (email) => passwordTextController.text = email,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    context
                        .read<AuthenticationCubit>()
                        .signInWithEmailAndPassword(
                          email: emailTextController.text,
                          password: passwordTextController.text,
                        );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(color: Colors.white),
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
