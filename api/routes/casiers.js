const express = require('express');
const router = express.Router();
const pool = require('../utils/db');

class Casier {
  constructor(idSalle, nomSalle) {
    this.idSalle = idSalle;
    this.nomSalle = nomSalle;
  }

  static fromJson(json) {
    return new Casier(
      json.ID_SALLE,
      json.NOM_SALLE
    );
  }
}

// Routes
router.get('/', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM casiers');
    const casiers = rows.map(row => Casier.fromJson(row));
    res.json(casiers);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get('/:id', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM casiers WHERE ID_SALLE = ?', [req.params.id]);
    if (rows.length === 0) {
      res.status(404).json({ error: 'Casier non trouvé' });
    } else {
      const casier = Casier.fromJson(rows[0]);
      res.json(casier);
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.post('/', async (req, res) => {
  try {
    const { nomSalle } = req.body;
    const [result] = await pool.query(
      'INSERT INTO casiers (NOM_SALLE) VALUES (?)',
      [nomSalle]
    );
    const casier = new Casier(result.insertId, nomSalle);
    res.status(201).json(casier);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;