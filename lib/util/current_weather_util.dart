import 'package:intl/intl.dart';

class Util {
  // Need to set this key from OpenWeatherMap.
  // static String appId = "XXXXXXXXXXXXXXXXXXX";

  static String getFormattedDate(DateTime dateTime) {
    return DateFormat("EEE, MMM d, y").format(dateTime);
  }
}
