TRUNCATE `adresse`;
TRUNCATE `article`;
TRUNCATE `client`;
TRUNCATE `commande`;
TRUNCATE `composition`;
TRUNCATE `cuisinier`;
TRUNCATE `employe`;
TRUNCATE `etablissement`;
TRUNCATE `facture`;
TRUNCATE `ingredient`;
TRUNCATE `livreur`;
TRUNCATE `pizza`;
TRUNCATE `recette`;
TRUNCATE `stock`;
TRUNCATE `variante`;
TRUNCATE `variante_article`;

INSERT INTO client (nom, prenom, raison_sociale, id_destinataire) 
					VALUES ("Zaraki", "Kenpachi", NULL, 1), ("Monkey.D", "Luffy", NULL, 2), 
					       (NULL, NULL, "CP9", 3);
					
INSERT INTO employe (nom, prenom)
					VALUES ("Joe", "Dalton"), ("William", "Dalton"), ("Jack", "Dalton"), 
					       ("Averell", "Dalton");
					
INSERT INTO livreur (id_employe_livreur, immatriculation, id_etablissement) 
					VALUES (4, "AA-123-AA", 1);
					
INSERT INTO cuisinier (id_employe, id_etablissement) 
					VALUES (2, 1);

INSERT INTO etablissement (nom, adresse) 
				    VALUES ("OC Pizza North", "Swallow Island, 13000, North Blue"), 
			     	       ("OC Pizza East", "Baratie, 75018, East Blue"), 
						   ("OC Pizza Grandline", "Alabasta, 94500, Grandline"), 
						   ("OC Pizza New", "Dressrosa, 94510, New World");
			   										
INSERT INTO adresse (id_destinataire, numero_client, voie, numero_voie, code_postal, localite, commentaire)
					VALUES (1, 2, NULL, NULL, 75001, "Village de Fuchsia", NULL),
						   (2, 1, NULL, NULL, 11000, "Soul Society", NULL),
						   (3, 3, NULL, NULL, 94510, "Enies Lobby", NULL);

INSERT INTO pizza (nom, taille, prix_ttc)
					VALUES ('Classique', 'Junior', 6.00), ('Regina', 'Junior', 8.00), ('Campione', 'Junior', 8.00), ('Torino', 'Junior', 8.00), 
						   ('Orientale', 'Junior', 8.00), ('Napolitaine', 'Junior', 8.00), ('Vegetarienne', 'Junior', 8.00),
						   ('Classique', 'Senior', 8.50), ('Regina', 'Senior', 12.00), ('Campione', 'Senior', 12.00), ('Torino', 'Senior', 12.00), 
						   ('Orientale', 'Senior', 12.00), ('Napolitaine', 'Senior', 12.00), ('Vegetarienne', 'Senior', 12.00),
						   ('Classique', 'Familiale', 12.50), ('Regina', 'Familiale', 16.00), ('Campione', 'Familiale', 16.00), ('Torino', 'Familiale', 16.00), 
						   ('Orientale', 'Familiale', 16.00), ('Napolitaine', 'Familiale', 16.00), ('Vegetarienne', 'Familiale', 16.00);	
			   			   
INSERT INTO ingredient (nom, unite) 
				    VALUES ('Tomate', "cuillère"), ('Double fromage', "40 grammes"), ('Origan', "pincée"), ('Champignon', "entier"), 
						   ('Jambon', "une tranche"), ('Olive noire', "entiere"), ("origan", "une pincée"), ('Viande hachée', "50 grammes"), ('Oeuf', "entier"), 
						   ('Thon', "50 grammes"), ('Poivrons', "entier"), ('Merguez', "entière"), ('Anchois', "10 grammes"), 
						   ('Câpres', "10 grammes"),('Oignon', "1 demi"), ('Pomme de terre', "entier"), ('Artichaut', "30 grammes");


					
INSERT INTO recette (id_pizza, commentaire) 
					VALUES ( 1, NULL), (2, NULL);
					
INSERT INTO article (nom, descriptif, prix_ttc)
					VALUES ("Coca cola 33cl", NULL, 1.30), ("Sprite 33cl", NULL, 1.30), 
						   ("Tarte aux pommes", NULL, 2.20), ("Brownie", NULL, 2.20),
						   ("Glace Haagen_dazs", "pot de 150ml", 3.50);
						   
INSERT INTO stock (id_etablissement, reference_article, quantite) 
					VALUES (1, 1, 200), (1, 2, 200), (1, 3, 50), (1, 4, 100), 
						   (1, 5, 100);								   
						   
INSERT INTO stock (id_etablissement, id_ingredient, quantite) 
					VALUES ( 1, 1, 100), ( 1, 2, 1000), ( 1, 3, 1000), ( 1, 4, 500),
						   ( 1, 5, 500), ( 1, 6, 10000), ( 1, 7, 1000), ( 1, 8, 1000);	
						   
INSERT INTO composition (id_pizza, id_ingredient, quantite_unite) 
					VALUES (1, 1, 2), (1, 2, 1), (1, 3, 1), (2, 1, 2), (2, 2, 1), (2, 4, 1), (2, 5, 1), (2, 6, 5), (2, 7, 2);	

INSERT INTO commande(numero_client_id, date, online, status, id_employe_cuisinier, id_employe, id_employe_livreur, id_variante, id_variante_article) 
					VALUES (1, NOW(), 1, "expédiée", 2 ,3 , 1, 1, 1);
					
INSERT INTO variante (numero_commande, quantite_pizza, id_pizza) 
					VALUES (1, 1, 19);					

INSERT INTO variante_article (numero_commande, quantite_article, reference_article) 
					VALUES (1, 1, 1), (1, 1, 2), (1, 2, 3);			

INSERT INTO facture (date, numero_commande, prix_total_ttc) 
					VALUES (NOW(), 1, 23);								
					
					
					
					   
						   

	
						   

					
					
					
					
					
					
					
					