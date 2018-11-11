DROP DATABASE IF EXISTS oc_pizza;

CREATE DATABASE oc_pizza CHARACTER SET 'utf8';

USE oc_pizza;

CREATE TABLE ingredient (
                id INT AUTO_INCREMENT NOT NULL,
                nom VARCHAR(30) NOT NULL,
                unite VARCHAR(30) NOT NULL,
                PRIMARY KEY (id)
);


CREATE TABLE article (
                reference INT AUTO_INCREMENT NOT NULL,
                nom VARCHAR(30) NOT NULL,
                descriptif VARCHAR(150),
                prix_ttc DECIMAL(5,2) NOT NULL,
                PRIMARY KEY (reference)
);


CREATE TABLE pizza (
                id_pizza INT AUTO_INCREMENT NOT NULL,
                nom VARCHAR(30) NOT NULL,
                taille VARCHAR(10) NOT NULL,
                prix_ttc DECIMAL(5,2) NOT NULL,
                PRIMARY KEY (id_pizza)
);


CREATE TABLE recette (
                id_pizza INT AUTO_INCREMENT NOT NULL,
                commentaire VARCHAR(30),
                PRIMARY KEY (id_pizza)
);


CREATE TABLE composition (
                id_ingredient INT NOT NULL,
                id_pizza INT NOT NULL,
                quantite_unite INT NOT NULL,
                PRIMARY KEY (id_ingredient, id_pizza)
);


CREATE TABLE etablissement (
                id INT AUTO_INCREMENT NOT NULL,
                nom VARCHAR(30) NOT NULL,
                adresse VARCHAR(150) NOT NULL,
                PRIMARY KEY (id)
);


CREATE TABLE stock (
                id INT AUTO_INCREMENT NOT NULL,
                id_etablissement INT NOT NULL,
                reference_article INT DEFAULT 0 NOT NULL,
                id_ingredient INT DEFAULT 0 NOT NULL,
                quantite INT,
                PRIMARY KEY (id, id_etablissement)
);


CREATE TABLE employe (
                id INT AUTO_INCREMENT NOT NULL,
                nom VARCHAR(30) NOT NULL,
                prenom VARCHAR(30) NOT NULL,
                nom_etablissement VARCHAR(30) NOT NULL,
                PRIMARY KEY (id)
);


CREATE TABLE cuisinier (
                id_employe INT NOT NULL,
                id_etablissement INT NOT NULL,
                PRIMARY KEY (id_employe)
);


CREATE TABLE livreur (
                id_employe_livreur INT NOT NULL,
                immatriculation VARCHAR(9) NOT NULL,
                id_etablissement INT NOT NULL,
                PRIMARY KEY (id_employe_livreur)
);


CREATE TABLE client (
                numero_client INT AUTO_INCREMENT NOT NULL,
                nom VARCHAR(30),
                prenom VARCHAR(30),
                raison_sociale VARCHAR(30),
                id_destinataire INT NOT NULL,
                PRIMARY KEY (numero_client)
);


CREATE TABLE adresse (
                id_destinataire INT AUTO_INCREMENT NOT NULL,
                numero_client INT NOT NULL,
                voie VARCHAR(40),
                complement_voie VARCHAR(40),
                numero_voie INT,
                code_postal VARCHAR(5) NOT NULL,
                localite VARCHAR(40) NOT NULL,
                commentaire VARCHAR(150),
                PRIMARY KEY (id_destinataire, numero_client)
);


CREATE TABLE commande (
                numero_commande INT AUTO_INCREMENT NOT NULL,
                numero_client_id INT NOT NULL,
                date DATETIME NOT NULL,
                online BOOLEAN NOT NULL,
                status VARCHAR(30),
                id_employe_cuisinier INT NOT NULL,
                id_employe INT NOT NULL,
                id_employe_livreur INT NOT NULL,
                id_variante INT,
                id_variante_article INT,
                PRIMARY KEY (numero_commande)
);


CREATE TABLE variante (
                id_variante INT AUTO_INCREMENT NOT NULL,
                numero_commande INT NOT NULL,
                quantite_pizza INT NOT NULL,
                id_pizza INT NOT NULL,
                PRIMARY KEY (id_variante, numero_commande)
);


