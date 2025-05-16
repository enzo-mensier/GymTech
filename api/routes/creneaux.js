const express = require('express');
const router = express.Router();
const pool = require('../utils/db');

class Creneau {
  constructor(id_creneau, date_creneau, heure_debut, heure_fin, disponibilite) {
    this.id_creneau = id_creneau;
    this.date_creneau = date_creneau;
    this.heure_debut = heure_debut;
    this.heure_fin = heure_fin;
    this.disponibilite = disponibilite;
  }

  static fromJson(json) {
    return new Creneau(
      json.id_creneau,
      json.date_creneau,
      json.heure_debut,
      json.heure_fin,
      json.disponibilite
    );
  }
}

// Routes
router.get('/', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM creneaux');
    res.json(rows);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get('/available', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM creneaux WHERE disponibilite = 1 ORDER BY date_creneau, heure_debut');
    res.json(rows);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get('/user/:id', async (req, res) => {
  try {
    const [rows] = await pool.query(
      'SELECT c.* FROM creneaux c JOIN reservations r ON c.id_creneau = r.id_creneau WHERE r.id_utilisateur = ? ORDER BY c.date_creneau, c.heure_debut',
      [req.params.id]
    );
    res.json(rows);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get('/:id', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM creneaux WHERE ID_CRENEAU = ?', [req.params.id]);
    if (rows.length === 0) {
      res.status(404).json({ error: 'Créneau non trouvé' });
    } else {
      const creneau = Creneau.fromJson(rows[0]);
      res.json(creneau);
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.post('/reserve', async (req, res) => {
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
});

router.post('/', async (req, res) => {
  try {
    const { dateCreneau, heureDebut, heureFin } = req.body;
    const [result] = await pool.query(
      'INSERT INTO creneaux (DATE_CRENEAU, HEURE_DEBUT, HEURE_FIN) VALUES (?, ?, ?)',
      [dateCreneau, heureDebut, heureFin]
    );
    const creneau = new Creneau(result.insertId, dateCreneau, heureDebut, heureFin);
    res.status(201).json(creneau);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;