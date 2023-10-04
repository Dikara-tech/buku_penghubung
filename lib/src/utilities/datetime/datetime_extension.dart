// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Utilities to format datetime
///

class GoDate {
  static DateFormat get d => DateFormat('d', Intl.getCurrentLocale());

  static DateFormat get ddMMM => DateFormat('dd MMM', Intl.getCurrentLocale());

  static DateFormat get dMMMMyyyy =>
      DateFormat('d MMMM yyyy', Intl.getCurrentLocale());

  static DateFormat get dd_MM_yyyy =>
      DateFormat('dd-MM-yyyy', Intl.getCurrentLocale());

  static DateFormat get ddMMMyyyy =>
      DateFormat('dd MMM yyyy', Intl.getCurrentLocale());

  static DateFormat get ddMMMMyyyy =>
      DateFormat('dd MMMM yyyy', Intl.getCurrentLocale());

  static DateFormat get HHmm => DateFormat('HH:mm', Intl.getCurrentLocale());

  static DateFormat get HHmmss =>
      DateFormat('HH:mm:ss', Intl.getCurrentLocale());

  static DateFormat get EEEEddMMMyyyy =>
      DateFormat('EEEE, dd MMM yyyy', Intl.getCurrentLocale());

  static DateFormat get EEEEddMMMMyyyy =>
      DateFormat('EEEE, dd MMMM yyyy', Intl.getCurrentLocale());

  static DateFormat get EEEddMMMMyyyy =>
      DateFormat('EEE, dd MMMM yyyy', Intl.getCurrentLocale());

  static DateFormat get MMMMyyyy =>
      DateFormat('MMMM yyyy', Intl.getCurrentLocale());

  static DateFormat get dayString =>
      DateFormat('EEEE', Intl.getCurrentLocale());

  static TimeOfDay toTimeOfDay(String val) => TimeOfDay(
      hour: int.parse(val.split(':')[0]), minute: int.parse(val.split(':')[1]));
}

extension DateTimeFormatUtils on DateTime {
  /// Return a Formatted [String] date in [dd MMM] format.
  String get ddMMM => GoDate.ddMMM.format(this);

  /// Return a Formatted [String] date in [dd MMM yyyy] format.
  String get dMMMyyyy => GoDate.dMMMMyyyy.format(this);

  /// Return a Formatted [String] date in [dd-MM-yyyy] format.
  String get dd_MM_yyyy => GoDate.dd_MM_yyyy.format(this);

  /// Return a Formatted [String] date in [dd MMM yyyy] format.
  String get ddMMMyyyy => GoDate.ddMMMyyyy.format(this);

  /// Return a Formatted [String] date in [dd MMMM yyyy] format.
  String get ddMMMMyyyy => GoDate.ddMMMMyyyy.format(this);

  /// Return a Formatted [String] time in [HH:mm] format.
  String get HHmm => GoDate.HHmm.format(this);

  /// Return a Formatted [String] time in [HH:mm:ss] format.
  String get HHmmss => GoDate.HHmmss.format(this);

  /// Return a Formatted [String] date in [EEEE, dd MMM yyyy] format.
  String get EEEEddMMMyyyy => GoDate.EEEEddMMMyyyy.format(this);

  /// Return a Formatted [String] date in [EEEE, dd MMMM yyyy] format.
  String get EEEEddMMMMyyyy => GoDate.EEEEddMMMMyyyy.format(this);

  /// Return a Formatted [String] date in [EEE, dd MMMM yyyy] format.
  String get EEEddMMMMyyyy => GoDate.EEEddMMMMyyyy.format(this);

  /// Return a Formatted [String] date in [MMMM yyyy] format.
  String get MMMMyyyy => GoDate.MMMMyyyy.format(this);

  /// Return a Formatted [String] date in EEEE format.
  String get dayString => GoDate.dayString.format(this);
}

extension DateTimeUtils on DateTime {
  DateTime getPreviousMonthFirstDate(int interval) {
    final endMonth = month;
    final startYear = endMonth - interval < 0 ? year - 1 : year;
    final startMonth = (endMonth - interval + 12) % 12;

    return DateTime(startYear, startMonth, 1);
  }

  TimeOfDay toTimeOfDay() {
    return TimeOfDay(hour: hour, minute: minute);
  }
}

extension DateCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

extension TimeOfDayFormatUtils on TimeOfDay {
  String get timeFormat {
    final hour = _addLeadingZeroIfNeeded(this.hour);
    final minute = _addLeadingZeroIfNeeded(this.minute);
    return '$hour:$minute';
  }

  String _addLeadingZeroIfNeeded(int value) {
    if (value < 10) return '0$value';
    return value.toString();
  }

  DateTime toDateTime(DateTime date) {
    return DateTime(date.year, date.month, date.day, hour, minute);
  }
}

