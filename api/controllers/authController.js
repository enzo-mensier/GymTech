const pool = require('../utils/db');
const bcrypt = require('bcrypt');

async function login(req, res) {
  const { identifiant, password } = req.body;

  try {
    const [rows] = await pool.query(
      'SELECT * FROM USERS WHERE USER_NAME = ?',
      [identifiant]
    );

    if (rows.length > 0) {
      const user = rows[0];
      const passwordMatch = await bcrypt.compare(password, user.PSWD);

      if (passwordMatch) {
        res.json({ message: 'Connexion réussie' });
      } else {
        res.status(401).json({ message: 'Mot de passe incorrect' });
      }
    } else {
      res.status(401).json({ message: 'Identifiant incorrect' });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Erreur lors de la connexion' });
  }
}

async function register(req, res) {
  const { nom, prenom, userName, password, genre, id_type_user } = req.body;

  try {
    const hashedPassword = await bcrypt.hash(password, 10);

    const [result] = await pool.query(
      'INSERT INTO USERS (NOM_USER, PRENOM_USER, USER_NAME, PSWD, GENRE, ID_TYPE_USER, CREATED_AT) VALUES (?, ?, ?, ?, ?, ?, NOW())',
      [nom, prenom, userName, hashedPassword, genre, id_type_user]
    );

    res.status(201).json({ message: 'Utilisateur créé avec succès', id: result.insertId });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Erreur lors de l\'inscription' });
  }
}

module.exports = {
  login,
  register,
};