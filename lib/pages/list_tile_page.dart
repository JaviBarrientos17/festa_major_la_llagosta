import 'package:festa_major_la_llagosta/components/app_bar_component.dart';
import 'package:flutter/material.dart';

class ListTilePage extends StatelessWidget {
  final String title;
  final int index;

  const ListTilePage({super.key, required this.title, required this.index});

  @override
  Widget build(BuildContext context) {
    Widget getContent() {
      switch (title) {
        case "Avisos":
          return const Text(
            "Contenido para Avisos",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          );
        case "Prefiesta" || "Prefesta":
          return const Text(
            "Contenido para Prefiesta",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          );
        case "Viernes 06" || "Divendres 06":
          return const Text(
            "Contenido para Viernes 06",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          );
        case "Sábado 07" || "Dissabte 07":
          return const Text(
            "Contenido para Sábado 07",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          );
        case "Domingo 08" || "Diumenge 08":
          return const Text(
            "Contenido para Domingo 08",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          );
        case "Lunes 09" || "Dilluns 09":
          return const Text(
            "Contenido para Lunes 09",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          );
        case "Deportes" || "Esports":
          return const Text(
            "Contenido para Deportes",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          );
        case "Puntos lila" || "Punts lila":
          return const Text(
            "Contenido para Puntos lila",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          );
        case "Saluda" || "Saluda":
          return const Text(
            "Contenido para Saluda",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          );
        case "Categorías" || "Categories":
          return const Text(
            "Contenido para Categorías",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          );
        case "Mapa" || "Mapa":
          return const Text(
            "Contenido para Mapa",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          );
        case "Favoritos" || "Favorits":
          return const Text(
            "Contenido para Favoritos",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          );
        default:
          return const Text(
            "No content",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          );
      }
    }

    return Scaffold(
      appBar: AppBarComponent(title: title),
      body: Center(
        child: getContent(),
      ),
    );
  }
}
