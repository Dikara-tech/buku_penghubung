import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateFormat {
  String customStringDateFormat(String date) {
    return DateFormat('dd MMMM yyyy', 'id_ID')
        .format(DateTime.parse(date).toLocal());
  }

  String customDateFormatID(DateTime date) {
    final outputFormat = DateFormat('dd MMMM yyyy', 'id_ID');
    return outputFormat.format(date);
  }

  String customDateFormatSend(DateTime date) {
    final outputFormat = DateFormat('yyyy-MM-dd');
    return outputFormat.format(date);
  }

  String customStringDateFormatSend(String date) {
    final parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    final inputDate = DateTime.parse(parseDate.toString());
    final outputFormat = DateFormat(
      'yyyy-MM-dd',
    );
    return outputFormat.format(inputDate);
  }

  String customStringDateFormatID(String date) {
    final parseDate = DateFormat('yyyy-MM-dd').parse(date);
    final inputDate = DateTime.parse(parseDate.toString());
    final outputFormat = DateFormat('dd MMMM yyyy', 'id_ID');
    return outputFormat.format(inputDate);
  }

  DateTime stringToDate(String date) {
    return DateFormat('dd MMMM yyyy', 'id_ID').parse(date);
  }

  /// Example (01 Juni 2023, 22:56) Indonesian Localized default
  static String ddMMMyyyyHHmm(String date, [String locale = 'id']) {
    final outputFormat = DateFormat('dd MMMM yyyy, HH:mm', locale);
    return outputFormat.format(DateTime.parse(date));
  }

  TimeOfDay convertToTimeOfDay(String s) => TimeOfDay(
        hour: int.parse(s.split(':')[0]),
        minute: int.parse(s.split(':')[1]),
      );
}
