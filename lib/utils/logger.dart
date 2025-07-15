import 'package:talker/talker.dart';

class SuccessLog extends TalkerLog {
  SuccessLog(super.message);

  static const logKey = 'success';

  @override
  String? get key => logKey;
}

final logger = Talker(
  settings: TalkerSettings(
    colors: {
      TalkerLogType.info.key: AnsiPen()..cyan(),
      SuccessLog.logKey: AnsiPen()..green(),
    },
  ),
);

void logDebug(String message) => logger.debug(message);

void logInfo(String message) => logger.info(message);

void logSuccess(String message) => logger.logCustom(SuccessLog(message));

void logWarning(String message) => logger.warning(message);

void logError(String errorMessage) => logger.error(errorMessage);

void logException(Object exception, [StackTrace? stackTrace]) {
  logger.handle(exception, stackTrace);
}
