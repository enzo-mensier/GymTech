class Creneaux {
  final int idCreneau;
  final DateTime dateCreneau;
  final TimeOfDay heureDebut;
  final TimeOfDay heureFin;
  // ... autres propriétés

  Creneaux({required this.idCreneau, required this.dateCreneau, required this.heureDebut, required this.heureFin, /* ... */});

  factory Creneaux.fromJson(Map<String, dynamic> json) {
    return Creneaux(
      idCreneau: json['ID_CRENEAU'],
      dateCreneau: DateTime.parse(json['DATE_CRENEAU']),
      heureDebut: TimeOfDay(hour: int.parse(json['HEURE_DEBUT'].split(':')[0]), minute: int.parse(json['HEURE_DEBUT'].split(':')[1])),
      heureFin: TimeOfDay(hour: int.parse(json['HEURE_FIN'].split(':')[0]), minute: int.parse(json['HEURE_FIN'].split(':')[1])),
      // ... autres propriétés
    );
  }
}