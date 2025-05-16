import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/api_service.dart';
import '../models/creneau.dart';
import '../widgets/custom_button.dart';
import '../utils/colors.dart';

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
                
                // Formatage de la date
                final dateFormatter = DateFormat('EEEE d MMMM yyyy', 'fr_FR');
                final heureFormatter = DateFormat('HH:mm');
                
                // Conversion des chaînes de date/heure en DateTime
                final date = DateTime.parse(creneau.date);
                final heureDebut = DateTime.parse('${creneau.date} ${creneau.heureDebut}');
                final heureFin = DateTime.parse('${creneau.date} ${creneau.heureFin}');
                
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(
                      '${dateFormatter.format(date)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          '${heureFormatter.format(heureDebut)} - ${heureFormatter.format(heureFin)}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    trailing: creneau.disponibilite
                        ? CustomButton(
                            text: 'Réserver',
                            onPressed: () {
                              // TODO: Gérer la réservation
                              print('Réserver le créneau ${creneau.id}');
                            },
                          )
                        : Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'Réservé',
                              style: TextStyle(color: AppColors.primaryColor),
                            ),
                          ),
                  ),
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