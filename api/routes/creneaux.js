const express = require('express');
const router = express.Router();
const creneauxController = require('../controllers/creneauxController');

router.get('/', creneauxController.getCreneaux);
router.get('/:id', creneauxController.getCreneauById);

module.exports = router;