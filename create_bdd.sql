
CREATE TABLE ingredient (
                id INT NOT NULL,
                nom VARCHAR(30) NOT NULL,
                quantite INT NOT NULL,
                PRIMARY KEY (id)
);


CREATE TABLE pizza (
                nom VARCHAR(30) NOT NULL,
                PRIMARY KEY (nom)
);


CREATE TABLE recette (
                nom_pizza_id VARCHAR(30) NOT NULL,
                id_ingredient INT NOT NULL,
                quantite INT NOT NULL,
                PRIMARY KEY (nom_pizza_id)
);


CREATE TABLE variante (
                id INT AUTO_INCREMENT NOT NULL,
                taille VARCHAR(9) NOT NULL,
                quantite INT NOT NULL,
                prix_ttc DECIMAL NOT NULL,
                nom_pizza VARCHAR(30) NOT NULL,
                PRIMARY KEY (id)
);


CREATE TABLE employe (
                id INT AUTO_INCREMENT NOT NULL,
                nom VARCHAR(30) NOT NULL,
                prenom VARCHAR(30) NOT NULL,
                PRIMARY KEY (id)
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


CREATE TABLE etablissement (
                nom VARCHAR(30) NOT NULL,
                id_employe INT NOT NULL,
                id_destinataire INT NOT NULL,
                PRIMARY KEY (nom)
);


CREATE TABLE cuisinier (
                id_cuisinier INT NOT NULL,
                nom_etablissement VARCHAR(30) NOT NULL,
                PRIMARY KEY (id_cuisinier)
);


CREATE TABLE livreur (
                id_livreur INT NOT NULL,
                immatriculation VARCHAR(9) NOT NULL,
                nom_etablissement VARCHAR(30) NOT NULL,
                PRIMARY KEY (id_livreur)
);


CREATE TABLE commande (
                numero_commande INT AUTO_INCREMENT NOT NULL,
                numero_client_id INT NOT NULL,
                date DATETIME NOT NULL,
                online BOOLEAN NOT NULL,
                status VARCHAR(30) NOT NULL,
                id_variante INT NOT NULL,
                id_cuisinier INT NOT NULL,
                id_livreur INT NOT NULL,
                id_employe INT NOT NULL,
                PRIMARY KEY (numero_commande, numero_client_id)
);


CREATE TABLE article (
                reference VARCHAR(10) NOT NULL,
                nom VARCHAR(30) NOT NULL,
                descriptif VARCHAR(150),
                prix_ttc DECIMAL NOT NULL,
                quantite INT NOT NULL,
                numero_commande INT NOT NULL,
                numero_client_id INT NOT NULL,
                PRIMARY KEY (reference)
);


CREATE TABLE stock (
                nom_etablissement_id VARCHAR(30) NOT NULL,
                id_ingredient INT NOT NULL,
                quantite INT NOT NULL,
                reference VARCHAR(10) NOT NULL,
                PRIMARY KEY (nom_etablissement_id)
);


CREATE TABLE facture (
                numero_facture INT AUTO_INCREMENT NOT NULL,
                date DATETIME NOT NULL,
                numero_commande INT NOT NULL,
                numero_client_id INT NOT NULL,
                PRIMARY KEY (numero_facture)
);


ALTER TABLE recette ADD CONSTRAINT ingredient_recette_fk
FOREIGN KEY (id_ingredient)
REFERENCES ingredient (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE stock ADD CONSTRAINT ingredient_stock_fk
FOREIGN KEY (id_ingredient)
REFERENCES ingredient (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE recette ADD CONSTRAINT pizza_recette_fk
FOREIGN KEY (nom_pizza_id)
REFERENCES pizza (nom)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE variante ADD CONSTRAINT pizza_variante_fk
FOREIGN KEY (nom_pizza)
REFERENCES pizza (nom)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE commande ADD CONSTRAINT variante_commande_fk
FOREIGN KEY (id_variante)
REFERENCES variante (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE livreur ADD CONSTRAINT employe_livreur_fk
FOREIGN KEY (id_livreur)
REFERENCES employe (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE cuisinier ADD CONSTRAINT employe_cuisinier_fk
FOREIGN KEY (id_cuisinier)
REFERENCES employe (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE etablissement ADD CONSTRAINT employe_etablissement_fk
FOREIGN KEY (id_employe)
REFERENCES employe (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE commande ADD CONSTRAINT employe_commande_fk
FOREIGN KEY (id_employe)
REFERENCES employe (id)
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

ALTER TABLE etablissement ADD CONSTRAINT adresse_etablissement_fk
FOREIGN KEY (id_destinataire)
REFERENCES adresse (id_destinataire)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE stock ADD CONSTRAINT etablissement_stock_fk
FOREIGN KEY (nom_etablissement_id)
REFERENCES etablissement (nom)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE livreur ADD CONSTRAINT etablissement_livreur_fk
FOREIGN KEY (nom_etablissement)
REFERENCES etablissement (nom)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE cuisinier ADD CONSTRAINT etablissement_cuisinier_fk
FOREIGN KEY (nom_etablissement)
REFERENCES etablissement (nom)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE commande ADD CONSTRAINT cuisinier_commande_fk
FOREIGN KEY (id_cuisinier)
REFERENCES cuisinier (id_cuisinier)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE commande ADD CONSTRAINT livreur_commande_fk
FOREIGN KEY (id_livreur)
REFERENCES livreur (id_livreur)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE facture ADD CONSTRAINT commande_facture_fk
FOREIGN KEY (numero_commande, numero_client_id)
REFERENCES commande (numero_commande, numero_client_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE article ADD CONSTRAINT commande_article_fk
FOREIGN KEY (numero_commande, numero_client_id)
REFERENCES commande (numero_commande, numero_client_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE stock ADD CONSTRAINT article_stock_fk
FOREIGN KEY (reference)
REFERENCES article (reference)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
