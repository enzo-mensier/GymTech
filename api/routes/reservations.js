class Reservations {
  final int? idReservation;
  final int? idUtilisateur;
  final int? idCreneau;
  // ... autres propriétés

  Reservations({required this.idReservation, required this.idUtilisateur, required this.idCreneau, /* ... */});

  factory Reservations.fromJson(Map<String, dynamic> json) {
    return Reservations(
      idReservation: json['ID_RESERVATION'],
      idUtilisateur: json['ID_UTILISATEUR'],
      idCreneau: json['ID_CRENEAU'],
      // ... autres propriétés
    );
  }
}