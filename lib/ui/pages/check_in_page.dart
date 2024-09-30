import 'package:devfest_bari_2024/logic.dart';
import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CheckInPage extends StatelessWidget {
  CheckInPage({super.key});

  final controller = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.black,
        title: const Text(
          'Check-in',
          style: PresetTextStyle.white21w500,
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              context
                  .read<AuthenticationCubit>()
                  .checkIn('checkin:DGBFrhOTqGmsojSgrpF0');
            },
            icon: const Icon(
              Icons.qr_code,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  MobileScanner(
                    controller: controller,
                    onDetect: (barcodes) {
                      final qrData = barcodes.barcodes.first;
                      if (qrData.type == BarcodeType.text) {
                        if (qrData.rawValue != null &&
                            qrData.rawValue!.isNotEmpty) {
                          print('QR DATA:\n${qrData.rawValue!}');
                        }
                      }
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
    );
  }
}
