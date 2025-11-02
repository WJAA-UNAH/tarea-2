// A simple logger utility to replace print statements
class Logger {
  static void debug(String message) {
    // Only log in debug mode
    assert(() {
      _log('DEBUG', message);
      return true;
    }());
  }

  static void info(String message) {
    _log('INFO', message);
  }

  static void warning(String message) {
    _log('WARNING', message);
  }

  static void error(String message, [Object? error]) {
    _log('ERROR', message);
    if (error != null) {
      _log('ERROR', error.toString());
    }
  }

  static void _log(String level, String message) {
    assert(() {
      final now = DateTime.now();
      final timeString = '${now.hour}:${now.minute}:${now.second}';
      // ignore: avoid_print
      print('[$timeString][$level] $message');
      return true;
    }());
  }
}
