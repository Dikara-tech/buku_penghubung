import 'package:fimber/fimber.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

/// A log tree class that wraps firebase crashlytics.
class CrashlyticsTree extends LogTree {
  // Only log warnings and exceptions.
  static const List<String> defaultLevels = ['W', 'E'];
  final List<String> logLevels;

  @override
  List<String> getLevels() => logLevels;

  CrashlyticsTree({this.logLevels = defaultLevels});

  @override
  void log(
    String level,
    String message, {
    String? tag,
    dynamic ex,
    StackTrace? stacktrace,
  }) {
    final firebaseCrashlytics = FirebaseCrashlytics.instance..log(message);
    if (ex != null) firebaseCrashlytics.recordError(ex, stacktrace);
  }
}
