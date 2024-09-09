import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flag/flag.dart';

import '../language_manager.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarComponent({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.orange,
      title: kIsWeb ? Text(title) : Center(child: Text(title)),
      actions: <Widget>[
        IconButton(
          icon: Flag.fromCode(
            FlagsCode.ES_CT,
            height: 30,
            width: 30,
          ),
          onPressed: () {
            _onCatalunyaFlagPressed(context);
          },
        ),
        IconButton(
          icon: Flag.fromCode(
            FlagsCode.ES,
            height: 30,
            width: 30,
          ),
          onPressed: () {
            _onSpainFlagPressed(context);
          },
        ),
      ],
    );
  }

  void _onCatalunyaFlagPressed(BuildContext context) {
    LanguageManager.setLanguage(Language.catalan);
    _showLanguageChangedSnackBar(context);
  }

  void _onSpainFlagPressed(BuildContext context) {
    LanguageManager.setLanguage(Language.spanish);
    _showLanguageChangedSnackBar(context);
  }

  void _showLanguageChangedSnackBar(BuildContext context) {
    final currentLanguage = LanguageManager.currentLanguage;

    String snackBarMessage;
    switch (currentLanguage) {
      case Language.catalan:
        snackBarMessage = 'Idioma canviat correctament';
        break;
      case Language.spanish:
      default:
        snackBarMessage = 'Idioma cambiado correctamente';
        break;
    }

    final snackBar = SnackBar(
      content: Text(snackBarMessage),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
