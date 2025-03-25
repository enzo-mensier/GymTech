class Casiers {
  final int idSalle;
  final String nomSalle;
  // ... autres propriétés

  Casiers({required this.idSalle, required this.nomSalle, /* ... */});

  factory Casiers.fromJson(Map<String, dynamic> json) {
    return Casiers(
      idSalle: json['ID_SALLE'],
      nomSalle: json['NOM_SALLE'],
      // ... autres propriétés
    );
  }
}