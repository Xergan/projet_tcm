import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SensorService {
  final String baseUrl = 'http://51.44.23.21:3000';

  /// Récupère la liste de tous les capteurs
  Future<List> getSensors() async {
    final url = Uri.parse('$baseUrl/capteurs/');
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json', 'x-api-key': dotenv.env['API_KEY']!},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erreur lors de la récupération des capteurs : ${response.statusCode}');
    }
  }

}