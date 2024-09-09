import 'constants/catalan_constants.dart';
import 'constants/spanish_constants.dart';

enum Language { catalan, spanish }

class LanguageManager {
  static Language _currentLanguage = Language.spanish;

  static void setLanguage(Language language) {
    _currentLanguage = language;
  }

  static Language get currentLanguage => _currentLanguage;

  static Map<String, String> get currentConstants {
    switch (_currentLanguage) {
      case Language.catalan:
        return CatalanConstants.constants;
      case Language.spanish:
      default:
        return SpanishConstants.constants;
    }
  }
}
