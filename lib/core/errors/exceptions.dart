import 'package:logger/logger.dart';

abstract class AppException implements Exception {
  AppException(this.message, {String logType = 'e'}) {
    if (!['e', 'd'].contains(logType)) {
      throw ValueException('Invalid log type "$logType"');
    }
    Logger(
      printer: PrettyPrinter(printTime: true),
    ).d(message);
  }
  String message = '';

  @override
  String toString() {
    return message;
  }
}

class ServerException extends AppException {
  ServerException([super.message = 'Server exception.']);
}


class ValueException extends AppException {
  ValueException([super.message = 'Invalid value.']);
}