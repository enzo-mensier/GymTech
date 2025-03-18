const db = require('../utils/db');

exports.getCreneaux = (req, res) => {
  db.query('SELECT * FROM creneaux', (err, results) => {
    if (err) {
      console.error(err);
      res.status(500).json({ error: 'Erreur serveur' });
      return;
    }
    res.json(results);
  });
};

exports.getCreneauById = (req, res) => {
  const creneauId = req.params.id;
  db.query('SELECT * FROM creneaux WHERE id_creneau = ?', [creneauId], (err, results) => {
    if (err) {
      console.error(err);
      res.status(500).json({ error: 'Erreur serveur' });
      return;
    }
    if (results.length === 0) {
      res.status(404).json({ error: 'Créneau non trouvé' });
      return;
    }
    res.json(results[0]);
  });
};