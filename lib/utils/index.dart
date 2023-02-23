class Utils {
  static String integerMinToString(int? min) {
    if (min == null) {
      return "-";
    } else {
      return "${(min / 60).floor()} цаг ${min % 60} минут";
    }
  }
}
