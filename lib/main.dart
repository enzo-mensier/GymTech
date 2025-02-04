import 'package:flutter/material.dart';

// Point d'entrée principal de l'application
void main() {
  runApp(GymTechApp());
}

// Définition de l'application GymTech en tant que StatefulWidget
class GymTechApp extends StatefulWidget {
  @override
  _GymTechAppState createState() => _GymTechAppState();
}

class _GymTechAppState extends State<GymTechApp> {
  // Index de la page actuellement sélectionnée
  int _selectedIndex = 0;

  // Liste des pages de l'application affichées dans le corps de l'interface
  static const List<Widget> _pages = <Widget>[
    Center(child: Text('Page de réservation des créneaux', style: TextStyle(fontSize: 18))),
    Center(child: Text('Accès aux vestiaires et numéros de casier', style: TextStyle(fontSize: 18))),
    Center(child: Text('Données utilisateur', style: TextStyle(fontSize: 18))),
    Center(child: Text('Paramètres', style: TextStyle(fontSize: 18))),
  ];

  // Fonction appelée lorsqu'un élément de la barre de navigation est sélectionné
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green), // Définition du thème de l'application
      home: Scaffold(
        // Définit l'arrière-plan en blanc
        backgroundColor: Colors.white,
        // Barre d'application avec logo centré
        appBar: AppBar(
          backgroundColor: Colors.white, // Met aussi l'AppBar en blanc
          elevation: 0, // Supprime l'ombre pour un effet plus propre
          automaticallyImplyLeading: false, // Suppression du titre par défaut
          flexibleSpace: Padding(
            padding: EdgeInsets.only(top: 45), // Ajout d'un espace en haut
            child: Align(
              alignment: Alignment.topCenter, // Centrage horizontal de l'image
              child: Image.asset(
                'assets/gymtech-logo.png',
                fit: BoxFit.contain, // Conservation des proportions originales de l'image
              ),
            ),
          ),
        ),
        // Contenu principal de la page basé sur l'index sélectionné
        body: _pages[_selectedIndex],
        // Barre de navigation inférieure permettant de naviguer entre les pages
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Réservation'),
            BottomNavigationBarItem(icon: Icon(Icons.lock), label: 'Vestiaires'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Utilisateur'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Paramètres'),
          ],
          currentIndex: _selectedIndex, // Page actuellement sélectionnée
          selectedItemColor: Colors.green, // Couleur de l'élément sélectionné
          unselectedItemColor: Colors.grey, // Couleur des éléments non sélectionnés
          onTap: _onItemTapped, // Gestion du changement de page
        ),
      ),
    );
  }
}