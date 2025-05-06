const express = require('express');
const router = express.Router();
const pool = require('../utils/db');

class Reservation {
  constructor(idReservation, idUtilisateur, idCreneau) {
    this.idReservation = idReservation;
    this.idUtilisateur = idUtilisateur;
    this.idCreneau = idCreneau;
  }

  static fromJson(json) {
    return new Reservation(
      json.ID_RESERVATION,
      json.ID_UTILISATEUR,
      json.ID_CRENEAU
    );
  }
}

// Routes
router.get('/', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM reservations');
    const reservations = rows.map(row => Reservation.fromJson(row));
    res.json(reservations);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get('/:id', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM reservations WHERE ID_RESERVATION = ?', [req.params.id]);
    if (rows.length === 0) {
      res.status(404).json({ error: 'Réservation non trouvée' });
    } else {
      const reservation = Reservation.fromJson(rows[0]);
      res.json(reservation);
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.post('/', async (req, res) => {
  try {
    const { idUtilisateur, idCreneau } = req.body;
    const [result] = await pool.query(
      'INSERT INTO reservations (ID_UTILISATEUR, ID_CRENEAU) VALUES (?, ?)',
      [idUtilisateur, idCreneau]
    );
    const reservation = new Reservation(result.insertId, idUtilisateur, idCreneau);
    res.status(201).json(reservation);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;