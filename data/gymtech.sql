-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : ven. 07 mars 2025 à 10:05
-- Version du serveur :  5.7.31
-- Version de PHP : 7.3.21

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
-- Structure de la table `cours`
--

DROP TABLE IF EXISTS `cours`;
CREATE TABLE IF NOT EXISTS `cours` (
  `ID_COURS` int(11) NOT NULL,
  `TYPE_COURS` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`ID_COURS`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `equipements`
--

DROP TABLE IF EXISTS `equipements`;
CREATE TABLE IF NOT EXISTS `equipements` (
  `ID_EQUIPEMENT` int(11) NOT NULL,
  `TYPE_EQUIPEMENT` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`ID_EQUIPEMENT`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `reserver`
--

DROP TABLE IF EXISTS `reserver`;
CREATE TABLE IF NOT EXISTS `reserver` (
  `ID_USER` int(11) NOT NULL,
  `ID_EQUIPEMENT` int(11) NOT NULL,
  `ID_COURS` int(11) NOT NULL,
  `DATE` date DEFAULT NULL,
  `HEURE_DEBUT` time DEFAULT NULL,
  `HEURE_FIN` time DEFAULT NULL,
  PRIMARY KEY (`ID_USER`,`ID_EQUIPEMENT`,`ID_COURS`),
  KEY `FK_RESERVER2` (`ID_EQUIPEMENT`),
  KEY `FK_RESERVER3` (`ID_COURS`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `salles`
--

DROP TABLE IF EXISTS `salles`;
CREATE TABLE IF NOT EXISTS `salles` (
  `ID_SALLE` int(11) NOT NULL,
  `ID_TYPE_SALLE` char(1) NOT NULL,
  `NOM_SALLE` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`ID_SALLE`),
  KEY `FK_ASSOCIATION_4` (`ID_TYPE_SALLE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `type_salle`
--

DROP TABLE IF EXISTS `type_salle`;
CREATE TABLE IF NOT EXISTS `type_salle` (
  `ID_TYPE_SALLE` char(1) NOT NULL,
  `LIBELLE_TYPE_SALLE` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`ID_TYPE_SALLE`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `type_user`
--

DROP TABLE IF EXISTS `type_user`;
CREATE TABLE IF NOT EXISTS `type_user` (
  `ID_TYPE_USER` char(1) NOT NULL,
  `LIBELLE_TYPE_USER` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`ID_TYPE_USER`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `ID_USER` int(11) NOT NULL,
  `ID_SALLE` int(11) NOT NULL,
  `ID_TYPE_USER` char(1) NOT NULL,
  `NOM_USER` varchar(25) DEFAULT NULL,
  `PRENOM_USER` varchar(25) DEFAULT NULL,
  `GENRE_USER` char(1) DEFAULT NULL,
  `IDENTIFIANT_USER` varchar(50) NOT NULL,
  `PSWD` varchar(255) NOT NULL,
  PRIMARY KEY (`ID_USER`),
  UNIQUE KEY `IDENTIFIANT_USER` (`IDENTIFIANT_USER`),
  KEY `FK_ASSOCIATION_2` (`ID_TYPE_USER`),
  KEY `FK_ASSOCIATION_3` (`ID_SALLE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`ID_USER`, `ID_SALLE`, `ID_TYPE_USER`, `NOM_USER`, `PRENOM_USER`, `GENRE_USER`, `IDENTIFIANT_USER`, `PSWD`) VALUES
(1, 1, 'A', 'MBOUMBA', 'Reine', 'F', 'M.Reine', '123456'),
(2, 1, 'B', 'MENSIER', 'Enzo', 'M', 'M.Enzo', '1234'),
(3, 2, 'A', 'DOLIUM', 'Mael', 'M', 'D.Mael', '12345');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
