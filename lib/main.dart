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
  final String apiUrl = 'https://admin.lallagosta.lafesta.cat/api/v1/es/';

  void _handleDrawerItemSelected(String selectedItem, BuildContext context) {
    if (kDebugMode) {
      print('Selected item: $selectedItem');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(title: widget.title),
      drawer: kIsWeb
          ? null
          : DrawerComponent(onItemSelected: _handleDrawerItemSelected),
      body: Center(
        child: kIsWeb
            ? Image.network('https://lallagosta.lafesta.cat/img/portada.jpg')
            // TODO - HACER QUE LA IMG EN FORMATO MÓVIL OCUPE TODO EL ANCHO DE LA PANTALLA SIN DEJAR MARGENES POR LOS LADOS
            : Image.network('https://lallagosta.lafesta.cat/img/cartel.jpg'),
      ),
    );
  }
}
