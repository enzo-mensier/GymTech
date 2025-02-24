import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/text_styles.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Réservation des créneaux',
                style: AppTextStyles.bold.copyWith(fontSize: 24, color: AppColors.textColor),
              ),
              const SizedBox(height: 16),
              Text(
                'Contenu de la page de réservation',
                style: AppTextStyles.regular.copyWith(color: AppColors.textColor),
              ),
            ],
          ),
        );
      case 1:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Accès aux vestiaires',
                style: AppTextStyles.bold.copyWith(fontSize: 24, color: AppColors.textColor),
              ),
              const SizedBox(height: 16),
              Text(
                'Contenu de la page des vestiaires',
                style: AppTextStyles.regular.copyWith(color: AppColors.textColor),
              ),
            ],
          ),
        );
      case 2:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Données utilisateur',
                style: AppTextStyles.bold.copyWith(fontSize: 24, color: AppColors.textColor),
              ),
              const SizedBox(height: 16),
              Text(
                'Contenu de la page des données',
                style: AppTextStyles.regular.copyWith(color: AppColors.textColor),
              ),
            ],
          ),
        );
      case 3:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Paramètres',
                style: AppTextStyles.bold.copyWith(fontSize: 24, color: AppColors.textColor),
              ),
              const SizedBox(height: 16),
              Text(
                'Contenu de la page des paramètres',
                style: AppTextStyles.regular.copyWith(color: AppColors.textColor),
              ),
            ],
          ),
        );
      default:
        return Container();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
      ),
      body: _buildPage(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.backgroundColor,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.contrastColor,
        showSelectedLabels: true,
        showUnselectedLabels: false,
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
    );
  }
}