import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/utilisateur.dart';
import '../models/genre.dart';

class AuthService {
  static const String baseUrl = 'http://localhost:3002/api';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erreur de connexion');
    }
  }

  Future<Map<String, dynamic>> register(Utilisateur utilisateur) async {
    try {
      print('Données envoyées au serveur:');
      print(utilisateur.toJson());

      final response = await http.post(
        Uri.parse('$baseUrl/utilisateurs'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(utilisateur.toJson()),
      );

      print('Réponse du serveur:');
      print('Code: ${response.statusCode}');
      print('Body: ${response.body}');

      if (response.statusCode != 201) {
        throw Exception('Erreur serveur: ${response.statusCode}');
      }

      final data = jsonDecode(response.body);
      
      if (!data['success']) {
        throw Exception(data['message'] ?? 'Erreur lors de l\'inscription');
      }

      return data;
    } catch (e) {
      print('Erreur lors de l\'inscription: $e');
      
      if (e is FormatException) {
        throw Exception('Format de données invalide');
      } else if (e.toString().contains('400')) {
        throw Exception('Données invalides');
      } else if (e.toString().contains('500')) {
        throw Exception('Erreur serveur');
      }
      
      throw Exception('Erreur lors de l\'inscription: ${e.toString()}');
    }
  }
}
