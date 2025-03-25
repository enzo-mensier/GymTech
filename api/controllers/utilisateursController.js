const pool = require('../utils/db');

async function getAllUtilisateurs(req, res) {
  try {
    const [rows] = await pool.query('SELECT * FROM utilisateurs');
    res.json(rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Erreur lors de la récupération des utilisateurs' });
  }
}

async function getUtilisateurById(req, res) {
  try {
    const [rows] = await pool.query('SELECT * FROM utilisateurs WHERE id = ?', [req.params.id]);
    if (rows.length === 0) {
      res.status(404).json({ message: 'Utilisateur non trouvé' });
    } else {
      res.json(rows[0]);
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Erreur lors de la récupération de l\'utilisateur' });
  }
}

async function createUtilisateur(req, res) {
  try {
    const { nom, prenom, email, mot_de_passe } = req.body; // Adaptez les champs à votre table
    const [result] = await pool.query('INSERT INTO utilisateurs (nom, prenom, email, mot_de_passe) VALUES (?, ?, ?, ?)', [nom, prenom, email, mot_de_passe]);
    res.status(201).json({ message: 'Utilisateur créé avec succès', id: result.insertId });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Erreur lors de la création de l\'utilisateur' });
  }
}

async function updateUtilisateur(req, res) {
  try {
    const { nom, prenom, email, mot_de_passe } = req.body; // Adaptez les champs à votre table
    const [result] = await pool.query('UPDATE utilisateurs SET nom = ?, prenom = ?, email = ?, mot_de_passe = ? WHERE id = ?', [nom, prenom, email, mot_de_passe, req.params.id]);
    if (result.affectedRows === 0) {
      res.status(404).json({ message: 'Utilisateur non trouvé' });
    } else {
      res.json({ message: 'Utilisateur mis à jour avec succès' });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Erreur lors de la mise à jour de l\'utilisateur' });
  }
}

async function deleteUtilisateur(req, res) {
  try {
    const [result] = await pool.query('DELETE FROM utilisateurs WHERE id = ?', [req.params.id]);
    if (result.affectedRows === 0) {
      res.status(404).json({ message: 'Utilisateur non trouvé' });
    } else {
      res.json({ message: 'Utilisateur supprimé avec succès' });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Erreur lors de la suppression de l\'utilisateur' });
  }
}

module.exports = {
  getAllUtilisateurs,
  getUtilisateurById,
  createUtilisateur,
  updateUtilisateur,
  deleteUtilisateur,
};