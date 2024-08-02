import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodePage extends StatelessWidget {
  QrCodePage({super.key});

  final controller = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'QR code',
          style: TextStyle(color: Colors.white),
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
        child: Stack(
          children: <Widget>[
            MobileScanner(
              controller: controller,
              onDetect: (barcodes) {
                final qrData = barcodes.barcodes.first;
                if (qrData.type == BarcodeType.text) {
                  if (qrData.rawValue != null && qrData.rawValue!.isNotEmpty) {
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
    );
  }
}
