import 'package:flutter/material.dart';
import '../models/genre.dart';

class Utilisateur {
  final int idUser;
  final String nomUser;
  final String prenomUser;
  final String emailUser;
  final String motDePasseUser;
  final Genre genreUser;
  final String dateNaissanceUser;

  Utilisateur({
    this.idUser = 0,
    required this.nomUser,
    required this.prenomUser,
    required this.emailUser,
    required this.motDePasseUser,
    required this.genreUser,
    required this.dateNaissanceUser,
  });

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      idUser: json['ID_USER'] ?? 0,
      nomUser: json['NOM_USER'] ?? '',
      prenomUser: json['PRENOM_USER'] ?? '',
      emailUser: json['EMAIL_USER'] ?? '',
      motDePasseUser: json['MOT_DE_PASSE_USER'] ?? '',
      genreUser: Genre.fromValue(json['GENRE_USER'] ?? 'H'),
      dateNaissanceUser: json['DATE_NAISSANCE_USER'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    // Convertir la date DD/MM/YYYY en YYYY-MM-DD
    final dateParts = dateNaissanceUser.split('/');
    final formattedDate = '${dateParts[2]}-${dateParts[1]}-${dateParts[0]}';
    
    return {
      'nomUser': nomUser,
      'prenomUser': prenomUser,
      'emailUser': emailUser,
      'motDePasseUser': motDePasseUser,
      'genreUser': genreUser.value,
      'dateNaissanceUser': formattedDate,
    };
  }
}