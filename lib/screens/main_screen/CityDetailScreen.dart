import 'package:flutter/material.dart';
import '../models/weather_data.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      body: SafeArea(
        child: Column(
          children: [


            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              child: Row(
                children: [

                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 38, height: 38,
                      decoration: BoxDecoration(
                        color: const Color(0xFF111827),
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(color: const Color(0xFF1E2D45)),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white70,
                        size: 16,
                      ),
                    ),
                  ),
                  // Titre = nom de la ville
                  Expanded(
                    child: Text(
                      weather.city,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
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


                    _buildWeatherCard(),
                    const SizedBox(height: 12),

                    _buildInfoRow(
                      icon: '💨',
                      label: 'Vitesse du vent',
                      value: '${weather.windSpeed.toInt()} km/h',
                    ),
                    const SizedBox(height: 10),
                    _buildInfoRow(
                      icon: '💧',
                      label: 'Humidité',
                      value: '${weather.humidity.toInt()}%',
                    ),
                    const SizedBox(height: 10),
                    _buildInfoRow(
                      icon: '📍',
                      label: 'Coordonnées',
                      value: '${weather.lat.toStringAsFixed(2)}°, '
                          '${weather.lng.toStringAsFixed(2)}°',
                    ),
                    const SizedBox(height: 12),


                    _buildMapCard(),
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



  Widget _buildWeatherCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1565C0),
            Color(0xFF0D47A1),
            Color(0xFF0A2A6E),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          // Icône météo
          Text(
            weather.icon,
            style: const TextStyle(fontSize: 64),
          ),
          const SizedBox(height: 12),

          // Température
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

          // Ligne de séparation
          Container(
            height: 1,
            color: Colors.white12,
          ),
          const SizedBox(height: 18),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStat('${weather.tempMin.toInt()}°', 'Min'),
              _buildDivider(),
              _buildStat('${weather.tempMax.toInt()}°', 'Max'),
              _buildDivider(),
              _buildStat('${weather.humidity.toInt()}%', 'Humidité'),
              _buildDivider(),
              _buildStat('${weather.windSpeed.toInt()}', 'km/h'),
            ],
          ),
        ],
      ),
    );
  }



  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF90CAF9),
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }



  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 36,
      color: Colors.white12,
    );
  }



  Widget _buildInfoRow({
    required String icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1E2D45)),
      ),
      child: Row(
        children: [

          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF4FC3F7).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(icon, style: const TextStyle(fontSize: 18)),
            ),
          ),
          const SizedBox(width: 14),

          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF7A8FAD),
              fontSize: 13,
            ),
          ),
          const Spacer(),

          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildMapCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1E2D45)),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4FC3F7).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text('🗺️', style: TextStyle(fontSize: 18)),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Localisation',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4FC3F7).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF4FC3F7).withOpacity(0.2),
                    ),
                  ),
                  child: const Text(
                    'Google Maps',
                    style: TextStyle(
                      color: Color(0xFF4FC3F7),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),


          Container(height: 1, color: const Color(0xFF1E2D45)),


          Container(
            height: 140,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('📍', style: TextStyle(fontSize: 36)),
                  const SizedBox(height: 6),
                  Text(
                    weather.city,
                    style: const TextStyle(
                      color: Color(0xFF7A8FAD),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${weather.lat.toStringAsFixed(4)}° N, '
                        '${weather.lng.toStringAsFixed(4)}° E',
                    style: const TextStyle(
                      color: Color(0xFF4FC3F7),
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
    );
  }
}