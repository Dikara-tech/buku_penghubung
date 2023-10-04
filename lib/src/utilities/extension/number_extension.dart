import 'package:intl/intl.dart';

class GoNumber {
  static NumberFormat get currency =>
      NumberFormat.currency(
        locale: 'id_ID',
        symbol: 'Rp',
        decimalDigits: 0,
      );

  static NumberFormat get decimal => NumberFormat.decimalPattern();

  static NumberFormat get humanReadable => NumberFormat.compact();
}
