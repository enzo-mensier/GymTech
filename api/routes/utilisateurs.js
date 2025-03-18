const express = require('express');
const router = express.Router();
const utilisateursController = require('../controllers/utilisateursController');

router.get('/', utilisateursController.getUtilisateurs);
router.get('/:id', utilisateursController.getUtilisateurById);
router.post('/', utilisateursController.createUser);
router.put('/:id', utilisateursController.updateUser);
router.delete('/:id', utilisateursController.deleteUser);

module.exports = router;