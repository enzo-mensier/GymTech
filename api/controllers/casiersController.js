const pool = require('../utils/db');

async function getAllCasiers(req, res) {
  try {
    const [rows] = await pool.query('SELECT * FROM SALLES');
    res.json(rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Erreur lors de la récupération des casiers' });
  }
}

async function getCasierById(req, res) {
  try {
    const [rows] = await pool.query('SELECT * FROM SALLES WHERE ID_SALLE = ?', [req.params.id]);
    if (rows.length === 0) {
      return res.status(404).json({ message: 'Casier non trouvé' });
    }
    res.json(rows[0]);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Erreur lors de la récupération du casier' });
  }
}

async function getCasierByUserId(req, res) {
  try {
    const [rows] = await pool.query('SELECT SALLES.* FROM USERS JOIN SALLES ON USERS.ID_SALLE = SALLES.ID_SALLE WHERE USERS.ID_USER = ?', [req.params.userId]);
    if (rows.length === 0) {
      return res.status(404).json({ message: 'Casier non trouvé' });
    }
    res.json(rows[0]);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Erreur lors de la récupération du casier' });
  }
}

async function createCasier(req, res) {
  try {
    const { ID_TYPE_SALLE, ID_USER, NOM_SALLE } = req.body;
    const [result] = await pool.query('INSERT INTO SALLES (ID_TYPE_SALLE, ID_USER, NOM_SALLE) VALUES (?, ?, ?)', [ID_TYPE_SALLE, ID_USER, NOM_SALLE]);
    res.status(201).json({ message: 'Casier créé avec succès', id: result.insertId });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Erreur lors de la création du casier' });
  }
}

async function updateCasier(req, res) {
  try {
    const { ID_TYPE_SALLE, ID_USER, NOM_SALLE } = req.body;
    const [result] = await pool.query('UPDATE SALLES SET ID_TYPE_SALLE = ?, ID_USER = ?, NOM_SALLE = ? WHERE ID_SALLE = ?', [ID_TYPE_SALLE, ID_USER, NOM_SALLE, req.params.id]);
    if (result.affectedRows === 0) {
      return res.status(404).json({ message: 'Casier non trouvé' });
    }
    res.json({ message: 'Casier mis à jour avec succès' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Erreur lors de la mise à jour du casier' });
  }
}

async function deleteCasier(req, res) {
  try {
    const [result] = await pool.query('DELETE FROM SALLES WHERE ID_SALLE = ?', [req.params.id]);
    if (result.affectedRows === 0) {
      return res.status(404).json({ message: 'Casier non trouvé' });
    }
    res.json({ message: 'Casier supprimé avec succès' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Erreur lors de la suppression du casier' });
  }
}

module.exports = {
  getAllCasiers,
  getCasierById,
  getCasierByUserId,
  createCasier,
  updateCasier,
  deleteCasier,
};