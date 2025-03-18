const express = require('express');
const router = express.Router();
const casiersController = require('../controllers/casiersController');

router.get('/', casiersController.getCasiers);
router.get('/:id', casiersController.getCasiersById);
router.post('/', casiersController.createCasiers);
router.put('/:id', casiersController.updateCasiers);
router.delete('/:id', casiersController.deleteCasiers);

module.exports = router;