import 'package:flutter/material.dart';

class AvisosScreen extends StatelessWidget {
  final String title;
  final dynamic data;

  const AvisosScreen({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Text(data
              .toString()), // Muestra los datos de forma sencilla, puedes personalizar esto
        ),
      ),
    );
  }
}
