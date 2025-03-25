class Utilisateur {
  final int? idUser;
  final String nomUser;
  final String prenomUser;
  // ... autres propriétés

  Utilisateur({required this.idUser, required this.nomUser, required this.prenomUser, /* ... */});

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      idUser: json['ID_USER'],
      nomUser: json['NOM_USER'],
      prenomUser: json['PRENOM_USER'],
      // ... autres propriétés
    );
  }
}