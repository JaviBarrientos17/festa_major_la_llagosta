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

  static void changeLanguage(String languageCode) {
    // Lógica para cambiar el idioma
    // Actualizar `currentConstants` con las nuevas traducciones
    // Ejemplo:
    if (languageCode == 'ca') {
      currentConstants['appTitle'] = 'El Títol de la Meva App'; // Ejemplo de traducción al catalán
    } else if (languageCode == 'es') {
      currentConstants['appTitle'] = 'El Título de Mi App'; // Ejemplo de traducción al español
    }
    // Actualizar otras constantes si es necesario
  }
}
