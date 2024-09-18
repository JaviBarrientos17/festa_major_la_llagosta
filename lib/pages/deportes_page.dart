import 'package:festa_major_la_llagosta/components/app_bar_component.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DeportesPage extends StatefulWidget {
  final String title;
  final int index;

  const DeportesPage({super.key, required this.title, required this.index});

  @override
  _DeportesPageState createState() => _DeportesPageState();
}

class _DeportesPageState extends State<DeportesPage> {
  String currentLanguage = 'es';
  String baseUrl = 'https://admin.lallagosta.lafesta.cat/api/v1/es/paginas/1';
  Map<String, dynamic>? general;
  Map<String, dynamic>? idioma;

  Future<void> fetchActivities() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        general = data['general'];
        idioma = data['idioma'];
      });
    } else {
      throw Exception('Error al cargar los datos de la API');
    }
  }

  void _onLanguageChanged(String languageCode) {
    setState(() {
      currentLanguage = languageCode;
      baseUrl = languageCode == 'ca'
          ? 'https://admin.lallagosta.lafesta.cat/api/v1/ca/paginas/1'
          : 'https://admin.lallagosta.lafesta.cat/api/v1/es/paginas/1';
      fetchActivities();
    });
  }

  List<Widget> _buildEventCards(String htmlDescription) {
    final plainText = htmlDescription.replaceAll(RegExp(r'<[^>]*>'), '\n');

    final sections = plainText
        .split('\n\n')
        .where((section) => section.trim().isNotEmpty)
        .toList();

    return sections.map((section) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              section.trim(),
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    fetchActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        title: idioma?['titulo'] ?? 'Sin título',
        onLanguageChanged: _onLanguageChanged,
      ),
      body: FutureBuilder<void>(
        future: fetchActivities(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData || (general != null && idioma != null)) {
            final descripcion = idioma?['descripcion'] ?? 'Sin descripción';

            return SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (general?['imagen'] != null)
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(10)),
                      child: Image.network(
                        'https://admin.lallagosta.lafesta.cat/${general!['imagen']}',
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 200,
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.image,
                              size: 50,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          idioma?['titulo'] ?? 'Sin título',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          idioma?['subtitulo'] ?? 'Sin subtítulo',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        // Usar _buildEventCards para crear una lista de tarjetas
                        ..._buildEventCards(descripcion),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No se encontraron datos'));
          }
        },
      ),
    );
  }
}
