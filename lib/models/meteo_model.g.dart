// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meteo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeteoModel _$MeteoModelFromJson(Map<String, dynamic> json) => MeteoModel(
  nomVille: json['nomVille'] as String,
  temperature: (json['temperature'] as num).toDouble(),
  ressentiThermique: (json['ressentiThermique'] as num).toDouble(),
  humidite: (json['humidite'] as num).toInt(),
  vitesseVent: (json['vitesseVent'] as num).toDouble(),
  description: json['description'] as String,
  icone: json['icone'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
);

Map<String, dynamic> _$MeteoModelToJson(MeteoModel instance) =>
    <String, dynamic>{
      'nomVille': instance.nomVille,
      'temperature': instance.temperature,
      'ressentiThermique': instance.ressentiThermique,
      'humidite': instance.humidite,
      'vitesseVent': instance.vitesseVent,
      'description': instance.description,
      'icone': instance.icone,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
