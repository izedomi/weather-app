import 'package:intl/intl.dart';

class AppUtils {
  static String dayWithSuffixMonthAndYear(DateTime date) {
    var suffix = "th";
    //var suffix = "";
    var digit = date.day % 10;
    if ((digit > 0 && digit < 4) && (date.day < 11 || date.day > 13)) {
      suffix = ["st", "nd", "rd"][digit - 1];
    }
    return DateFormat("d'$suffix' MMM, y").format(date);
  }
}
