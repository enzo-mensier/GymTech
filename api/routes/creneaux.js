const express = require('express');
const router = express.Router();
const pool = require('../utils/db');

class Creneau {
  constructor(idCreneau, dateCreneau, heureDebut, heureFin) {
    this.idCreneau = idCreneau;
    this.dateCreneau = dateCreneau;
    this.heureDebut = heureDebut;
    this.heureFin = heureFin;
  }

  static fromJson(json) {
    return new Creneau(
      json.ID_CRENEAU,
      json.DATE_CRENEAU,
      json.HEURE_DEBUT,
      json.HEURE_FIN
    );
  }
}

// Routes
router.get('/', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM creneaux');
    const creneaux = rows.map(row => Creneau.fromJson(row));
    res.json(creneaux);
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