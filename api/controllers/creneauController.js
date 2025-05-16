const pool = require('../utils/db');

async function getAvailableCreneaux(req, res) {
  try {
    const [rows] = await pool.query(
      'SELECT * FROM creneaux WHERE disponibilite = 1 ORDER BY date_creneau, heure_debut'
    );

    res.json(rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, message: 'Erreur lors de la récupération des créneaux' });
  }
}

async function reserveCreneau(req, res) {
  try {
    const { id_creneau, id_utilisateur } = req.body;

    // Vérifier si le créneau existe et est disponible
    const [creneau] = await pool.query(
      'SELECT * FROM creneaux WHERE id_creneau = ? AND disponibilite = 1',
      [id_creneau]
    );

    if (!creneau.length) {
      return res.status(400).json({ success: false, message: 'Créneau non disponible' });
    }

    // Mettre à jour la disponibilité du créneau
    await pool.query(
      'UPDATE creneaux SET disponibilite = 0 WHERE id_creneau = ?',
      [id_creneau]
    );

    // Insérer l'historique de réservation
    await pool.query(
      'INSERT INTO reservations (id_creneau, id_utilisateur) VALUES (?, ?)',
      [id_creneau, id_utilisateur]
    );

    res.json({ success: true, message: 'Créneau réservé avec succès' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, message: 'Erreur lors de la réservation' });
  }
}

async function getReservationsByUser(req, res) {
  try {
    const { id_utilisateur } = req.params;

    const [rows] = await pool.query(
      'SELECT c.* FROM creneaux c JOIN reservations r ON c.id_creneau = r.id_creneau WHERE r.id_utilisateur = ? ORDER BY c.date_creneau, c.heure_debut',
      [id_utilisateur]
    );

    res.json(rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, message: 'Erreur lors de la récupération des réservations' });
  }
}

module.exports = {
  getAvailableCreneaux
};
