import 'package:flutter/material.dart';

void main() {
  runApp(GymTechApp());
}

class GymTechApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GymTech App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username == 'admin' && password == 'admin') {
      // Navigation vers la page admin
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminPage()),
      );
    } else if (username.isNotEmpty && password.isNotEmpty) {
      // Navigation vers la page utilisateur
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserPage(username: username)),
      );
    } else {
      // Affichage d'un message d'erreur si les champs sont vides
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Erreur de connexion'),
          content: Text('Veuillez entrer un nom d\'utilisateur et un mot de passe valides.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connexion GymTech'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Nom d\'utilisateur'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Se connecter'),
            ),
            TextButton(
              onPressed: () {
                // Raccourci pour admin
                _usernameController.text = 'admin';
                _passwordController.text = 'admin';
              },
              child: Text('Se connecter en tant qu\'admin'),
            ),
          ],
        ),
      ),
    );
  }
}

class UserPage extends StatelessWidget {
  final String username;

  UserPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenue $username'), // Titre de la page Utilisateur
      ),
      body: Center(
        child: Text('Page utilisateur\nBienvenue, $username !'),
      ),
    );
  }
}

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Administrateur'), // Titre de la page Administrateur
      ),
      body: Center(
        child: Text('Bienvenue Administrateur\nGestion des paramètres et utilisateurs.'),
      ),
    );
  }
}
