const db = require('../utils/db');

exports.getCasiers = (req, res) => {
  db.query('SELECT * FROM casiers', (err, results) => {
    if (err) {
      console.error(err);
      res.status(500).json({ error: 'Erreur serveur' });
      return;
    }
    res.json(results);
  });
};

exports.getCasiersById = (req, res) => {
  const casierId = req.params.id;
  db.query('SELECT * FROM casiers WHERE id_casier = ?', [casierId], (err, results) => {
    if (err) {
      console.error(err);
      res.status(500).json({ error: 'Erreur serveur' });
      return;
    }
    if (results.length === 0) {
      res.status(404).json({ error: 'Casier non trouvé' });
      return;
    }
    res.json(results[0]);
  });
};

exports.createCasiers = (req, res) => {
  const { numero_casier, id_vestiaire, id_utilisateur } = req.body;
  db.query(
    'INSERT INTO casiers (numero_casier, id_vestiaire, id_utilisateur) VALUES (?, ?, ?)',
    [numero_casier, id_vestiaire, id_utilisateur],
    (err, result) => {
      if (err) {
        console.error(err);
        res.status(500).json({ error: 'Erreur serveur' });
        return;
      }
      res.status(201).json({ message: 'Casier créé', id: result.insertId });
    }
  );
};

exports.updateCasiers = (req, res) => {
  const casierId = req.params.id;
  const { numero_casier, id_vestiaire, id_utilisateur } = req.body;
  db.query(
    'UPDATE casiers SET numero_casier = ?, id_vestiaire = ?, id_utilisateur = ? WHERE id_casier = ?',
    [numero_casier, id_vestiaire, id_utilisateur, casierId],
    (err) => {
      if (err) {
        console.error(err);
        res.status(500).json({ error: 'Erreur serveur' });
        return;
      }
      res.json({ message: 'Casier mis à jour' });
    }
  );
};

exports.deleteCasiers = (req, res) => {
  const casierId = req.params.id;
  db.query('DELETE FROM casiers WHERE id_casier = ?', [casierId], (err) => {
    if (err) {
      console.error(err);
      res.status(500).json({ error: 'Erreur serveur' });
      return;
    }
    res.json({ message: 'Casier supprimé' });
  });
};