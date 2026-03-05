import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Toggle theme en haut a droite
            Positioned(
              top: 16,
              right: 16,
              child: GestureDetector(
                onTap: () => context.read<ThemeProvider>().toggleTheme(),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colorScheme.primary.withAlpha(60)),
                  ),
                  child: Icon(
                    isDark ? Icons.light_mode : Icons.dark_mode,
                    color: colorScheme.primary,
                    size: 22,
                  ),
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTopLabel(colorScheme),
                    const SizedBox(height: 40),
                    _buildWeatherIconCard(colorScheme),
                    const SizedBox(height: 32),
                    _buildTitle(colorScheme),
                    const SizedBox(height: 16),
                    _buildSubtitle(colorScheme),
                    const SizedBox(height: 40),
                    _buildStartButton(context, colorScheme),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopLabel(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.primary.withAlpha(80)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.cloud_outlined, color: colorScheme.primary, size: 18),
          const SizedBox(width: 8),
          Text(
            'MÉTÉO PROGRESS',
            style: TextStyle(
              color: colorScheme.primary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherIconCard(ColorScheme colorScheme) {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: colorScheme.primary.withAlpha(60)),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withAlpha(25),
            blurRadius: 24,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Icon(
        Icons.wb_cloudy_outlined,
        size: 64,
        color: colorScheme.primary,
      ),
    );
  }

  Widget _buildTitle(ColorScheme colorScheme) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, height: 1.3),
        children: [
          TextSpan(
            text: 'Bienvenue dans\n',
            style: TextStyle(color: colorScheme.onSurface),
          ),
          TextSpan(
            text: "l'expérience Météo",
            style: TextStyle(color: colorScheme.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildSubtitle(ColorScheme colorScheme) {
    return Text(
      'Des prévisions précises conçues\npour les professionnels. Élégant,\nfiable et sombre par nature.',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: colorScheme.onSurface.withAlpha(150),
        fontSize: 14,
        height: 1.6,
      ),
    );
  }

  Widget _buildStartButton(BuildContext context, ColorScheme colorScheme) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/main');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        child: const Text(
          "Démarrer l'expérience  →",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

}
