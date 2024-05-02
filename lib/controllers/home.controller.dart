import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class HomeController with ChangeNotifier {
  void addGroup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Escoge una opción'),
        content: Column(
          children: [
            TextButton.icon(
              icon: const Icon(LineAwesomeIcons.joint),
              onPressed: () {},
              label: const Text('Unirme a un grupo'),
            ),
            TextButton.icon(
              icon: const Icon(LineAwesomeIcons.user_plus),
              onPressed: () {},
              label: const Text('Crear un grupo'),
            )
          ],
        ),
      ),
    );
  }
}
