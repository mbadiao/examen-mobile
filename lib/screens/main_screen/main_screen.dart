import 'package:flutter/material.dart';

/// Placeholder — P3 remplacera cet écran avec la jauge et le tableau
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Météo Progress'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction, size: 64, color: colorScheme.primary),
            const SizedBox(height: 16),
            Text(
              'Écran principal',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'En cours de développement...',
              style: TextStyle(color: colorScheme.onSurface.withAlpha(150)),
            ),
          ],
        ),
      ),
    );
  }
}
