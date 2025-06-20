import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  final String baseUrl = 'http://51.44.23.21:3000';

  Future<Map<String, dynamic>> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/users/login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': dotenv.env['API_KEY']??"",
      },
      body: jsonEncode({'username': username, 'password': password}),
    );

    return {'statusCode': response.statusCode, 'message': jsonDecode(response.body)['message'] ?? "Erreur Inconnue."};
  }
}
