import 'package:devfest_bari_2024/logic.dart';
import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CheckInPage extends StatelessWidget {
  CheckInPage({super.key});

  final controller = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<QrCodeCubit, QrCodeState>(
      listener: _qrCodeListener,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPalette.black,
          title: const Text(
            'Check-in',
            style: PresetTextStyle.white21w500,
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Builder(
                      builder: (context) {
                        final qrState = context.watch<QrCodeCubit>().state;
                        final authState =
                            context.watch<AuthenticationCubit>().state;

                        return MobileScanner(
                          controller: controller,
                          onDetect: (barcodes) {
                            final qrData = barcodes.barcodes.first;
                            if (qrData.type == BarcodeType.text) {
                              if (qrState.status !=
                                      QrCodeStatus.validationInProgress &&
                                  authState.status !=
                                      AuthenticationStatus.checkInInProgress) {
                                context.read<QrCodeCubit>().validateQrCode(
                                      qrData.rawValue,
                                      QrCodeType.checkin,
                                    );
                              }
                            }
                          },
                        );
                      },
                    ),
                    const QRCodeBackground(),
                    Center(
                      child: SvgPicture.asset(
                        'assets/images/qr_marker.svg',
                        width: MediaQuery.of(context).size.width / 1.75,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Please scan the QR code that you\nreceived during the check-in',
                  style: PresetTextStyle.black17w400,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _qrCodeListener(
  BuildContext context,
  QrCodeState state,
) {
  switch (state.status) {
    case QrCodeStatus.validationInProgress:
      context.loaderOverlay.show();
      break;
    case QrCodeStatus.validationSuccess:
      context.loaderOverlay.hide();
      context.read<AuthenticationCubit>().checkIn(state.value);
      break;
    case QrCodeStatus.validationFailure:
      context.loaderOverlay.hide();
      showCustomErrorDialog(
        context,
        'Hey, this QR code doesn\'t work.\nPlease try with another one.',
      );
      break;
    default:
      break;
  }
}
