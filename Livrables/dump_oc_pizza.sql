-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  ven. 16 nov. 2018 à 22:49
-- Version du serveur :  5.7.21
-- Version de PHP :  5.6.35

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `oc_pizza`
--
CREATE DATABASE IF NOT EXISTS `oc_pizza` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `oc_pizza`;

-- --------------------------------------------------------

--
-- Structure de la table `adresse`
--

DROP TABLE IF EXISTS `adresse`;
CREATE TABLE IF NOT EXISTS `adresse` (
  `id_destinataire` int(11) NOT NULL AUTO_INCREMENT,
  `numero_client` int(11) NOT NULL,
  `voie` varchar(40) DEFAULT NULL,
  `complement_voie` varchar(40) DEFAULT NULL,
  `numero_voie` int(11) DEFAULT NULL,
  `code_postal` varchar(5) NOT NULL,
  `localite` varchar(40) NOT NULL,
  `commentaire` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id_destinataire`,`numero_client`),
  KEY `client_adresse_fk` (`numero_client`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `adresse`
--

INSERT INTO `adresse` (`id_destinataire`, `numero_client`, `voie`, `complement_voie`, `numero_voie`, `code_postal`, `localite`, `commentaire`) VALUES
(1, 1, NULL, NULL, NULL, '75001', 'Village de Fuchsia', NULL),
(2, 2, NULL, NULL, NULL, '11000', 'Soul Society', NULL),
(3, 3, NULL, NULL, NULL, '94510', 'Enies Lobby', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `article`
--

DROP TABLE IF EXISTS `article`;
CREATE TABLE IF NOT EXISTS `article` (
  `reference` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(30) NOT NULL,
  `descriptif` varchar(150) DEFAULT NULL,
  `prix_ttc` decimal(5,2) NOT NULL,
  PRIMARY KEY (`reference`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `article`
--

INSERT INTO `article` (`reference`, `nom`, `descriptif`, `prix_ttc`) VALUES
(1, 'Coca cola 33cl', NULL, '1.30'),
(2, 'Sprite 33cl', NULL, '1.30'),
(3, 'Tarte aux pommes', NULL, '2.20'),
(4, 'Brownie', NULL, '2.20'),
(5, 'Glace Haagen_dazs', 'pot de 150ml', '3.50');

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

DROP TABLE IF EXISTS `client`;
CREATE TABLE IF NOT EXISTS `client` (
  `numero_client` int(11) NOT NULL AUTO_INCREMENT,
  `telephone` int(11) NOT NULL,
  `nom` varchar(30) DEFAULT NULL,
  `prenom` varchar(30) DEFAULT NULL,
  `raison_sociale` varchar(30) DEFAULT NULL,
  `id_destinataire` int(11) NOT NULL,
  PRIMARY KEY (`numero_client`),
  KEY `adresse_client_fk` (`id_destinataire`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `client`
--

INSERT INTO `client` (`numero_client`, `telephone`, `nom`, `prenom`, `raison_sociale`, `id_destinataire`) VALUES
(1, 607080910, ' Monkey.D', 'Luffy', NULL, 1),
(2, 611121314, 'Kenpachi', 'Zaraki', NULL, 2),
(3, 148800901, NULL, NULL, 'CP9', 3);

-- --------------------------------------------------------

--
-- Structure de la table `commande`
--

DROP TABLE IF EXISTS `commande`;
CREATE TABLE IF NOT EXISTS `commande` (
  `numero_commande` int(11) NOT NULL AUTO_INCREMENT,
  `numero_client_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `online` tinyint(1) NOT NULL,
  `status` varchar(30) DEFAULT NULL,
  `id_employe_cuisinier` int(11) NOT NULL,
  `id_employe` int(11) NOT NULL,
  `id_employe_livreur` int(11) NOT NULL,
  `id_variante` int(11) DEFAULT NULL,
  `id_variante_article` int(11) DEFAULT NULL,
  PRIMARY KEY (`numero_commande`),
  KEY `employe_commande_fk` (`id_employe`),
  KEY `cuisinier_commande_fk` (`id_employe_cuisinier`),
  KEY `livreur_commande_fk` (`id_employe_livreur`),
  KEY `client_commande_fk` (`numero_client_id`),
  KEY `variante_commande_fk` (`id_variante`),
  KEY `variante_article_commande_fk` (`id_variante_article`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `commande`
--

INSERT INTO `commande` (`numero_commande`, `numero_client_id`, `date`, `online`, `status`, `id_employe_cuisinier`, `id_employe`, `id_employe_livreur`, `id_variante`, `id_variante_article`) VALUES
(1, 1, '2018-11-16 23:45:53', 1, 'expédiée', 2, 3, 1, 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `composition`
--

DROP TABLE IF EXISTS `composition`;
CREATE TABLE IF NOT EXISTS `composition` (
  `id_ingredient` int(11) NOT NULL,
  `id_pizza` int(11) NOT NULL,
  `quantite_unite` int(11) NOT NULL,
  PRIMARY KEY (`id_ingredient`,`id_pizza`),
  KEY `recette_composition_fk` (`id_pizza`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `composition`
--

INSERT INTO `composition` (`id_ingredient`, `id_pizza`, `quantite_unite`) VALUES
(1, 1, 2),
(2, 1, 1),
(3, 1, 1),
(1, 2, 2),
(2, 2, 1),
(4, 2, 1),
(5, 2, 1),
(6, 2, 5),
(7, 2, 2);

-- --------------------------------------------------------

--
-- Structure de la table `cuisinier`
--

DROP TABLE IF EXISTS `cuisinier`;
CREATE TABLE IF NOT EXISTS `cuisinier` (
  `id_employe` int(11) NOT NULL,
  `id_etablissement` int(11) NOT NULL,
  PRIMARY KEY (`id_employe`),
  KEY `etablissement_cuisinier_fk` (`id_etablissement`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `cuisinier`
--

INSERT INTO `cuisinier` (`id_employe`, `id_etablissement`) VALUES
(2, 1);

-- --------------------------------------------------------

--
-- Structure de la table `employe`
--

DROP TABLE IF EXISTS `employe`;
CREATE TABLE IF NOT EXISTS `employe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(30) NOT NULL,
  `prenom` varchar(30) NOT NULL,
  `nom_etablissement` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `employe`
--

INSERT INTO `employe` (`id`, `nom`, `prenom`, `nom_etablissement`) VALUES
(1, 'Dalton', 'Joe', ''),
(2, 'Dalton', 'William', ''),
(3, 'Dalton', 'Jack', ''),
(4, 'Dalton', 'Averell', '');

-- --------------------------------------------------------

--
-- Structure de la table `etablissement`
--

DROP TABLE IF EXISTS `etablissement`;
CREATE TABLE IF NOT EXISTS `etablissement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(30) NOT NULL,
  `adresse` varchar(150) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `etablissement`
--

INSERT INTO `etablissement` (`id`, `nom`, `adresse`) VALUES
(1, 'OC Pizza North', 'Swallow Island, 13000, North Blue'),
(2, 'OC Pizza East', 'Baratie, 75018, East Blue'),
(3, 'OC Pizza Grandline', 'Alabasta, 94500, Grandline'),
(4, 'OC Pizza New', 'Dressrosa, 94510, New World');

-- --------------------------------------------------------

--
-- Structure de la table `facture`
--

DROP TABLE IF EXISTS `facture`;
CREATE TABLE IF NOT EXISTS `facture` (
  `numero_facture` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `numero_commande` int(11) NOT NULL,
  `prix_total_ttc` decimal(5,2) NOT NULL,
  PRIMARY KEY (`numero_facture`),
  KEY `commande_facture_fk` (`numero_commande`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `facture`
--

INSERT INTO `facture` (`numero_facture`, `date`, `numero_commande`, `prix_total_ttc`) VALUES
(1, '2018-11-16 23:45:53', 1, '23.00');

-- --------------------------------------------------------

--
-- Structure de la table `ingredient`
--

DROP TABLE IF EXISTS `ingredient`;
CREATE TABLE IF NOT EXISTS `ingredient` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(30) NOT NULL,
  `unite` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `ingredient`
--

INSERT INTO `ingredient` (`id`, `nom`, `unite`) VALUES
(1, 'Tomate', 'cuillère'),
(2, 'Double fromage', '40 grammes'),
(3, 'Origan', 'pincée'),
(4, 'Champignon', 'entier'),
(5, 'Jambon', 'une tranche'),
(6, 'Olive noire', 'entiere'),
(7, 'origan', 'une pincée'),
(8, 'Viande hachée', '50 grammes'),
(9, 'Oeuf', 'entier'),
(10, 'Thon', '50 grammes'),
(11, 'Poivrons', 'entier'),
(12, 'Merguez', 'entière'),
(13, 'Anchois', '10 grammes'),
(14, 'Câpres', '10 grammes'),
(15, 'Oignon', '1 demi'),
(16, 'Pomme de terre', 'entier'),
(17, 'Artichaut', '30 grammes');

-- --------------------------------------------------------

--
-- Structure de la table `livreur`
--

DROP TABLE IF EXISTS `livreur`;
CREATE TABLE IF NOT EXISTS `livreur` (
  `id_employe_livreur` int(11) NOT NULL,
  `immatriculation` varchar(9) NOT NULL,
  `id_etablissement` int(11) NOT NULL,
  PRIMARY KEY (`id_employe_livreur`),
  KEY `etablissement_livreur_fk` (`id_etablissement`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `livreur`
--

INSERT INTO `livreur` (`id_employe_livreur`, `immatriculation`, `id_etablissement`) VALUES
(4, 'AA-123-AA', 1);

-- --------------------------------------------------------

--
-- Structure de la table `pizza`
--

DROP TABLE IF EXISTS `pizza`;
CREATE TABLE IF NOT EXISTS `pizza` (
  `id_pizza` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(30) NOT NULL,
  `taille` varchar(10) NOT NULL,
  `prix_ttc` decimal(5,2) NOT NULL,
  PRIMARY KEY (`id_pizza`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `pizza`
--

INSERT INTO `pizza` (`id_pizza`, `nom`, `taille`, `prix_ttc`) VALUES
(1, 'Classique', 'Junior', '6.00'),
(2, 'Regina', 'Junior', '8.00'),
(3, 'Campione', 'Junior', '8.00'),
(4, 'Torino', 'Junior', '8.00'),
(5, 'Orientale', 'Junior', '8.00'),
(6, 'Napolitaine', 'Junior', '8.00'),
(7, 'Vegetarienne', 'Junior', '8.00'),
(8, 'Classique', 'Senior', '8.50'),
(9, 'Regina', 'Senior', '12.00'),
(10, 'Campione', 'Senior', '12.00'),
(11, 'Torino', 'Senior', '12.00'),
(12, 'Orientale', 'Senior', '12.00'),
(13, 'Napolitaine', 'Senior', '12.00'),
(14, 'Vegetarienne', 'Senior', '12.00'),
(15, 'Classique', 'Familiale', '12.50'),
(16, 'Regina', 'Familiale', '16.00'),
(17, 'Campione', 'Familiale', '16.00'),
(18, 'Torino', 'Familiale', '16.00'),
(19, 'Orientale', 'Familiale', '16.00'),
(20, 'Napolitaine', 'Familiale', '16.00'),
(21, 'Vegetarienne', 'Familiale', '16.00');

-- --------------------------------------------------------

--
-- Structure de la table `recette`
--

DROP TABLE IF EXISTS `recette`;
CREATE TABLE IF NOT EXISTS `recette` (
  `id_pizza` int(11) NOT NULL AUTO_INCREMENT,
  `commentaire` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_pizza`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `recette`
--

INSERT INTO `recette` (`id_pizza`, `commentaire`) VALUES
(1, NULL),
(2, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `stock`
--

DROP TABLE IF EXISTS `stock`;
CREATE TABLE IF NOT EXISTS `stock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_etablissement` int(11) NOT NULL,
  `reference_article` int(11) NOT NULL DEFAULT '0',
  `id_ingredient` int(11) NOT NULL DEFAULT '0',
  `quantite` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`,`id_etablissement`),
  KEY `ingredient_stock_fk` (`id_ingredient`),
  KEY `article_stock_fk` (`reference_article`),
  KEY `etablissement_stock_fk` (`id_etablissement`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `stock`
--

INSERT INTO `stock` (`id`, `id_etablissement`, `reference_article`, `id_ingredient`, `quantite`) VALUES
(1, 1, 1, 0, 200),
(2, 1, 2, 0, 200),
(3, 1, 3, 0, 50),
(4, 1, 4, 0, 100),
(5, 1, 5, 0, 100),
(6, 1, 0, 1, 100),
(7, 1, 0, 2, 1000),
(8, 1, 0, 3, 1000),
(9, 1, 0, 4, 500),
(10, 1, 0, 5, 500),
(11, 1, 0, 6, 10000),
(12, 1, 0, 7, 1000),
(13, 1, 0, 8, 1000);

-- --------------------------------------------------------

--
-- Structure de la table `variante`
--

DROP TABLE IF EXISTS `variante`;
CREATE TABLE IF NOT EXISTS `variante` (
  `id_variante` int(11) NOT NULL AUTO_INCREMENT,
  `numero_commande` int(11) NOT NULL,
  `quantite_pizza` int(11) NOT NULL,
  `id_pizza` int(11) NOT NULL,
  PRIMARY KEY (`id_variante`,`numero_commande`),
  KEY `pizza_variante_fk` (`id_pizza`),
  KEY `commande_variante_fk` (`numero_commande`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `variante`
--

INSERT INTO `variante` (`id_variante`, `numero_commande`, `quantite_pizza`, `id_pizza`) VALUES
(1, 1, 1, 19);

-- --------------------------------------------------------

--
-- Structure de la table `variante_article`
--

DROP TABLE IF EXISTS `variante_article`;
CREATE TABLE IF NOT EXISTS `variante_article` (
  `id_variante_article` int(11) NOT NULL AUTO_INCREMENT,
  `numero_commande` int(11) NOT NULL,
  `quantite_article` int(11) NOT NULL DEFAULT '0',
  `reference_article` int(11) NOT NULL,
  PRIMARY KEY (`id_variante_article`,`numero_commande`),
  KEY `article_quantite_article_fk` (`reference_article`),
  KEY `commande_variante_article_fk` (`numero_commande`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `variante_article`
--

INSERT INTO `variante_article` (`id_variante_article`, `numero_commande`, `quantite_article`, `reference_article`) VALUES
(1, 1, 1, 1),
(2, 1, 1, 2),
(3, 1, 2, 3);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
