import 'package:festa_major_la_llagosta/components/app_bar_component.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AvisosPage extends StatefulWidget {
  final String title;
  final int index;

  const AvisosPage({super.key, required this.title, required this.index});

  @override
  _AvisosPageState createState() => _AvisosPageState();
}

class _AvisosPageState extends State<AvisosPage> {
  String currentLanguage = 'es';
  String baseUrl = 'https://admin.lallagosta.lafesta.cat/api/v1/es/avisos';

  Future<List<dynamic>> fetchAvisos() async {
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
          ? 'https://admin.lallagosta.lafesta.cat/api/v1/ca/avisos'
          : 'https://admin.lallagosta.lafesta.cat/api/v1/es/avisos';
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
        future: fetchAvisos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final avisos = snapshot.data ?? [];

            if (avisos.isEmpty) {
              return const Center(child: Text('No hay avisos disponibles.'));
            }

            return ListView.builder(
              itemCount: avisos.length,
              itemBuilder: (context, index) {
                final aviso = avisos[index];
                final mensaje = aviso['mensaje'];
                final fechaCreado = aviso['creado'];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mensaje,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today,
                                  size: 16, color: Colors.black),
                              const SizedBox(width: 5),
                              Text(
                                'Creado el: $fechaCreado',
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
