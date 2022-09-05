import 'package:intl/intl.dart';

class MainUtils {
  static String dbDateChanger(DateTime dbDate) {
    String date = DateFormat("dd-MM-yyyy hh:mm:ss").format(dbDate);
    String dateWithT = date.substring(0, 10);
    return dateWithT;
  }

  static String convertToTitleCase(String text) {
    if (text.length <= 1) {
      return text.toUpperCase();
    }

    final List<String> words = text.split(' ');

    final capitalizedWords = words.map((word) {
      if (word.trim().isNotEmpty) {
        final String firstLetter = word.trim().substring(0, 1).toUpperCase();
        final String remainingLetters = word.trim().substring(1);

        return '$firstLetter$remainingLetters';
      }
      return '';
    });

    return capitalizedWords.join(' ');
  }
}
