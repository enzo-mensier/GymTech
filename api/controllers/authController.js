const pool = require('../utils/db');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const config = require('../config');

async function login(req, res) {
  const { email, password } = req.body;

  try {
    const [rows] = await pool.query(
      'SELECT * FROM utilisateurs WHERE email = ?',
      [email]
    );

    if (rows.length > 0) {
      const user = rows[0];
      const passwordMatch = await bcrypt.compare(password, user.mot_de_passe);

      if (passwordMatch) {
        const token = jwt.sign(
          { id: user.id_utilisateur, email: user.email },
          config.jwtSecret,
          { expiresIn: '24h' }
        );

        res.json({
          success: true,
          token,
          user: {
            id: user.id_utilisateur,
            nom: user.nom,
            prenom: user.prenom,
            email: user.email,
            genre: user.genre
          }
        });
      } else {
        res.status(401).json({ success: false, message: 'Mot de passe incorrect' });
      }
    } else {
      res.status(401).json({ success: false, message: 'Email non trouvé' });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, message: 'Erreur lors de la connexion' });
  }
}

async function register(req, res) {
  const { nom, prenom, email, password, genre, date_naissance } = req.body;

  try {
    const [rows] = await pool.query(
      'SELECT * FROM utilisateurs WHERE email = ?',
      [email]
    );

    if (rows.length > 0) {
      res.status(400).json({ success: false, message: 'Email déjà utilisé' });
      return;
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    const [result] = await pool.query(
      'INSERT INTO utilisateurs (nom, prenom, email, mot_de_passe, genre, date_naissance) VALUES (?, ?, ?, ?, ?, ?)',
      [nom, prenom, email, hashedPassword, genre, date_naissance]
    );

    res.status(201).json({
      success: true,
      message: 'Inscription réussie',
      user: {
        id: result.insertId,
        nom,
        prenom,
        email,
        genre
      }
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, message: 'Erreur lors de l\'inscription' });
  }
}

async function getCurrentUser(req, res) {
  try {
    const [rows] = await pool.query(
      'SELECT * FROM utilisateurs WHERE id_utilisateur = ?',
      [req.user.id]
    );

    if (rows.length > 0) {
      const user = rows[0];
      res.json({
        success: true,
        user: {
          id: user.id_utilisateur,
          nom: user.nom,
          prenom: user.prenom,
          email: user.email,
          genre: user.genre,
          date_naissance: user.date_naissance
        }
      });
    } else {
      res.status(404).json({ success: false, message: 'Utilisateur non trouvé' });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, message: 'Erreur lors de la récupération des données' });
  }
}

module.exports = {
  login,
  register,
  getCurrentUser
};