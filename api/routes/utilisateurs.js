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
    console.log('Requête reçue:', req.body);
    
    if (!req.body) {
      return res.status(400).json({ 
        success: false,
        message: 'Aucune donnée reçue' 
      });
    }

    const { nomUser, prenomUser, emailUser, motDePasseUser, genreUser, dateNaissanceUser } = req.body;

    console.log('Données déstructurées:');
    console.log('nomUser:', nomUser);
    console.log('prenomUser:', prenomUser);
    console.log('emailUser:', emailUser);
    console.log('motDePasseUser:', motDePasseUser);
    console.log('genreUser:', genreUser);
    console.log('dateNaissanceUser:', dateNaissanceUser);

    // Vérifier que tous les champs requis sont présents
    if (!nomUser || !prenomUser || !emailUser || !motDePasseUser || !genreUser || !dateNaissanceUser) {
      return res.status(400).json({ 
        success: false,
        message: 'Tous les champs sont requis' 
      });
    }

    // Vérifier que le genre est valide
    if (!['Homme', 'Femme', 'Autre'].includes(genreUser)) {
      return res.status(400).json({ 
        success: false,
        message: 'Le genre doit être Homme, Femme ou Autre' 
      });
    }

    // Validation de l'email
    if (!emailUser.includes('@')) {
      return res.status(400).json({ 
        success: false,
        message: 'Email invalide' 
      });
    }

    // Vérification que l'email n'existe pas déjà
    const [existingUser] = await pool.query(
      'SELECT ID_USER FROM utilisateurs WHERE EMAIL_USER = ?',
      [emailUser]
    );
    if (existingUser.length > 0) {
      return res.status(400).json({ 
        success: false,
        message: 'Cet email est déjà utilisé' 
      });
    }

    // Validation du mot de passe
    if (motDePasseUser.length < 6) {
      return res.status(400).json({ 
        success: false,
        message: 'Le mot de passe doit contenir au moins 6 caractères' 
      });
    }

    // Validation de la date de naissance
    let date;
    try {
      // Essaye d'abord avec le format DD/MM/YYYY
      date = new Date(dateNaissanceUser.split('/').reverse().join('-'));
    } catch {
      try {
        // Si cela échoue, essaye avec le format YYYY-MM-DD
        date = new Date(dateNaissanceUser);
      } catch {
        return res.status(400).json({
          success: false,
          message: 'Format de date invalide. Utilisez DD/MM/YYYY ou YYYY-MM-DD'
        });
      }
    }

    const now = new Date();
    if (date > now) {
      return res.status(400).json({ 
        success: false,
        message: 'La date de naissance ne peut pas être dans le futur' 
      });
    }
    const age = now.getFullYear() - date.getFullYear();
    if (age < 18) {
      return res.status(400).json({ 
        success: false,
        message: 'Vous devez avoir au moins 18 ans pour vous inscrire' 
      });
    }

    // Préparer la date pour MySQL
    const formattedDate = date.toISOString().split('T')[0];

    const [result] = await pool.query(
      'INSERT INTO utilisateurs (NOM_USER, PRENOM_USER, EMAIL_USER, MOT_DE_PASSE_USER, GENRE_USER, DATE_NAISSANCE_USER) VALUES (?, ?, ?, ?, ?, ?)',
      [nomUser, prenomUser, emailUser, motDePasseUser, genreUser, formattedDate]
    );
    
    res.status(201).json({ 
      success: true,
      message: 'Inscription réussie',
      id: result.insertId 
    });
  } catch (error) {
    console.error('Erreur lors de l\'inscription :', error);
    
    // Analyser l'erreur MySQL
    let errorMessage = 'Erreur lors de l\'inscription';
    if (error.code === 'ER_DUP_ENTRY') {
      errorMessage = 'Cet email est déjà utilisé';
    } else if (error.code === 'ER_BAD_FIELD_ERROR') {
      errorMessage = 'Format de données invalide';
    }

    res.status(500).json({ 
      success: false,
      message: errorMessage 
    });
  }
});

module.exports = router;