import 'package:devfest_bari_2024/logic.dart';
import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            final qrImage = QrImage(
              QrCode.fromData(
                data: 'user:${state.userProfile.userId}',
                errorCorrectLevel: QrErrorCorrectLevel.M,
              ),
            );

            return Column(
              children: <Widget>[
                GroupInfo(group: state.userProfile.group),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        UserInfo(userProfile: state.userProfile),
                        SizedBox(height: 40),
                        Expanded(
                          child: Center(
                            child: PrettyQrView(
                              qrImage: qrImage,
                              decoration: const PrettyQrDecoration(
                                shape: PrettyQrSmoothSymbol(
                                  color: ColorPalette.black,
                                ),
                                image: PrettyQrDecorationImage(
                                  image: AssetImage('assets/images/user.png'),
                                  scale: 0.3,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        const SocialInfo(),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
