class VilleModel {
  final String nom;
  final double latitude;
  final double longitude;

  const VilleModel({
    required this.nom,
    required this.latitude,
    required this.longitude,
  });
}

// Les 5 villes
final List<VilleModel> villes = [
  VilleModel(nom: 'Dakar',    latitude: 14.6937, longitude: -17.4441),
  VilleModel(nom: 'Paris',    latitude: 48.8566, longitude: 2.3522),
  VilleModel(nom: 'New York', latitude: 40.7128, longitude: -74.0060),
  VilleModel(nom: 'Tokyo',    latitude: 35.6762, longitude: 139.6503),
  VilleModel(nom: 'Londres',  latitude: 51.5074, longitude: -0.1278),
];