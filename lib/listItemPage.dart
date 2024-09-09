import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'components/appBarComponent.dart';
import 'components/drawerComponent.dart';

class ListItemPage extends StatelessWidget {
  final String title;

  const ListItemPage(this.title, {super.key});

  // TODO - PENSAR SI SE PUEDE DEJAR ESTE MÉTODO EN EL MAIN.DART Y ACCEDER A ÉL DESDE AQUÍ
  void _handleDrawerItemSelected(String selectedItem) {
    if (kDebugMode) {
      print('Selected item: $selectedItem');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(title: title),
      drawer: DrawerComponent(onItemSelected: _handleDrawerItemSelected),
      body: Center(
        child: Text(
          "$title Page",
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
