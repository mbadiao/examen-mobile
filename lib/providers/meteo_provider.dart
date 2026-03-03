import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../models/meteo_model.dart';
import '../models/ville_model.dart';
import '../services/meteo_service.dart';

enum EtatChargement { initial, chargement, succes, erreur }

class MeteoProvider extends ChangeNotifier {
  final MeteoService _service = MeteoService(Dio());
  static const String cleApi = 'cbef47a566e2a9b5115b8db5dfc9c721';
  // État de l'application
  EtatChargement etat = EtatChargement.initial;
  List<MeteoModel> donneesMeteo = [];
  String messageErreur = '';
  double progression = 0.0;
  int indexMessage = 0;

  // Messages rotatifs
  final List<String> messagesAttente = [
    'Nous téléchargeons les données...',
    'C\'est presque fini...',
    'Plus que quelques secondes avant d\'avoir le résultat...',
  ];

  // Lancer le chargement des 5 villes
  Future<void> chargerMeteo() async {
    etat = EtatChargement.chargement;
    donneesMeteo = [];
    progression = 0.0;
    indexMessage = 0;
    notifyListeners();

    try {
      for (int i = 0; i < villes.length; i++) {
        // Mettre à jour le message rotatif
        indexMessage = i % messagesAttente.length;
        notifyListeners();

        // Appel API
        final reponse = await _service.getMeteoVille(
          villes[i].nom,
          cleApi,
          'metric',
          'fr',
        );

        // Convertir et ajouter
        final meteo = convertirReponse(
          reponse.data as Map<String, dynamic>,
          villes[i].nom,
        );
        donneesMeteo.add(meteo);

        // Mettre à jour la progression
        progression = (i + 1) / villes.length;
        notifyListeners();

        // Attendre 2 secondes avant la prochaine ville
        await Future.delayed(const Duration(seconds: 2));
      }

      etat = EtatChargement.succes;
    } catch (e) {
      etat = EtatChargement.erreur;
      messageErreur = 'Erreur de connexion. Veuillez réessayer.';
    }

    notifyListeners();
  }

  // Réinitialiser pour recommencer
  void reinitialiser() {
    etat = EtatChargement.initial;
    donneesMeteo = [];
    progression = 0.0;
    notifyListeners();
  }

  // Message actuel
  String get messageActuel => messagesAttente[indexMessage];
}