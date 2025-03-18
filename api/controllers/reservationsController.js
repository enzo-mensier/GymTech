const db = require('../utils/db');

exports.createReservation = (req, res) => {
  const { id_utilisateur, id_creneau } = req.body;
  db.query(
    'INSERT INTO reservations (id_utilisateur, id_creneau) VALUES (?, ?)',
    [id_utilisateur, id_creneau],
    (err, result) => {
      if (err) {
        console.error(err);
        res.status(500).json({ error: 'Erreur serveur' });
        return;
      }
      res.status(201).json({ message: 'Réservation créée', id: result.insertId });
    }
  );
};