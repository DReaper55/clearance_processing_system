import 'package:intl/intl.dart';

class Dateformatter {
  static String formatyMMMd(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }

  static String formatEEyMMMd(DateTime date) {
    return DateFormat.yMMMEd().format(date);
  }

  static String formatYYYYMMMDD(DateTime date) {
    return DateFormat('y-MM-dd').format(date);
  }
}
