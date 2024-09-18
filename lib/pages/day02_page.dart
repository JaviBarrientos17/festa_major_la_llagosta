import 'package:festa_major_la_llagosta/components/app_bar_component.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Day02Page extends StatefulWidget {
  final String title;
  final int index;

  const Day02Page({super.key, required this.title, required this.index});

  @override
  _Day02PageState createState() => _Day02PageState();
}

class _Day02PageState extends State<Day02Page> {
  String currentLanguage = 'es';
  String baseUrl =
      'https://admin.lallagosta.lafesta.cat/api/v1/ca/actividades/dia/2';

  Future<List<dynamic>> fetchActivities() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar los datos de la API');
    }
  }

  // TODO - REVISAR PORQUE HAY DATOS QUE SI SE TRADUCEN Y OTROS NO
  void _onLanguageChanged(String languageCode) {
    setState(() {
      currentLanguage = languageCode;
      baseUrl = languageCode == 'ca'
          ? 'https://admin.lallagosta.lafesta.cat/api/v1/ca/actividades/dia/previos'
          : 'https://admin.lallagosta.lafesta.cat/api/v1/es/actividades/dia/previos';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        title: widget.title,
        onLanguageChanged: _onLanguageChanged,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchActivities(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final actividades = snapshot.data ?? [];

            if (actividades.isEmpty) {
              return const Center(
                  child: Text('No hay actividades disponibles.'));
            }

            return ListView.builder(
              itemCount: actividades.length,
              itemBuilder: (context, index) {
                final actividad = actividades[index];
                final general = actividad['general'];
                final idioma = actividad['idioma'];
                final categoria = actividad['categoria'];

                final nombreActividad = idioma['nombre'];
                final descripcion = idioma['descripcion'];
                final hora = general['hora'];
                final ubicacion = general['ubicacion']['nombre'];
                final fecha = general['dia']['fecha'];
                final imagenUrl =
                    'https://admin.lallagosta.lafesta.cat/${general['miniatura']}';

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10)),
                          child: Image.network(
                            imagenUrl,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 200,
                                color: Colors.grey[300],
                                child: const Icon(Icons.image,
                                    size: 50, color: Colors.grey),
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
                                nombreActividad,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(Icons.access_time,
                                      size: 16, color: Colors.black),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Jueves $fecha a las $hora',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      size: 16, color: Colors.black),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      ubicacion,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(Icons.category,
                                      size: 16, color: Colors.black),
                                  const SizedBox(width: 5),
                                  Text(
                                    categoria['idioma']['nombre'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No se encontraron datos'));
          }
        },
      ),
    );
  }
}
