import 'package:devfest_bari_2025/logic.dart';
import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({super.key});

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  late final MobileScannerController controller;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: <BlocListener>[
        BlocListener<QrCodeCubit, QrCodeState>(
          listener: (context, state) async {
            switch (state.status) {
              case QrCodeStatus.validationInProgress:
                context.loaderOverlay.show();
                break;
              case QrCodeStatus.validationSuccess:
                context.loaderOverlay.hide();
                if (state.type == QrCodeType.quiz) {
                  context.read<QuizCubit>().getQuiz(
                    state.value.split(':').last,
                  );
                } else if (state.type == QrCodeType.tag) {
                  context.read<TagsCubit>().assignTag(
                    state.value.split(':').last,
                  );
                }
                break;
              case QrCodeStatus.validationFailure:
                context.loaderOverlay.hide();
                await showCustomErrorDialog(
                  context,
                  'Hey, this QR code doesn\'t work.\nPlease try with another one.',
                );
                controller.start();
                break;
              default:
                break;
            }
          },
        ),
        BlocListener<QuizCubit, QuizState>(
          listener: (context, state) async {
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
                late String errorMessage;
                switch (state.error) {
                  case QuizError.quizNotFound:
                    errorMessage = 'Quiz not found.\nPlease try another one.';
                    break;
                  case QuizError.quizNotOpen:
                    errorMessage = 'Quiz not open.\nPlease scan the right one.';
                    break;
                  case QuizError.quizTimeIsUp:
                    errorMessage = 'Oops, you ran out of time.';
                    break;
                  case QuizError.quizAlreadySubmitted:
                    errorMessage =
                        'You have already answered to this quiz.\n'
                        'There are a lot of them, go and find another one!';
                    break;
                  case QuizError.unknown:
                    errorMessage =
                        'An unknown error occurred.\nPlease try again later.';
                    break;
                  default:
                    break;
                }
                await showCustomErrorDialog(context, errorMessage);
                controller.start();
                break;
              default:
            }
          },
        ),
        BlocListener<TagsCubit, TagsState>(
          listener: (context, state) async {
            switch (state.status) {
              case TagsStatus.loading:
                context.loaderOverlay.show();
                break;
              case TagsStatus.success:
                context.loaderOverlay.hide();
                await showCustomSuccessDialog(
                  context,
                  'Tag assigned successfully!\nYou earned ${state.points} points.',
                );
                controller.start();
                break;
              case TagsStatus.failure:
                context.loaderOverlay.hide();
                late String errorMessage;
                switch (state.error) {
                  case TagsError.tagNotFound:
                    errorMessage = 'Tag not found.\nPlease try another one.';
                    break;
                  case TagsError.tagAlreadyAssigned:
                    errorMessage = 'Tag already assigned.\nFind another one!';
                    break;
                  case TagsError.unknown:
                    errorMessage =
                        'An unknown error occurred.\nPlease try again later.';
                    break;
                  default:
                    errorMessage = 'An error occurred.';
                }
                await showCustomErrorDialog(context, errorMessage);
                controller.start();
                break;
              default:
                break;
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('QR code', style: PresetTextStyle.black21w500),
          centerTitle: false,
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back, color: ColorPalette.black),
          ),
        ),
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: <Widget>[
              MobileScanner(
                controller: controller,
                onDetect: (barcodes) {
                  final qrData = barcodes.barcodes.first;
                  if (qrData.type == BarcodeType.text) {
                    controller.stop();
                    context.read<QrCodeCubit>().validateQrCode(
                      qrData.rawValue,
                    );
                  }
                },
              ),
              if (!kIsWeb) const QRCodeBackground(),
              Center(
                child: SvgPicture.asset(
                  'assets/images/qr_marker.svg',
                  width: MediaQuery.of(context).size.width / 1.75,
                  // colorFilter: const ColorFilter.mode(
                  //   Colors.white,
                  //   BlendMode.srcIn,
                  // ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
