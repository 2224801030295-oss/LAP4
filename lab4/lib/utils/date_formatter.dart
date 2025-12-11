import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(DateTime dateTime) {
    return DateFormat('EEE, MMM d – HH:mm').format(dateTime);
  }
}
