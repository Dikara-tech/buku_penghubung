import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';

/// Debug log tree. Tag generation included.
class DevTree extends LogTree {
  /// Default levels for logging a debug.
  static const List<String> defaultLevels = ['D', 'I', 'W', 'E'];

  /// Elapsed time type tracking for logging.
  static const int timeElapsedType = 0;

  /// Actual clock time type tracking for logging.
  static const int timeClockType = 1;
  static final Map<String, ColorizeStyle> _defaultColorizeMap = {
    'V': ColorizeStyle([AnsiStyle.foreground(AnsiColor.blue)]),
    'D': ColorizeStyle([AnsiStyle.foreground(AnsiColor.green)]),
    'W': ColorizeStyle([
      AnsiStyle.foreground(AnsiColor.yellow),
      AnsiStyle.background(AnsiColor.black),
    ]),
    'E': ColorizeStyle([
      AnsiStyle.bright(AnsiColor.white),
      AnsiStyle.background(AnsiColor.red),
    ]),
  };

  /// Log levels processed by this [DevTree].
  List<String> logLevels;

  /// Type of time to print.
  final int printTimeType;
  final Stopwatch _elapsedTimeStopwatch = Stopwatch();

  /// Colors style map, with key as log level and value as [ColorizeStyle]
  /// Visible on supported consoles.
  Map<String, ColorizeStyle> colorizeMap = {};

  /// Creates DebugTree with defaults
  /// or with defined [printTimeType], [logLevels], [useColors].
  DevTree({
    this.printTimeType = timeClockType,
    this.logLevels = defaultLevels,
    bool useColors = false,
  }) {
    if (printTimeType == timeElapsedType) {
      _elapsedTimeStopwatch
        ..reset()
        ..start();
    }
    if (useColors) {
      colorizeMap = _defaultColorizeMap;
    }
  }

  /// Creates elapsed time type Debug log tree
  /// with optional [logLevels] and [useColors].
  factory DevTree.elapsed({
    List<String> logLevels = defaultLevels,
    bool useColors = false,
  }) {
    return DevTree(
      logLevels: logLevels,
      printTimeType: timeElapsedType,
      useColors: useColors,
    );
  }

  /// Logs [message] with [level]
  /// and optional [tag], [ex] (exception, [stacktrace].
  @override
  void log(
    String level,
    String message, {
    String? tag,
    dynamic ex,
    StackTrace? stacktrace,
  }) {
    final logTag = tag ?? LogTree.getTag();
    if (ex != null) {
      final tmpStacktrace =
          stacktrace?.toString().split('\n') ?? LogTree.getStacktrace();
      final stackTraceMessage =
          tmpStacktrace.map((stackLine) => '\t$stackLine').join('\n');
      printLog(
        '$level\t$logTag:\t $message \n'
        '${ex.toString()}\n$stackTraceMessage',
        level: level,
      );
    } else {
      printLog('$level\t$logTag:\t $message', level: level);
    }
  }

  /// Method to overload printing to output stream the formatted [logLine]
  /// Adds handing of time.
  void printLog(String logLine, {String? level}) {
    var printableLine = logLine;
    if (printTimeType == timeElapsedType) {
      final timeElapsed = _elapsedTimeStopwatch.elapsed.toString();
      printableLine = '$timeElapsed\t$logLine';
    } else {
      final date = DateTime.now().toIso8601String();
      printableLine = '$date\t$logLine';
    }
    final colorizeTransform = (level != null) ? colorizeMap[level] : null;
    if (colorizeTransform != null) {
      debugPrint(colorizeTransform.wrap(printableLine), wrapWidth: 1024);
    } else {
      debugPrint(printableLine, wrapWidth: 1024);
    }
  }

  @override
  List<String> getLevels() {
    return logLevels;
  }
}
