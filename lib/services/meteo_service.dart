import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/meteo_model.dart';

part 'meteo_service.g.dart';


const String _baseUrl = 'https://api.openweathermap.org/data/2.5/';

@RestApi(baseUrl: _baseUrl)
abstract class MeteoService {
  factory MeteoService(Dio dio, {String baseUrl}) = _MeteoService;

  @GET('weather')
  Future<HttpResponse<dynamic>> getMeteoVille(
      @Query('q') String ville,
      @Query('appid') String cleApi,
      @Query('units') String unites,
      @Query('lang') String langue,
      );
}

// Fonction utilitaire pour convertir la réponse en MeteoModel
MeteoModel convertirReponse(Map<String, dynamic> json, String nomVille) {
  return MeteoModel(
    nomVille: nomVille,
    temperature: (json['main']['temp'] as num).toDouble(),
    ressentiThermique: (json['main']['feels_like'] as num).toDouble(),
    humidite: json['main']['humidity'] as int,
    vitesseVent: (json['wind']['speed'] as num).toDouble(),
    description: json['weather'][0]['description'] as String,
    icone: json['weather'][0]['icon'] as String,
    latitude: (json['coord']['lat'] as num).toDouble(),
    longitude: (json['coord']['lon'] as num).toDouble(),
  );
}