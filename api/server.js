const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const app = express();
const port = 3001; // Port du localhost

// Configurer CORS
app.use(cors());

// Créer la connexion à la base de données MySQL
const db = mysql.createConnection({
  host: '127.0.0.1', // ou l'adresse de ton serveur MySQL
  user: 'root', // utilisateur de la base de données
  password: '', // mot de passe de l'utilisateur
  database: 'gymtech', // nom de la base de données
});

// Vérifier la connexion à la base de données
db.connect((err) => {
  if (err) {
    console.error('Erreur de connexion à la base de données: ' + err.stack);
    return;
  }
  console.log('Connecté à la base de données MySQL');
});

// Route pour récupérer les utilisateurs
app.get('/api/utilisateurs', (req, res) => {
  db.query('SELECT * FROM utilisateurs', (err, results) => {
    if (err) {
      console.error('Erreur lors de la récupération des utilisateurs:', err);
      res.status(500).send('Erreur serveur');
      return;
    }
    res.json(results); // Retourne les résultats au format JSON
  });
});

// Route pour récupérer d'autres données comme les casiers
app.get('/api/casiers', (req, res) => {
  db.query('SELECT * FROM casiers', (err, results) => {
    if (err) {
      console.error('Erreur lors de la récupération des casiers:', err);
      res.status(500).send('Erreur serveur');
      return;
    }
    res.json(results);
  });
});

// Démarrer le serveur
app.listen(port, () => {
  console.log(`Serveur Node.js démarré sur http://localhost:${port}`);
});