CREATE TABLE variante_article (
                id_variante_article INT AUTO_INCREMENT NOT NULL,
                numero_commande INT NOT NULL,
                quantite_article INT DEFAULT 0 NOT NULL,
                reference_article INT NOT NULL,
                PRIMARY KEY (id_variante_article, numero_commande)
);


CREATE TABLE facture (
                numero_facture INT AUTO_INCREMENT NOT NULL,
                date DATETIME NOT NULL,
                numero_commande INT NOT NULL,
                prix_total_ttc DECIMAL(5,2) NOT NULL,
                PRIMARY KEY (numero_facture)
);


ALTER TABLE stock ADD CONSTRAINT ingredient_stock_fk
FOREIGN KEY (id_ingredient)
REFERENCES ingredient (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE composition ADD CONSTRAINT ingredient_composition_fk
FOREIGN KEY (id_ingredient)
REFERENCES ingredient (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE stock ADD CONSTRAINT article_stock_fk
FOREIGN KEY (reference_article)
REFERENCES article (reference)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE variante_article ADD CONSTRAINT article_quantite_article_fk
FOREIGN KEY (reference_article)
REFERENCES article (reference)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE recette ADD CONSTRAINT pizza_recette_fk
FOREIGN KEY (id_pizza)
REFERENCES pizza (id_pizza)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE variante ADD CONSTRAINT pizza_variante_fk
FOREIGN KEY (id_pizza)
REFERENCES pizza (id_pizza)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE composition ADD CONSTRAINT recette_composition_fk
FOREIGN KEY (id_pizza)
REFERENCES recette (id_pizza)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE cuisinier ADD CONSTRAINT etablissement_cuisinier_fk
FOREIGN KEY (id_etablissement)
REFERENCES etablissement (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE employe ADD CONSTRAINT etablissement_employe_fk
FOREIGN KEY (id)
REFERENCES etablissement (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE livreur ADD CONSTRAINT etablissement_livreur_fk
FOREIGN KEY (id_etablissement)
REFERENCES etablissement (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE stock ADD CONSTRAINT etablissement_stock_fk
FOREIGN KEY (id_etablissement)
REFERENCES etablissement (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE livreur ADD CONSTRAINT employe_livreur_fk
FOREIGN KEY (id_employe_livreur)
REFERENCES employe (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE cuisinier ADD CONSTRAINT employe_cuisinier_fk
FOREIGN KEY (id_employe)
REFERENCES employe (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE commande ADD CONSTRAINT employe_commande_fk
FOREIGN KEY (id_employe)
REFERENCES employe (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE commande ADD CONSTRAINT cuisinier_commande_fk
FOREIGN KEY (id_employe_cuisinier)
REFERENCES cuisinier (id_employe)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE commande ADD CONSTRAINT livreur_commande_fk
FOREIGN KEY (id_employe_livreur)
REFERENCES livreur (id_employe_livreur)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE commande ADD CONSTRAINT client_commande_fk
FOREIGN KEY (numero_client_id)
REFERENCES client (numero_client)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE adresse ADD CONSTRAINT client_adresse_fk
FOREIGN KEY (numero_client)
REFERENCES client (numero_client)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE client ADD CONSTRAINT adresse_client_fk
FOREIGN KEY (id_destinataire)
REFERENCES adresse (id_destinataire)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE facture ADD CONSTRAINT commande_facture_fk
FOREIGN KEY (numero_commande)
REFERENCES commande (numero_commande)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE variante_article ADD CONSTRAINT commande_variante_article_fk
FOREIGN KEY (numero_commande)
REFERENCES commande (numero_commande)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE variante ADD CONSTRAINT commande_variante_fk
FOREIGN KEY (numero_commande)
REFERENCES commande (numero_commande)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE commande ADD CONSTRAINT variante_commande_fk
FOREIGN KEY (id_variante)
REFERENCES variante (id_variante)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE commande ADD CONSTRAINT variante_article_commande_fk
FOREIGN KEY (id_variante_article)
REFERENCES variante_article (id_variante_article)
ON DELETE NO ACTION
ON UPDATE NO ACTION;