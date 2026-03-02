import 'package:json_annotation/json_annotation.dart';

part 'meteo_model.g.dart';

@JsonSerializable()
class   MeteoModel {
  final String nomVille;
  final double temperature;
  final double ressentiThermique;
  final int humidite;
  final double vitesseVent;
  final String description;
  final String icone;
  final double latitude;
  final double longitude;

  MeteoModel({
    required this.nomVille,
    required this.temperature,
    required this.ressentiThermique,
    required this.humidite,
    required this.vitesseVent,
    required this.description,
    required this.icone,
    required this.latitude,
    required this.longitude,
  });

  factory MeteoModel.fromJson(Map<String, dynamic> json) =>
      _$MeteoModelFromJson(json);

  Map<String, dynamic> toJson() => _$MeteoModelToJson(this);
}