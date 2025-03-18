import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Future<void> _login(BuildContext context) async {
    // TODO: Implémenter la logique de connexion et récupérer le token
    String token = 'your_token'; // Remplacez par le token réel
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Connexion')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _login(context),
          child: Text('Se connecter'),
        ),
      ),
    );
  }
}