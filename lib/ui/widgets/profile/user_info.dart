import 'package:devfest_bari_2025/logic.dart';
import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:url_launcher/url_launcher.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        final qrImage = QrImage(
          QrCode.fromData(
            data: 'user:${state.userProfile.userId}',
            errorCorrectLevel: QrErrorCorrectLevel.H,
          ),
        );

        return CustomCard(
          padding: EdgeInsets.all(15),
          child: Row(
            spacing: 15,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: <Widget>[
                    Text(
                      '${state.userProfile.name} ${state.userProfile.surname}',
                      style: PresetTextStyle.black17w700,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Current position: #${state.userProfile.position}',
                      style: PresetTextStyle.black15w400,
                    ),
                    Text(
                      state.userProfile.email,
                      style: PresetTextStyle.black15w400,
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                    GestureDetector(
                      onTap: () => launchUrl(
                        Uri.parse('https://forms.gle/yAhTRZv6JKAYA3BY7'),
                      ),
                      child: Text(
                        'Request data deletion',
                        style: PresetTextStyle.black13w500.copyWith(
                          color: ColorPalette.coreRed,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              UserQrCode(qrImage: qrImage),
            ],
          ),
        );
      },
    );
  }
}
