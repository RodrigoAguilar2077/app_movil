import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      padding: const EdgeInsets.all(16),
      children: [
        _menuButton(
            context, 'Dispensar', Icons.pets, Colors.blue, '/dispensar'),
        _menuButton(context, 'Configuración', Icons.settings, Colors.green,
            '/settings'),
        _menuButton(
            context, 'Historial', Icons.history, Colors.orange, '/historial'),
        _menuButton(context, 'Estado', Icons.info, Colors.red, '/estado'),
        _menuButton(context, 'Ayuda', Icons.help, Colors.purple, '/ayuda'),
        _menuButton(
            context, 'Salir', Icons.exit_to_app, Colors.black, '/logout'),
      ],
    );
  }

  Widget _menuButton(BuildContext context, String text, IconData icon,
      Color color, String route) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color, padding: const EdgeInsets.all(20)),
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 40, color: Colors.white),
          const SizedBox(height: 10),
          Text(text, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
