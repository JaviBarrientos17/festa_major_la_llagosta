import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'components/appBarComponent.dart';
import 'components/drawerComponent.dart';

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
      home: const MyHomePage(title: '#FMlaLlagosta2024'),
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

  // TODO - PENSAR SI SE PUEDE DEJAR ESTE MÉTODO AQUÍ Y ACCEDER A ÉL DESDE EL listItemPage.dart
  void _handleDrawerItemSelected(String selectedItem) {
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
