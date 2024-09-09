import 'package:flutter/material.dart';

class SingleScreenApp extends StatefulWidget {
  const SingleScreenApp({super.key});

  @override
  State<SingleScreenApp> createState() => _SingleScreenAppState();
}

class _SingleScreenAppState extends State<SingleScreenApp> {
  String _currentScreen = 'Inicio';

  // Método para cambiar la pantalla actual
  void _changeScreen(String screen) {
    setState(() {
      _currentScreen = screen;
    });
    Navigator.pop(context); // Cierra el Drawer al seleccionar una opción
  }

  // Aquí se define el contenido de cada pantalla
  Widget _getScreenContent(String screen) {
    switch (screen) {
      case 'Avisos':
        return Center(child: Text('Contenido de Avisos', style: TextStyle(fontSize: 24)));
      case 'Prefiesta':
        return Center(child: Text('Contenido de Prefiesta', style: TextStyle(fontSize: 24)));
      case 'Viernes 06':
        return Center(child: Text('Contenido de Viernes 06', style: TextStyle(fontSize: 24)));
      case 'Sábado 07':
        return Center(child: Text('Contenido de Sábado 07', style: TextStyle(fontSize: 24)));
      case 'Domingo 08':
        return Center(child: Text('Contenido de Domingo 08', style: TextStyle(fontSize: 24)));
      case 'Lunes 09':
        return Center(child: Text('Contenido de Lunes 09', style: TextStyle(fontSize: 24)));
      case 'Deportes':
        return Center(child: Text('Contenido de Deportes', style: TextStyle(fontSize: 24)));
      case 'Puntos lila':
        return Center(child: Text('Contenido de Puntos lila', style: TextStyle(fontSize: 24)));
      case 'Saluda':
        return Center(child: Text('Contenido de Saluda', style: TextStyle(fontSize: 24)));
      case 'Categorías':
        return Center(child: Text('Contenido de Categorías', style: TextStyle(fontSize: 24)));
      case 'Mapa':
        return Center(child: Text('Contenido de Mapa', style: TextStyle(fontSize: 24)));
      case 'Favoritos':
        return Center(child: Text('Contenido de Favoritos', style: TextStyle(fontSize: 24)));
      default:
        return Center(child: Text('Pantalla de Inicio', style: TextStyle(fontSize: 24)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('#FMlaLlagosta2024'),
        backgroundColor: Colors.orange,
      ),
      drawer: DrawerComponent(onItemSelected: _changeScreen), // Drawer personalizado
      body: _getScreenContent(_currentScreen), // Cuerpo que cambia según la selección
    );
  }
}

class DrawerComponent extends StatelessWidget {
  final Function(String) onItemSelected;

  const DrawerComponent({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final headerHeight = screenHeight * 0.1;
    final textSize = screenWidth * 0.05;

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
                '#FMlaLlagosta2024',
                style: TextStyle(
                  fontSize: textSize,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          _createDrawerItem(context, 'Avisos'),
          _createDrawerItem(context, 'Prefiesta'),
          _createDrawerItem(context, 'Viernes 06'),
          _createDrawerItem(context, 'Sábado 07'),
          _createDrawerItem(context, 'Domingo 08'),
          _createDrawerItem(context, 'Lunes 09'),
          _createDrawerItem(context, 'Deportes'),
          _createDrawerItem(context, 'Puntos lila'),
          _createDrawerItem(context, 'Saluda'),
          _createDrawerItem(context, 'Categorías'),
          _createDrawerItem(context, 'Mapa'),
          _createDrawerItem(context, 'Favoritos'),
        ],
      ),
    );
  }

  ListTile _createDrawerItem(BuildContext context, String title) {
    return ListTile(
      title: Text(title),
      onTap: () {
        onItemSelected(title);
      },
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SingleScreenApp(),
  ));
}
