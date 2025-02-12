import 'package:flutter/material.dart';

void main() {
  runApp(GymTechApp());
}

class GymTechApp extends StatefulWidget {
  @override
  _GymTechAppState createState() => _GymTechAppState();
}

class _GymTechAppState extends State<GymTechApp> {
  int _selectedIndex = 0;

  static const Color primaryColor = Color(0xFF4CAF50); // Vert personnalisé
  static const Color secondaryColor = Color(0xFF9E9E9E); // Gris personnalisé

  static const List<Widget> _pages = <Widget>[
    Center(child: Text('Page de réservation des créneaux', style: TextStyle(fontSize: 18))),
    Center(child: Text('Accès aux vestiaires et numéros de casier', style: TextStyle(fontSize: 18))),
    Center(child: Text('Données utilisateur', style: TextStyle(fontSize: 18))),
    Center(child: Text('Paramètres', style: TextStyle(fontSize: 18))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: primaryColor),
          titleTextStyle: TextStyle(color: primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              'assets/images/gymtech_logo.png',
              width: 50,
              height: 50,
              fit: BoxFit.contain,
            ),
          ),
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: primaryColor,
          unselectedItemColor: secondaryColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          elevation: 10,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Réservation'),
            BottomNavigationBarItem(icon: Icon(Icons.lock), label: 'Vestiaires'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Utilisateur'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Paramètres'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}