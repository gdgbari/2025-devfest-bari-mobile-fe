part of 'qr_code_cubit.dart';

enum QrCodeType { none, user, checkin, quiz }

enum QrCodeStatus {
  initial,
  validationInProgress,
  validationSuccess,
  validationFailure,
}

class QrCodeState extends Equatable {
  final QrCodeStatus status;
  final QrCodeType type;
  final String value;

  const QrCodeState({
    this.status = QrCodeStatus.initial,
    this.type = QrCodeType.none,
    this.value = '',
  });

  QrCodeState copyWith({
    QrCodeStatus? status,
    QrCodeType? type,
    String? value,
  }) {
    return QrCodeState(
      status: status ?? this.status,
      type: type ?? this.type,
      value: value ?? this.value,
    );
  }

  @override
  List<Object> get props => [status, type, value];
}
