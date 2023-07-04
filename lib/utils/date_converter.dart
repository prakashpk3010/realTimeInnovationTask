import 'package:intl/intl.dart';

String dateFormattertoStr(DateTime currentDate) {
  return DateFormat('dd MMM yy').format(currentDate);
}
