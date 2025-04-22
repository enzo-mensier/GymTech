const pool = require('../utils/db');

async function getAllCreneaux(req, res) {
  try {
    const [rows] = await pool.query(`
      SELECT
        s.*
      FROM
        SEANCES s
      WHERE
        NOT EXISTS (
          SELECT
            1
          FROM
            RESERVATION r
          WHERE
            r.DATE = s.DATE_SEANCE
            AND r.HEURE_DEBUT < DATE_ADD(s.DATE_SEANCE, INTERVAL s.DUREE_SEANCE MINUTE)
            AND r.HEURE_FIN > s.DATE_SEANCE
        )
    `);
    res.json(rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Erreur lors de la récupération des créneaux disponibles' });
  }
}

module.exports = {
  getAllCreneaux,
};