import 'package:flutter/material.dart';

void main() {
  runApp(GymTechApp());
}

class GymTechApp extends StatefulWidget {
  @override
  _GymTechAppState createState() => _GymTechAppState();
}

class _GymTechAppState extends State<GymTechApp> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  bool _isLoading = true;
  double _xPosition = 0;
  late double _screenWidth;
  late double _screenHeight;

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

  // Calcul de la taille du logo d'animation en fonction de la taille de l'écran
  double _calculateAnimationLogoSize() {
    // Utilise 20% de la plus petite dimension de l'écran
    double minScreenDimension = _screenWidth < _screenHeight ? _screenWidth : _screenHeight;
    return minScreenDimension * 0.4;
  }

  // Calcul de la taille du logo final en fonction de la taille de l'écran
  double _calculateFinalLogoSize() {
    return _calculateAnimationLogoSize() / 4;
  }

  // Position initiale du logo (hors écran à gauche)
  double _getInitialPosition() {
    return -_calculateAnimationLogoSize() * 1.5;
  }

  // Position centrale du logo
  double _getCenterPosition() {
    return (_screenWidth - _calculateAnimationLogoSize()) / 2;
  }

  // Position finale du logo (hors écran à droite)
  double _getFinalPosition() {
    return _screenWidth + _calculateAnimationLogoSize() * 1.5;
  }

  @override
  void initState() {
    super.initState();

    // La séquence d'animation sera initialisée dans didChangeDependencies
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Récupération des dimensions de l'écran
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;

    // Initialisation de la position de départ
    _xPosition = _getInitialPosition();

    // Séquence d'animation
    Future.delayed(Duration(milliseconds: 200), () {
      // Logo arrive au centre
      setState(() {
        _xPosition = _getCenterPosition();
      });
    });

    Future.delayed(Duration(milliseconds: 1800), () {
      // Logo sort par la droite
      setState(() {
        _xPosition = _getFinalPosition();
      });
    });

    Future.delayed(Duration(milliseconds: 4400), () {
      // Affichage de l'interface principale
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double animationLogoSize = _calculateAnimationLogoSize();
    double finalLogoSize = _calculateFinalLogoSize();

    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: !_isLoading
              ? Container(
            width: finalLogoSize,
            height: finalLogoSize,
            child: Image.asset(
              'assets/gymtech-logo.png',
              fit: BoxFit.contain,
            ),
          )
              : null,
        ),
        body: Stack(
          children: [
            if (_isLoading)
              AnimatedPositioned(
                duration: Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                left: _xPosition,
                top: (_screenHeight - animationLogoSize) / 2.5,
                child: Image.asset(
                  'assets/gymtech-logo.png',
                  width: animationLogoSize,
                  height: animationLogoSize,
                  fit: BoxFit.contain,
                ),
              ),
            if (!_isLoading)
              _pages[_selectedIndex],
          ],
        ),
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