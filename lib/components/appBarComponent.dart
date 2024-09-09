import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flag/flag.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarComponent({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.orange,
      title: kIsWeb ? Text(title) : Center(child: Text(title)),
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
    );
  }

  static void _onCatalunyaFlagPressed() {
    if (kDebugMode) {
      print('Catalunya flag pressed');
    }
  }

  static void _onSpainFlagPressed() {
    if (kDebugMode) {
      print('Spain flag pressed');
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
