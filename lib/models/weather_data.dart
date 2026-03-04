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