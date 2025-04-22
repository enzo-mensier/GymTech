const pool = require('../utils/db');

async function getAllReservations(req, res) {
  try {
    const [rows] = await pool.query('SELECT * FROM RESERVATION');
    res.json(rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Erreur lors de la récupération des réservations' });
  }
}

async function getReservationById(req, res) {
  try {
    const [rows] = await pool.query('SELECT * FROM RESERVATION WHERE ID_RESERVATION = ?', [req.params.id]);
    if (rows.length === 0) {
      res.status(404).json({ message: 'Réservation non trouvée' });
    } else {
      res.json(rows[0]);
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Erreur lors de la récupération de la réservation' });
  }
}

async function createReservation(req, res) {
  try {
    const { ID_USER, ID_EQUIPEMENT, ID_COURS, DATE, HEURE_DEBUT, HEURE_FIN } = req.body;
    await pool.query('INSERT INTO RESERVATION (ID_USER, ID_EQUIPEMENT, ID_COURS, DATE, HEURE_DEBUT, HEURE_FIN) VALUES (?, ?, ?, ?, ?, ?)', [ID_USER, ID_EQUIPEMENT, ID_COURS, DATE, HEURE_DEBUT, HEURE_FIN]);
    res.status(201).json({ message: 'Réservation créée avec succès' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Erreur lors de la création de la réservation' });
  }
}

async function updateReservation(req, res) {
  try {
    const { ID_USER, ID_EQUIPEMENT, ID_COURS, DATE, HEURE_DEBUT, HEURE_FIN } = req.body;
    const [result] = await pool.query('UPDATE RESERVATION SET ID_USER = ?, ID_EQUIPEMENT = ?, ID_COURS = ?, DATE = ?, HEURE_DEBUT = ?, HEURE_FIN = ? WHERE ID_RESERVATION = ?', [ID_USER, ID_EQUIPEMENT, ID_COURS, DATE, HEURE_DEBUT, HEURE_FIN, req.params.id]);
    if (result.affectedRows === 0) {
      res.status(404).json({ message: 'Réservation non trouvée' });
    } else {
      res.json({ message: 'Réservation mise à jour avec succès' });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Erreur lors de la mise à jour de la réservation' });
  }
}

async function deleteReservation(req, res) {
  try {
    const [result] = await pool.query('DELETE FROM RESERVATION WHERE ID_RESERVATION = ?', [req.params.id]);
    if (result.affectedRows === 0) {
      res.status(404).json({ message: 'Réservation non trouvée' });
    } else {
      res.json({ message: 'Réservation supprimée avec succès' });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Erreur lors de la suppression de la réservation' });
  }
}

module.exports = {
  getAllReservations,
  getReservationById,
  createReservation,
  updateReservation,
  deleteReservation,
};