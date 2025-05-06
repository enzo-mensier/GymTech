const express = require('express');
const router = express.Router();
const pool = require('../utils/db');

class Utilisateur {
  constructor(idUser, nomUser, prenomUser) {
    this.idUser = idUser;
    this.nomUser = nomUser;
    this.prenomUser = prenomUser;
  }

  static fromJson(json) {
    return new Utilisateur(
      json.ID_USER,
      json.NOM_USER,
      json.PRENOM_USER
    );
  }
}

// Routes
router.get('/', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM utilisateurs');
    res.json(rows);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get('/:id', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM utilisateurs WHERE ID_USER = ?', [req.params.id]);
    if (rows.length === 0) {
      res.status(404).json({ error: 'Utilisateur non trouvé' });
    } else {
      res.json(rows[0]);
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.post('/', async (req, res) => {
  try {
    const { nomUser, prenomUser } = req.body;
    const [result] = await pool.query(
      'INSERT INTO utilisateurs (NOM_USER, PRENOM_USER) VALUES (?, ?)',
      [nomUser, prenomUser]
    );
    res.status(201).json({ id: result.insertId });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;