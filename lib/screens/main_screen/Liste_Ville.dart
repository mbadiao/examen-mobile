import 'package:flutter/material.dart';
import 'CityDetailScreen.dart';
import '../models/weather_data.dart';






final List<WeatherData> mockWeatherList = [
  WeatherData(
    city: 'Dakar',
    temperature: 22,
    tempMin: 17, tempMax: 25,
    condition: 'Ensoleillé',
    icon: '☀️',
    humidity: 55, windSpeed: 12,
    lat: 48.8566, lng: 2.3522,
  ),
  WeatherData(
    city: 'Thies',
    temperature: 26,
    tempMin: 20, tempMax: 29,
    condition: 'Nuageux',
    icon: '⛅',
    humidity: 48, windSpeed: 8,
    lat: 45.7640, lng: 4.8357,
  ),
  WeatherData(
    city: 'Kolda',
    temperature: 30,
    tempMin: 24, tempMax: 33,
    condition: 'Ensoleillé',
    icon: '☀️',
    humidity: 42, windSpeed: 18,
    lat: 43.2965, lng: 5.3698,
  ),
  WeatherData(
    city: 'Fatick',
    temperature: 24,
    tempMin: 18, tempMax: 27,
    condition: 'Pluie',
    icon: '🌧️',
    humidity: 72, windSpeed: 15,
    lat: 44.8378, lng: -0.5792,
  ),
  WeatherData(
    city: 'Diourbel',
    temperature: 18,
    tempMin: 13, tempMax: 21,
    condition: 'Couvert',
    icon: '☁️',
    humidity: 80, windSpeed: 20,
    lat: 50.6292, lng: 3.0573,
  ),
];


class ResultsScreen extends StatelessWidget {
  final List<WeatherData> cities;
  final VoidCallback onRestart;

  const ResultsScreen({
    super.key,
    required this.cities,
    required this.onRestart,
  });


  void _goToDetail(BuildContext context, WeatherData weather) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CityDetailScreen(weather: weather),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [


        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          child: Row(
            children: [
              Container(
                width: 38, height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFF111827),
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(color: const Color(0xFF1E2D45)),
                ),
                child: const Icon(
                  Icons.menu,
                  color: Colors.white70,
                  size: 20,
                ),
              ),
              const Expanded(
                child: Text(
                  'Météo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                width: 38, height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFF111827),
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(color: const Color(0xFF1E2D45)),
                ),
                child: const Icon(
                  Icons.more_horiz,
                  color: Colors.white70,
                  size: 20,
                ),
              ),
            ],
          ),
        ),


        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 4,
          ),
          child: Row(
            children: [
              const Text(
                'Résultats Météo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF4FC3F7).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF4FC3F7).withOpacity(0.2),
                  ),
                ),
                child: Text(
                  '${cities.length} villes',
                  style: const TextStyle(
                    color: Color(0xFF4FC3F7),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            itemCount: cities.length,
            separatorBuilder: (_, __) => const SizedBox(height: 9),
            itemBuilder: (context, index) {
              final weather = cities[index];
              return _CityCard(
                weather: weather,
                onTap: () => _goToDetail(context, weather),
              );
            },
          ),
        ),


        Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 28),
          child: GestureDetector(
            onTap: onRestart,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1565C0), Color(0xFF4FC3F7)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4FC3F7).withOpacity(0.2),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.refresh_rounded,
                      color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Recommencer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
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
  final VoidCallback onTap;

  const _CityCard({
    required this.weather,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 13,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF111827),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF1E2D45)),
        ),
        child: Row(
          children: [


            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF1A2035),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  weather.icon,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Nom + condition
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    weather.city,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    weather.condition,
                    style: const TextStyle(
                      color: Color(0xFF7A8FAD),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),

            // Température
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${weather.temperature.toInt()}°',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${weather.tempMin.toInt()}° / ${weather.tempMax.toInt()}°',
                  style: const TextStyle(
                    color: Color(0xFF4FC3F7),
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(width: 10),


            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF4FC3F7),
              size: 20,
            ),

          ],
        ),
      ),
    );
  }
}