import 'dart:convert';

import 'package:flag/flag.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'avisosScreen.dart';

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
  final String apiUrl = 'https://admin.lallagosta.lafesta.cat/api/v1/es/'; // URL base de la API

  Future<void> _fetchDataAndNavigate(BuildContext context, String endpoint) async {
    final String encodedEndpoint = Uri.encodeComponent(endpoint);
    final String url = '$apiUrl$encodedEndpoint'; // Construye la URL completa

    print('Fetching data from URL: $url'); // Imprime la URL para depuración

    try {
      final response = await http.get(Uri.parse(url));

      print('Response status: ${response.statusCode}'); // Imprime el código de estado
      print('Response body: ${response.body}'); // Imprime el cuerpo de la respuesta

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Usa Navigator.push para ir a DataScreen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AvisosScreen(
              title: endpoint,
              data: data,
            ),
          ),
        );
        // Cierra el Drawer después de la navegación
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cargar los datos. Código de estado: ${response.statusCode}. URL: $url'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final headerHeight = screenHeight * 0.1;
    final textSize = screenWidth * 0.05;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: kIsWeb
            ? Text(widget.title)
            : Center(child: Text(widget.title)),
        actions: <Widget>[
          IconButton(
            icon: Flag.fromCode(
              FlagsCode.ES_CT,
              height: 30,
              width: 30,
            ),
            onPressed: () {
              _onCatalunyaFlagPressed();
            },
          ),
          IconButton(
            icon: Flag.fromCode(
              FlagsCode.ES,
              height: 30,
              width: 30,
            ),
            onPressed: () {
              _onSpainFlagPressed();
            },
          ),
        ],
      ),
      drawer: kIsWeb
          ? null
          : Drawer(
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
            /*ListTile(
              title: const Text('Avisos'),
              onTap: () async {
                await _fetchDataAndNavigate(context, 'avisos');
              },
            ),*/
            ListTile(
              title: const Text('Prefiesta'),
              onTap: () async {
                // TODO - REVISAR PORQUE PETA ESTA PETICIÓN
                await _fetchDataAndNavigate(context, 'actividades/dia/previos');
              },
            ),
            ListTile(
              title: const Text('Viernes 06'),
              onTap: () async {
                await _fetchDataAndNavigate(context, 'actividades/dia/2');
              },
            ),
            ListTile(
              title: const Text('Sábado 07'),
              onTap: () async {
                await _fetchDataAndNavigate(context, 'Sabado%2007');
              },
            ),
            ListTile(
              title: const Text('Domingo 08'),
              onTap: () async {
                await _fetchDataAndNavigate(context, 'Domingo%2008');
              },
            ),
            ListTile(
              title: const Text('Lunes 09'),
              onTap: () async {
                await _fetchDataAndNavigate(context, 'Lunes%2009');
              },
            ),
            ListTile(
              title: const Text('Deportes'),
              onTap: () async {
                await _fetchDataAndNavigate(context, 'Deportes');
              },
            ),
            ListTile(
              title: const Text('Puntos lila'),
              onTap: () async {
                await _fetchDataAndNavigate(context, 'Puntos lila');
              },
            ),
            ListTile(
              title: const Text('Saluda'),
              onTap: () async {
                await _fetchDataAndNavigate(context, 'Saluda');
              },
            ),
            ListTile(
              title: const Text('Categorías'),
              onTap: () async {
                await _fetchDataAndNavigate(context, 'Categorias');
              },
            ),
            ListTile(
              title: const Text('Mapa'),
              onTap: () async {
                await _fetchDataAndNavigate(context, 'Mapa');
              },
            ),
            ListTile(
              title: const Text('Favoritos'),
              onTap: () async {
                await _fetchDataAndNavigate(context, 'Favoritos');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: kIsWeb
            ? Image.network('https://lallagosta.lafesta.cat/img/portada.jpg')
            : Image.network('https://lallagosta.lafesta.cat/img/cartel.jpg'),
      ),
    );
  }

  void _onCatalunyaFlagPressed() {
    print('Catalunya flag pressed');
  }

  void _onSpainFlagPressed() {
    print('Spain flag pressed');
  }
}
