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

  static const List<Widget> _pages = <Widget>[
    Center(child: Text('Page de réservation des créneaux', style: TextStyle(fontSize: 18))),
    Center(child: Text('Accés aux vestiaires et numéros de casier', style: TextStyle(fontSize: 18))),
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
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey,
          flexibleSpace: Center(
            child: SizedBox(
              height: 80, // Ajuste cette valeur selon tes besoins
              width: 150, // Ajuste cette valeur selon tes besoins
              child: Image.asset('assets/gymtech-logo.png', fit: BoxFit.contain),
            ),
          ),
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Réservation'),
            BottomNavigationBarItem(icon: Icon(Icons.lock), label: 'Vestiaires'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Utilisateur'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Paramètres'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
