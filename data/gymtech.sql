-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : lun. 12 mai 2025 à 09:41
-- Version du serveur : 9.1.0
-- Version de PHP : 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `gymtech`
--

-- --------------------------------------------------------

--
-- Structure de la table `casiers`
--

DROP TABLE IF EXISTS `casiers`;
CREATE TABLE IF NOT EXISTS `casiers` (
  `id_casier` int NOT NULL AUTO_INCREMENT,
  `numero_casier` int NOT NULL,
  `id_vestiaire` int NOT NULL,
  `id_utilisateur` int DEFAULT NULL,
  PRIMARY KEY (`id_casier`),
  UNIQUE KEY `numero_casier` (`numero_casier`),
  UNIQUE KEY `id_utilisateur` (`id_utilisateur`),
  KEY `id_vestiaire` (`id_vestiaire`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `casiers`
--

INSERT INTO `casiers` (`id_casier`, `numero_casier`, `id_vestiaire`, `id_utilisateur`) VALUES
(1, 101, 1, 1),
(2, 102, 2, 2),
(3, 103, 1, 3);

-- --------------------------------------------------------

--
-- Structure de la table `creneaux`
--

DROP TABLE IF EXISTS `creneaux`;
CREATE TABLE IF NOT EXISTS `creneaux` (
  `id_creneau` int NOT NULL AUTO_INCREMENT,
  `date_creneau` date NOT NULL,
  `heure_debut` time NOT NULL,
  `heure_fin` time NOT NULL,
  `disponibilite` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_creneau`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `creneaux`
--

INSERT INTO `creneaux` (`id_creneau`, `date_creneau`, `heure_debut`, `heure_fin`, `disponibilite`) VALUES
(1, '2025-02-05', '09:00:00', '10:00:00', 1),
(2, '2025-02-05', '10:00:00', '11:00:00', 0),
(3, '2025-02-06', '14:00:00', '15:00:00', 1);

-- --------------------------------------------------------

--
-- Structure de la table `energieproduite`
--

DROP TABLE IF EXISTS `energieproduite`;
CREATE TABLE IF NOT EXISTS `energieproduite` (
  `id_energie` int NOT NULL AUTO_INCREMENT,
  `id_utilisateur` int NOT NULL,
  `date_enregistrement` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `energie_kWh` decimal(10,3) DEFAULT NULL,
  PRIMARY KEY (`id_energie`),
  KEY `id_utilisateur` (`id_utilisateur`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `energieproduite`
--

INSERT INTO `energieproduite` (`id_energie`, `id_utilisateur`, `date_enregistrement`, `energie_kWh`) VALUES
(1, 1, '2025-02-04 07:10:00', 1.250),
(2, 2, '2025-02-04 07:15:00', 1.500),
(3, 3, '2025-02-04 07:20:00', 2.000);

-- --------------------------------------------------------

--
-- Structure de la table `performances`
--

DROP TABLE IF EXISTS `performances`;
CREATE TABLE IF NOT EXISTS `performances` (
  `id_performance` int NOT NULL AUTO_INCREMENT,
  `id_utilisateur` int NOT NULL,
  `date_enregistrement` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `frequence_cardiaque` int DEFAULT NULL,
  `calories_brulees` decimal(10,2) DEFAULT NULL,
  `duree_exercice` time DEFAULT NULL,
  PRIMARY KEY (`id_performance`),
  KEY `id_utilisateur` (`id_utilisateur`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `performances`
--

INSERT INTO `performances` (`id_performance`, `id_utilisateur`, `date_enregistrement`, `frequence_cardiaque`, `calories_brulees`, `duree_exercice`) VALUES
(1, 1, '2025-02-04 07:12:00', 120, 200.50, '00:30:00'),
(2, 2, '2025-02-04 07:17:00', 115, 180.30, '00:35:00'),
(3, 3, '2025-02-04 07:22:00', 130, 220.00, '00:40:00');

-- --------------------------------------------------------

--
-- Structure de la table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
CREATE TABLE IF NOT EXISTS `reservations` (
  `id_reservation` int NOT NULL AUTO_INCREMENT,
  `id_utilisateur` int NOT NULL,
  `id_creneau` int NOT NULL,
  `date_reservation` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_reservation`),
  KEY `id_utilisateur` (`id_utilisateur`),
  KEY `id_creneau` (`id_creneau`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `reservations`
--

INSERT INTO `reservations` (`id_reservation`, `id_utilisateur`, `id_creneau`, `date_reservation`) VALUES
(1, 1, 1, '2025-02-04 07:00:00'),
(2, 2, 3, '2025-02-04 07:10:00'),
(3, 3, 2, '2025-02-04 07:15:00');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

DROP TABLE IF EXISTS `utilisateurs`;
CREATE TABLE IF NOT EXISTS `utilisateurs` (
  `id_utilisateur` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `mot_de_passe` varchar(255) NOT NULL,
  `genre` enum('Homme','Femme','Autre') NOT NULL,
  `date_naissance` date NOT NULL,
  `date_inscription` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_utilisateur`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `utilisateurs`
--

INSERT INTO `utilisateurs` (`id_utilisateur`, `nom`, `prenom`, `email`, `mot_de_passe`, `genre`, `date_naissance`, `date_inscription`) VALUES
(1, 'Doe', 'John', 'johndoe@example.com', '$2b$10$EDLJYlOJBJaZ0tLB2iPpI.ixqm8GoXUXIzlLrlwHk/i3vrLWukhgO', 'Homme', '1995-05-15', '2025-02-04 07:52:57'),
(2, 'Smith', 'Jane', 'janesmith@example.com', '$2b$10$ubbs9L7xMPX2XLbBvPcmR.OKxYmqPFNnKw3Yuo05.J7IugzZTA6KC', 'Femme', '1990-03-10', '2025-02-04 07:00:00'),
(3, 'Johnson', 'Alex', 'alexjohnson@example.com', '$2b$10$sUcdXfsIjPOzNl.1RzvKhuUTdbrCjUCWS0nWzdumRHWJTfHImLmrG', 'Autre', '1993-08-25', '2025-02-04 07:05:00');

-- --------------------------------------------------------

--
-- Structure de la table `vestiaires`
--

DROP TABLE IF EXISTS `vestiaires`;
CREATE TABLE IF NOT EXISTS `vestiaires` (
  `id_vestiaire` int NOT NULL AUTO_INCREMENT,
  `genre` enum('Homme','Femme') NOT NULL,
  PRIMARY KEY (`id_vestiaire`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `vestiaires`
--

INSERT INTO `vestiaires` (`id_vestiaire`, `genre`) VALUES
(1, 'Homme'),
(2, 'Femme');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
