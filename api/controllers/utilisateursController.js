const db = require('../utils/db');

exports.getUtilisateurs = (req, res) => {
  db.query('SELECT * FROM utilisateurs', (err, results) => {
    if (err) {
      console.error(err);
      res.status(500).json({ error: 'Erreur serveur' });
      return;
    }
    res.json(results);
  });
};

exports.getUtilisateurById = (req, res) => {
  const userId = req.params.id;
  db.query('SELECT * FROM utilisateurs WHERE id_utilisateur = ?', [userId], (err, results) => {
    if (err) {
      console.error(err);
      res.status(500).json({ error: 'Erreur serveur' });
      return;
    }
    if (results.length === 0) {
      res.status(404).json({ error: 'Utilisateur non trouvé' });
      return;
    }
    res.json(results[0]);
  });
};

exports.createUser = (req, res) => {
  const { nom, prenom, email, mot_de_passe, genre, date_naissance } = req.body;
  db.query(
    'INSERT INTO utilisateurs (nom, prenom, email, mot_de_passe, genre, date_naissance) VALUES (?, ?, ?, ?, ?, ?)',
    [nom, prenom, email, mot_de_passe, genre, date_naissance],
    (err, result) => {
      if (err) {
        console.error(err);
        res.status(500).json({ error: 'Erreur serveur' });
        return;
      }
      res.status(201).json({ message: 'Utilisateur créé', id: result.insertId });
    }
  );
};

exports.updateUser = (req, res) => {
  const userId = req.params.id;
  const { nom, prenom, email, mot_de_passe, genre, date_naissance } = req.body;
  db.query(
    'UPDATE utilisateurs SET nom = ?, prenom = ?, email = ?, mot_de_passe = ?, genre = ?, date_naissance = ? WHERE id_utilisateur = ?',
    [nom, prenom, email, mot_de_passe, genre, date_naissance, userId],
    (err) => {
      if (err) {
        console.error(err);
        res.status(500).json({ error: 'Erreur serveur' });
        return;
      }
      res.json({ message: 'Utilisateur mis à jour' });
    }
  );
};

exports.deleteUser = (req, res) => {
  const userId = req.params.id;
  db.query('DELETE FROM utilisateurs WHERE id_utilisateur = ?', [userId], (err) => {
    if (err) {
      console.error(err);
      res.status(500).json({ error: 'Erreur serveur' });
      return;
    }
    res.json({ message: 'Utilisateur supprimé' });
  });
};