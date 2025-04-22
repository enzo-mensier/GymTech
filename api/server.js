const express = require('express');
const cors = require('cors');
const utilisateursRoutes = require('./routes/utilisateurs');
const reservationsRoutes = require('./routes/reservations');
const casiersRoutes = require('./routes/casiers');
const creneauxRoutes = require('./routes/creneaux');
const authRoutes = require('./routes/auth'); // Ajout des routes d'authentification

const app = express();
const port = 3002;

app.use(cors());
app.use(express.json());

app.use('/api/utilisateurs', utilisateursRoutes);
app.use('/api/reservations', reservationsRoutes);
app.use('/api/casiers', casiersRoutes);
app.use('/api/creneaux', creneauxRoutes);
app.use('/api/auth', authRoutes); // Utilisation des routes d'authentification

app.listen(port, () => {
  console.log(`Serveur démarré sur le port ${port}`);
});