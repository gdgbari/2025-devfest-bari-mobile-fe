import 'package:devfest_bari_2024/logic.dart';
import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodePage extends StatelessWidget {
  QrCodePage({super.key});

  final controller = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuizCubit, QuizState>(
      listener: _quizListener,
      child: Scaffold(
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
          actions: <Widget>[
            IconButton(
              onPressed: () {
                // TODO: only for testing => move all to "onDetect"
                context.read<QuizCubit>().getQuiz('osCBQg7hlgDI5ya2iz9l');
              },
              icon: const Icon(
                Icons.qr_code,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: SafeArea(
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
      ),
    );
  }
}

void _quizListener(
  BuildContext context,
  QuizState state,
) {
  switch (state.status) {
    case QuizStatus.fetchInProgress:
      context.loaderOverlay.show();
      break;
    case QuizStatus.fetchSuccess:
      context.loaderOverlay.hide();
      context.pushReplacementNamed(RouteNames.quizRoute.name);
      break;
    case QuizStatus.fetchFailure:
      context.loaderOverlay.hide();
      // TODO: show error message
      break;
    default:
  }
}
