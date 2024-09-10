import 'package:flutter/material.dart';
import 'package:festa_major_la_llagosta/pages/avisos_page.dart';
import 'package:festa_major_la_llagosta/pages/prefiesta_page.dart';
import 'package:festa_major_la_llagosta/language_manager.dart';

class DrawerComponent extends StatelessWidget {
  final void Function(String, BuildContext) onItemSelected;

  const DrawerComponent({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final headerHeight = screenHeight * 0.1;
    final textSize = screenWidth * 0.05;

    final drawerItems = [
      LanguageManager.currentConstants['avisoTitle']!,
      LanguageManager.currentConstants['prefiestaTitle']!,
      LanguageManager.currentConstants['day1']!,
      LanguageManager.currentConstants['day2']!,
      LanguageManager.currentConstants['day3']!,
      LanguageManager.currentConstants['day4']!,
      LanguageManager.currentConstants['deportesTitle']!,
      LanguageManager.currentConstants['puntosLilaTitle']!,
      LanguageManager.currentConstants['saludaTitle']!,
      LanguageManager.currentConstants['categoriasTitle']!,
      LanguageManager.currentConstants['mapaTitle']!,
      LanguageManager.currentConstants['favoritosTitle']!,
    ];

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(14, 40, 14, 20),
            height: headerHeight,
            color: Colors.orange,
            child: Center(
              child: Text(
                LanguageManager.currentConstants['appTitle']!,
                style: TextStyle(
                  fontSize: textSize,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          for (int i = 0; i < drawerItems.length; i++)
            _createDrawerItem(context, drawerItems[i], i),
        ],
      ),
    );
  }

  ListTile _createDrawerItem(BuildContext context, String title, int index) {
    return ListTile(
      title: Text(title),
      onTap: () {
        onItemSelected(title, context);

        Widget targetPage;

        switch (title) {
          case "Avisos":
            targetPage = AvisosPage(title: title, index: index);
            break;
          case "Prefiesta":
          case "Prefesta":
            targetPage = PrefiestaPage(title: title, index: index);
            break;
          default:
            targetPage = Scaffold(
              appBar: AppBar(title: const Text('Unknown Page')),
              body: const Center(child: Text('Page not found')),
            );
            break;
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => targetPage,
          ),
        );
      },
    );
  }
}
