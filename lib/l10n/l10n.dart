import 'dart:ui';

class L10n {

  static final all = [
    const Locale('es'),
    const Locale('en'),
  ];

  static String getFlag(String code) {
    switch(code) {
      case 'es':
        return '🇪🇸';
      case 'en':
        return '🇺🇸';
      default:
        return '🇪🇸';
    }
  }
}

/*

En los archivos .arb

- con {algo} se envían parámetros
- con @delante se explica de que va ese texto, no lleva traducción

{
    "greeting": "Hola",
    "language": "Español",
    "@language": {
        "description": "El actual lenguaje"
    },
    "hello": "Hola {username}"
}
*/