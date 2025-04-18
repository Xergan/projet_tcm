import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SensorService {
  final String baseUrl = 'http://51.44.23.21:3000';

  /// Récupère la liste de tous les capteurs
  Future<List> getSensors() async {
    try {
      final apiKey = dotenv.env['API_KEY'];
      if (apiKey == null) {
        throw Exception('API_KEY is not defined in the .env file');
      }

      final url = Uri.parse('$baseUrl/capteurs/');
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json', 'x-api-key': apiKey},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Erreur lors de la récupération des capteurs : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur réseau : $e');
    }
  }

  Future getDatas(String idCapteur, DateTime dateTime) async {
        try {
      final apiKey = dotenv.env['API_KEY'];
      if (apiKey == null) {
        throw Exception('API_KEY is not defined in the .env file');
      }

      final url = Uri.parse('$baseUrl/capteurs/remplissage?id_capteur=$idCapteur&date=$dateTime');
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json', 'x-api-key': apiKey},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Erreur lors de la récupération des données : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur réseau : $e');
    }
  }
}