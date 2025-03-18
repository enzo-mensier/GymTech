import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/creneau.dart';
import '../widgets/custom_button.dart';

class CalendrierScreen extends StatelessWidget {
  final ApiService apiService = ApiService();

  CalendrierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Creneau>>(
      future: apiService.getCreneaux(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          if (snapshot.data != null) { // Vérification de valeur nulle
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Creneau creneau = snapshot.data![index];
                return ListTile(
                  title: Text(
                      '${creneau.date ?? ''} ${creneau.heureDebut ?? ''} - ${creneau.heureFin ?? ''}'), // Valeurs par défaut si null
                  trailing: creneau.disponibilite
                      ? CustomButton(
                    text: 'Réserver',
                    onPressed: () {
                      // TODO: Gérer la réservation
                    },
                  )
                      : Text('Réservé'),
                );
              },
            );
          } else {
            return Center(child: Text('Aucun créneau trouvé'));
          }
        } else {
          return Center(child: Text('Aucun créneau trouvé'));
        }
      },
    );
  }
}