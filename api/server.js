const express = require('express');
const cors = require('cors');
const utilisateursRoutes = require('./routes/utilisateurs');
const casiersRoutes = require('./routes/casiers');
const creneauxRoutes = require('./routes/creneaux');
const reservationsRoutes = require('./routes/reservations');
require('dotenv').config();

const app = express();
const port = process.env.PORT || 3001;

app.use(cors());
app.use(express.json());

app.use('/api/utilisateurs', utilisateursRoutes);
app.use('/api/casiers', casiersRoutes);
app.use('/api/creneaux', creneauxRoutes);
app.use('/api/reservations', reservationsRoutes);

app.listen(port, () => {
  console.log(`Serveur Node.js démarré sur http://localhost:${port}`);
});