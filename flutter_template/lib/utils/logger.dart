import 'package:logger/logger.dart';

class AppLogger {
  static final logger = Logger();
  // Sample of abstract logging function
  static void write(String text, {bool isError = false}) {
    Future.microtask(() => logger.d('** $text. isError: [$isError]'));
  }
}