extension DateTimeX on DateTime {
  /// Utilities to add or subtract time based on time zone.
  DateTime toTimeZone(int? zone) {
    Duration adder;
    Duration subtractor;
    final utcTime = toUtc();

    if (zone == null) {
      return utcTime;
    }

    if (zone <= 0) {
      subtractor = Duration(
        hours: zone.abs(),
        minutes: (zone.abs() % 1) * 60,
      );
      return utcTime.subtract(subtractor);
    } else {
      adder = Duration(
        hours: zone,
        minutes: (zone % 1) * 60,
      );
      return utcTime.add(adder);
    }
  }

  DateTime get toInternalUTC =>
      toTimeZone(-DateTime.now().timeZoneOffset.inHours);

  /// Utilities to calculate the most recent monday.
  DateTime mostRecentMonday() => DateTime(year, month, day - (weekday - 1));

  /// Utilities to calculate the most recent weekday.
  DateTime mostRecentWeekday(int day) =>
      DateTime(year, month, day - (weekday - day) % 7);
}

class TrustedDateTime {
  static int _offsetTime = -99;
  static int _timezone = -99;

  const TrustedDateTime._();

  /// Constructs a [DateTime] instance with current date and time in the
  /// trusted time zone and in sync with NTP.
  ///
  /// ```dart
  /// final now = DateTime.now();
  /// ```
  static DateTime now() {
    if (_timezone != -99 && _offsetTime != -99) {
      return DateTime.now()
          .add(Duration(milliseconds: _offsetTime))
          .toInternalUTC
          .toTimeZone(_timezone);
    } else if (_timezone != -99) {
      return DateTime.now().toInternalUTC.toTimeZone(_timezone);
    } else {
      return DateTime.now();
    }
  }

  static DateTime nowInUtc() {
    if (_offsetTime != -99) {
      return DateTime.now().add(Duration(milliseconds: _offsetTime)).toUtc();
    } else {
      return DateTime.now().toUtc();
    }
  }

  /// The time zone offset, which
  /// is the difference between local time and UTC.
  ///
  /// The offset is positive for time zones east of UTC.
  ///
  /// Note, that JavaScript, Python and C return the difference between UTC and
  /// local time. Java, C# and Ruby return the difference between local time and
  /// UTC.
  ///
  /// For example, using local time in San Francisco, United States:
  /// ```dart
  /// final dateUS = DateTime.parse('2021-11-01 20:18:04Z').toLocal();
  /// print(dateUS); // 2021-11-01 13:18:04.000
  /// print(dateUS.timeZoneName); // PDT ( Pacific Daylight Time )
  /// print(dateUS.timeZoneOffset.inHours); // -7
  /// print(dateUS.timeZoneOffset.inMinutes); // -420
  /// ```
  ///
  /// For example, using local time in Canberra, Australia:
  /// ```dart
  /// final dateAus = DateTime.parse('2021-11-01 20:18:04Z').toLocal();
  /// print(dateAus); // 2021-11-02 07:18:04.000
  /// print(dateAus.timeZoneName); // AEDT ( Australian Eastern Daylight Time )
  /// print(dateAus.timeZoneOffset.inHours); // 11
  /// print(dateAus.timeZoneOffset.inMinutes); // 660
  /// ```
  static Duration get timeZoneOffset {
    if (_timezone != -99) {
      return Duration(hours: _timezone);
    } else {
      return DateTime.now().timeZoneOffset;
    }
  }

  /// The time zone name.
  ///
  /// This value is hardcoded for indonesia or return the offset from GMT.
  static String get localTimeZoneName {
    final int timezone;
    if (_timezone == -99) {
      timezone = DateTime.now().timeZoneOffset.inHours;
    } else {
      timezone = _timezone;
    }

    if (timezone == 7) {
      return 'WIB';
    } else if (timezone == 8) {
      return 'WITA';
    } else if (timezone == 9) {
      return 'WIT';
    } else {
      return 'GMT$timezone';
    }
  }
}

/// Utilities to get time zone name of a given int.
String? getTimeZoneName(int? timezone) {
  if (timezone == 7) {
    return 'WIB';
  } else if (timezone == 8) {
    return 'WITA';
  } else if (timezone == 9) {
    return 'WIT';
  } else if (timezone != null) {
    return 'GMT+$timezone';
  } else {
    return null;
  }
}

/// The time zone name.
///
/// This value is hardcoded for indonesia or return the offset from GMT.
extension TimeZoneX on DateTime {
  String? localTimeZoneName() {
    final timezone = timeZoneOffset.inHours;

    if (timezone == 7) {
      return 'WIB';
    } else if (timezone == 8) {
      return 'WITA';
    } else if (timezone == 9) {
      return 'WIT';
    } else {
      return 'GMT$timezone';
    }
  }
}
