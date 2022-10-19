import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(
    colors: true, // Colorful log messages
    printEmojis: true,
  ),
);
