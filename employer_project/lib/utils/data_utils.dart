class DataUtils {
  static String getTimeFormat(int number) {
    return number.toString().padLeft(2, '0');
  }
}