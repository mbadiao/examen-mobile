import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import 'CityDetailScreen.dart';

class ResultsScreen extends StatelessWidget {
  final List<WeatherData> cities;
  final VoidCallback onRestart;

  const ResultsScreen({
    super.key,
    required this.cities,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF111827) : const Color(0xFFF0F0F0);
    final borderColor = isDark ? const Color(0xFF1E2D45) : const Color(0xFFD0D0D0);
    final subtextColor = isDark ? const Color(0xFF7A8FAD) : const Color(0xFF666666);

    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              // Bouton retour vers accueil
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(color: borderColor),
                  ),
                  child: Icon(Icons.arrow_back_ios_new,
                      color: colorScheme.onSurface, size: 16),
                ),
              ),
              Expanded(
                child: Text(
                  'Météo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              // Toggle theme
              GestureDetector(
                onTap: () => context.read<ThemeProvider>().toggleTheme(),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(color: borderColor),
                  ),
                  child: Icon(
                    isDark ? Icons.light_mode : Icons.dark_mode,
                    color: colorScheme.onSurface,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Sous-header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          child: Row(
            children: [
              Text(
                'Résultats Météo',
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withAlpha(25),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: colorScheme.primary.withAlpha(50)),
                ),
                child: Text(
                  '${cities.length} villes',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // Liste des villes
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            itemCount: cities.length,
            separatorBuilder: (_, __) => const SizedBox(height: 9),
            itemBuilder: (context, index) {
              final weather = cities[index];
              return _CityCard(
                weather: weather,
                cardColor: cardColor,
                borderColor: borderColor,
                subtextColor: subtextColor,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CityDetailScreen(weather: weather),
                  ),
                ),
              );
            },
          ),
        ),

        // Bouton Recommencer
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 28),
          child: GestureDetector(
            onTap: onRestart,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [colorScheme.primary, colorScheme.secondary],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.primary.withAlpha(50),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.refresh_rounded, color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Recommencer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CityCard extends StatelessWidget {
  final WeatherData weather;
  final Color cardColor;
  final Color borderColor;
  final Color subtextColor;
  final VoidCallback onTap;

  const _CityCard({
    required this.weather,
    required this.cardColor,
    required this.borderColor,
    required this.subtextColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(weather.icon, style: const TextStyle(fontSize: 24)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    weather.city,
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    weather.condition,
                    style: TextStyle(color: subtextColor, fontSize: 11),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${weather.temperature.toInt()}°',
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${weather.tempMin.toInt()}° / ${weather.tempMax.toInt()}°',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Icon(Icons.chevron_right_rounded,
                color: colorScheme.primary, size: 20),
          ],
        ),
      ),
    );
  }
}
