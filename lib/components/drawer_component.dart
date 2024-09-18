import 'package:flutter/material.dart';

import '../language_manager.dart';
import '../pages/day01_page.dart';
import '../pages/day02_page.dart';
import '../pages/day03_page.dart';
import '../pages/day04_page.dart';
import '../pages/avisos_page.dart';
import '../pages/prefiesta_page.dart';
import '../pages/deportes_page.dart';

class DrawerComponent extends StatelessWidget {
  final void Function(String, BuildContext) onItemSelected;

  const DrawerComponent({super.key, required this.onItemSelected});

  Future<List<String>> _fetchDrawerItems() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return [
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
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final headerHeight = screenHeight * 0.1;
    final textSize = screenWidth * 0.05;

    return Drawer(
      child: FutureBuilder<List<String>>(
        future: _fetchDrawerItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final drawerItems = snapshot.data ?? [];

            return ListView(
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
            );
          } else {
            return const Center(child: Text('No items found'));
          }
        },
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
          case "Viernes 06":
          case "Divendres 06":
            targetPage = Day01Page(title: title, index: index);
            break;
          case "Sábado 07":
          case "Dissabte 07":
            targetPage = Day02Page(title: title, index: index);
            break;
          case "Domingo 08":
          case "Diumenge 08":
            targetPage = Day03Page(title: title, index: index);
            break;
          case "Lunes 09":
          case "Dilluns 09":
            targetPage = Day04Page(title: title, index: index);
            break;
          case "Deportes":
          case "Esports":
            targetPage = DeportesPage(title: title, index: index);
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
