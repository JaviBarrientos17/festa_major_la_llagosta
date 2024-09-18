import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'components/app_bar_component.dart';
import 'components/drawer_component.dart';
import 'language_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: MyHomePage(
        title: LanguageManager.currentConstants['appTitle']!,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String title;

  @override
  void initState() {
    super.initState();
    title = widget.title;
  }

  final String apiUrl = 'https://admin.lallagosta.lafesta.cat/api/v1/es/';

  void _handleDrawerItemSelected(String selectedItem, BuildContext context) {
    setState(() {
      switch (selectedItem) {
        case 'Catalan':
          LanguageManager.changeLanguage('ca');
          break;
        case 'Spanish':
          LanguageManager.changeLanguage('es');
          break;
      }

      title = LanguageManager.currentConstants['appTitle']!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        title: title,
        onLanguageChanged: (languageCode) {
          setState(() {
            LanguageManager.changeLanguage(languageCode);
            title = LanguageManager.currentConstants['appTitle']!;
          });
        },
      ),
      drawer: kIsWeb
          ? null
          : DrawerComponent(onItemSelected: _handleDrawerItemSelected),
      body: Center(
        child: kIsWeb
            ? Image.network(
                'https://lallagosta.lafesta.cat/img/portada.jpg',
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) {
                    return child;
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              )
            : Image.network(
                'https://lallagosta.lafesta.cat/img/cartel.jpg',
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) {
                    return child;
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
      ),
    );
  }
}
