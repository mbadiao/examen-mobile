import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WeatherData {
  final String city;
  final double temperature;
  final double tempMin;
  final double tempMax;
  final String condition;
  final String icon;
  final double humidity;
  final double windSpeed;
  final double lat;
  final double lng;

  const WeatherData({
    required this.city,
    required this.temperature,
    required this.tempMin,
    required this.tempMax,
    required this.condition,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
    required this.lat,
    required this.lng,
  });
}

class CityDetailScreen extends StatelessWidget {
  final WeatherData weather;

  const CityDetailScreen({super.key, required this.weather});

  Future<void> _ouvrirGoogleMaps() async {
    final url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${weather.lat},${weather.lng}',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF111827) : const Color(0xFFF0F0F0);
    final borderColor = isDark ? const Color(0xFF1E2D45) : const Color(0xFFD0D0D0);
    final subtextColor = isDark ? const Color(0xFF7A8FAD) : const Color(0xFF666666);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header avec bouton retour
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
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
                      weather.city,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 38),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // Carte meteo principale
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 28, 20, 22),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            colorScheme.primary,
                            colorScheme.primary.withAlpha(200),
                            colorScheme.secondary,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: [
                          Text(weather.icon,
                              style: const TextStyle(fontSize: 64)),
                          const SizedBox(height: 12),
                          Text(
                            '${weather.temperature.toInt()}°C',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              height: 1,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            weather.condition,
                            style: const TextStyle(
                              color: Color(0xFFB3E5FC),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 22),
                          Container(height: 1, color: Colors.white12),
                          const SizedBox(height: 18),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildStat('${weather.tempMin.toInt()}°', 'Min'),
                              Container(width: 1, height: 36, color: Colors.white12),
                              _buildStat('${weather.tempMax.toInt()}°', 'Max'),
                              Container(width: 1, height: 36, color: Colors.white12),
                              _buildStat('${weather.humidity.toInt()}%', 'Humidité'),
                              Container(width: 1, height: 36, color: Colors.white12),
                              _buildStat('${weather.windSpeed.toInt()}', 'km/h'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Infos vent, humidite, coordonnees
                    _buildInfoRow(cardColor, borderColor, subtextColor,
                        icon: '\uD83D\uDCA8',
                        label: 'Vitesse du vent',
                        value: '${weather.windSpeed.toInt()} km/h'),
                    const SizedBox(height: 10),
                    _buildInfoRow(cardColor, borderColor, subtextColor,
                        icon: '\uD83D\uDCA7',
                        label: 'Humidité',
                        value: '${weather.humidity.toInt()}%'),
                    const SizedBox(height: 10),
                    _buildInfoRow(cardColor, borderColor, subtextColor,
                        icon: '\uD83D\uDCCD',
                        label: 'Coordonnées',
                        value: '${weather.lat.toStringAsFixed(2)}°, '
                            '${weather.lng.toStringAsFixed(2)}°'),
                    const SizedBox(height: 12),

                    // Carte Google Maps cliquable
                    GestureDetector(
                      onTap: _ouvrirGoogleMaps,
                      child: Container(
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: borderColor),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: colorScheme.primary.withAlpha(25),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                      child: Text('\uD83D\uDDFA\uFE0F',
                                          style: TextStyle(fontSize: 18)),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Localisation',
                                    style: TextStyle(
                                      color: colorScheme.onSurface,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: colorScheme.primary.withAlpha(25),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: colorScheme.primary.withAlpha(50)),
                                    ),
                                    child: Text(
                                      'Ouvrir Maps',
                                      style: TextStyle(
                                        color: colorScheme.primary,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(height: 1, color: borderColor),
                            Container(
                              height: 140,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('\uD83D\uDCCD',
                                        style: TextStyle(fontSize: 36)),
                                    const SizedBox(height: 6),
                                    Text(weather.city,
                                        style: TextStyle(
                                            color: subtextColor, fontSize: 13)),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${weather.lat.toStringAsFixed(4)}° N, '
                                      '${weather.lng.toStringAsFixed(4)}° E',
                                      style: TextStyle(
                                        color: colorScheme.primary,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        Text(label,
            style: const TextStyle(
                color: Color(0xFF90CAF9),
                fontSize: 11,
                fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildInfoRow(
    Color cardColor,
    Color borderColor,
    Color subtextColor, {
    required String icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF4FC3F7).withAlpha(25),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(child: Text(icon, style: const TextStyle(fontSize: 18))),
          ),
          const SizedBox(width: 14),
          Text(label, style: TextStyle(color: subtextColor, fontSize: 13)),
          const Spacer(),
          Text(value,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
