const pool = require('../utils/db');
const bcrypt = require('bcryptjs');

async function hashPasswords() {
  try {
    // Récupérer tous les utilisateurs
    const [users] = await pool.query('SELECT * FROM utilisateurs');

    for (const user of users) {
      // Hasher le mot de passe
      const hashedPassword = await bcrypt.hash(user.mot_de_passe, 10);
      
      // Mettre à jour le mot de passe hashé
      await pool.query(
        'UPDATE utilisateurs SET mot_de_passe = ? WHERE id_utilisateur = ?',
        [hashedPassword, user.id_utilisateur]
      );
    }

    console.log('Tous les mots de passe ont été hashés avec succès !');
  } catch (error) {
    console.error('Erreur lors du hashing des mots de passe:', error);
  } finally {
    // Fermer la connexion à la base de données
    await pool.end();
  }
}

hashPasswords();
