class CityModel {
  final String name;
  final String country;
  final double latitude;
  final double longitude;

  const CityModel({
    required this.name,
    required this.country,
    required this.latitude,
    required this.longitude,
  });
}

const List<CityModel> defaultCities = [
  CityModel(name: 'Paris', country: 'FR', latitude: 48.8566, longitude: 2.3522),
  CityModel(name: 'Dakar', country: 'SN', latitude: 14.6928, longitude: -17.4467),
  CityModel(name: 'Abidjan', country: 'CI', latitude: 5.3600, longitude: -4.0083),
  CityModel(name: 'Londres', country: 'GB', latitude: 51.5074, longitude: -0.1278),
  CityModel(name: 'Libreville', country: 'GA', latitude: 0.4162, longitude: 9.4673),
];
