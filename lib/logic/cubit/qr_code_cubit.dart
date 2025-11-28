import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'qr_code_state.dart';

class QrCodeCubit extends Cubit<QrCodeState> {
  QrCodeCubit() : super(QrCodeState());

  void resetQrCode() => emit(QrCodeState());

  void validateQrCode(String? value, QrCodeType expectedType) {
    emit(state.copyWith(status: QrCodeStatus.validationInProgress));

    if (value != null && value.isNotEmpty) {
      if (value.startsWith('user:') && expectedType == QrCodeType.user) {
        return emit(
          state.copyWith(
            status: QrCodeStatus.validationSuccess,
            type: QrCodeType.user,
            value: value,
          ),
        );
      }

      if (value.startsWith('quiz:') && expectedType == QrCodeType.quiz) {
        return emit(
          state.copyWith(
            status: QrCodeStatus.validationSuccess,
            type: QrCodeType.quiz,
            value: value,
          ),
        );
      }

      if (value.startsWith('tag:') && expectedType == QrCodeType.tag) {
        return emit(
          state.copyWith(
            status: QrCodeStatus.validationSuccess,
            type: QrCodeType.tag,
            value: value,
          ),
        );
      }
    }

    emit(state.copyWith(status: QrCodeStatus.validationFailure));
  }
}
