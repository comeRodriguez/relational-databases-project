DROP TABLE IF EXISTS livreAuteur CASCADE;
DROP TABLE IF EXISTS filmRealisateur CASCADE;
DROP TABLE IF EXISTS filmActeur CASCADE;
DROP TABLE IF EXISTS enregistrementInterprete CASCADE;
DROP TABLE IF EXISTS enregistrementCompositeur CASCADE;
DROP TABLE IF EXISTS exemplairePret CASCADE;
DROP TABLE IF EXISTS deterioration CASCADE;
DROP TABLE IF EXISTS exemplaire CASCADE;
DROP TABLE IF EXISTS pret CASCADE;
DROP TABLE IF EXISTS livre CASCADE;
DROP TABLE IF EXISTS enregistrement CASCADE;
DROP TABLE IF EXISTS film CASCADE;
DROP TABLE IF EXISTS ressource CASCADE;
DROP TABLE IF EXISTS acteur CASCADE;
DROP TABLE IF EXISTS realisateur CASCADE;
DROP TABLE IF EXISTS auteur CASCADE;
DROP TABLE IF EXISTS interprete CASCADE;
DROP TABLE IF EXISTS compositeur CASCADE;
DROP TABLE IF EXISTS personnel CASCADE;
DROP TABLE IF EXISTS adherent CASCADE;
DROP TABLE IF EXISTS compte CASCADE;
DROP TABLE IF EXISTS  contributeur CASCADE;


CREATE TABLE contributeur(
idContributeur SERIAL PRIMARY KEY,
nom VARCHAR NOT NULL,
prenom VARCHAR NOT NULL,
ddn DATE,
adresse VARCHAR,
email VARCHAR,
telephone VARCHAR,
nationalite VARCHAR
);

CREATE TABLE adherent (
idAdherent SERIAL PRIMARY KEY,
nom VARCHAR NOT NULL,
prenom VARCHAR NOT NULL,
ddn DATE NOT NULL,
adresse VARCHAR,
email VARCHAR,
telephone VARCHAR,
        adherentActif boolean NOT NULL DEFAULT TRUE,
        carte_adherent VARCHAR NOT NULL,
        blacklist boolean NOT NULL DEFAULT FALSE
);

CREATE TABLE personnel (
      idPersonnel SERIAL PRIMARY KEY,
nom VARCHAR NOT NULL,
prenom VARCHAR NOT NULL,
ddn DATE NOT NULL,
adresse VARCHAR,
email VARCHAR,
telephone VARCHAR
);

CREATE TABLE compte (
        login varchar(30) PRIMARY KEY,
        motDePasse varchar(30) NOT NULL,
        adherent INTEGER,
        personnel INTEGER,
        CHECK (adherent IS NOT NULL OR personnel IS NOT NULL),
        FOREIGN KEY (adherent) REFERENCES adherent(idAdherent),
        FOREIGN KEY (personnel) REFERENCES personnel (idPersonnel)
);


CREATE TABLE film (
        codeFilm varchar(10) PRIMARY KEY,
        titre VARCHAR NOT NULL,
        date DATE,
        editeur VARCHAR,
        genre VARCHAR,
        codeClassif VARCHAR,
        langue varchar(30) NOT NULL,
        longueur time NOT NULL,
        synopsis text
);

CREATE TABLE enregistrement (
        codeEnregistrement varchar(10) PRIMARY KEY,
        titre VARCHAR NOT NULL,
        date DATE,
        editeur VARCHAR,
        genre VARCHAR,
        codeClassif VARCHAR NOT NULL,
        duree time NOT NULL
);

CREATE TABLE livre (
        codeLivre varchar(10) PRIMARY KEY,
        titre VARCHAR NOT NULL,
        date DATE,
        editeur VARCHAR,
        genre VARCHAR,
        codeClassif VARCHAR,
        ISBN NUMERIC(13) NOT NULL,
        langue varchar(30) NOT NULL,
        resume text
);

CREATE TABLE pret (
        idPret SERIAL PRIMARY KEY,
        dateEmprunt date NOT NULL DEFAULT NOW(),
        duree integer NOT NULL, -- en nombre de jour (plus simple à traiter
        dateRetour date,
        emprunteur integer REFERENCES adherent(idAdherent)
);

CREATE TABLE exemplaire (
        idExemplaire SERIAL PRIMARY KEY,
        livre varchar(10),
        film varchar(10),
        enregistrement varchar(10),
        disponibilite boolean DEFAULT TRUE,
        bonEtat boolean DEFAULT TRUE,
        FOREIGN KEY (livre) REFERENCES livre(codeLivre),
        FOREIGN KEY (film) REFERENCES film(codeFilm),
        FOREIGN KEY (enregistrement) REFERENCES enregistrement(codeEnregistrement),
        CHECK ((livre IS NOT NULL AND film IS NULL AND enregistrement IS NULL)
                           OR (livre IS NULL AND film IS NOT NULL AND enregistrement IS NULL)
                           OR (livre IS NULL AND film IS NULL AND enregistrement IS NOT NULL))
);

CREATE TABLE deterioration (
idSanction SERIAL PRIMARY KEY,
idPret INTEGER,
idExemplaire INTEGER,
dateRemboursement DATE,
remboursement NUMERIC,
FOREIGN KEY (idPret) REFERENCES pret(idPret),
FOREIGN KEY (idExemplaire) REFERENCES exemplaire(idExemplaire),
CONSTRAINT UC_deterioration UNIQUE (idPret, idExemplaire)
);

CREATE TABLE exemplairePret(
        idExemplaire integer REFERENCES exemplaire(idExemplaire),
        idPret integer REFERENCES pret(idPret),
        PRIMARY KEY (idExemplaire,idPret)
);

CREATE TABLE enregistrementCompositeur(
        codeEnregistrement varchar(10) REFERENCES enregistrement(codeEnregistrement),
        idCompositeur integer REFERENCES contributeur(idContributeur),
        PRIMARY KEY (codeEnregistrement,idCompositeur)
);

CREATE TABLE enregistrementInterprete(
        codeEnregistrement varchar(10) REFERENCES enregistrement(codeEnregistrement),
        idInterprete integer REFERENCES contributeur(idContributeur),
        PRIMARY KEY (codeEnregistrement,idInterprete)
);

CREATE TABLE filmActeur(
        codeFilm varchar(10) REFERENCES film(codeFilm),
        idActeur integer REFERENCES contributeur(idContributeur),
        PRIMARY KEY (codeFilm,idActeur)
);

CREATE TABLE filmRealisateur(
        codeFilm varchar(10) REFERENCES film(codeFilm),
        idRealisateur integer REFERENCES contributeur(idContributeur),
        PRIMARY KEY (codeFilm,idRealisateur)
);

CREATE TABLE livreAuteur(
        codeLivre varchar(10) REFERENCES livre(codeLivre),
        idAuteur integer REFERENCES contributeur(idContributeur),
        PRIMARY KEY (codeLivre,idAuteur)
);


-- Contraintes Applicatives:
---Verifier si adherent n'est pas blacklist lorqu'il emprunte
---Pas de table retard: au moment de l'emprunt vérifier si l'utilisateur n'a pas un malus de jour dû à son dernier emprunt

INSERT INTO contributeur (idContributeur,nom,prenom,nationalite) VALUES (1,'Rimbaud','Arthur','française');
INSERT INTO contributeur (idContributeur,nom,prenom,nationalite) VALUES (2,'Baudelaire','Charles','française');
INSERT INTO contributeur (idContributeur,nom,prenom,ddn,nationalite) VALUES (3,'Whedon','Joss','1964-06-23','américaine');
INSERT INTO contributeur (idContributeur,nom,prenom,ddn,nationalite) VALUES (4,'Moussorgski','Modeste','1839-03-21','russe');
INSERT INTO contributeur (idContributeur,nom,prenom,ddn,nationalite) VALUES (5,'Evans','Chris','1981-06-13','américaine');
INSERT INTO contributeur (idContributeur,nom,prenom,ddn,nationalite) VALUES (6,'Rufallo','Mark','1967-11-22','américaine');
INSERT INTO contributeur (idContributeur,nom,prenom,ddn,nationalite) VALUES (7,'Piaf','Edith','1915-12-19','française');

INSERT INTO adherent (idAdherent,nom,prenom,ddn,email,carte_adherent) VALUES (1,'Screve','Julien','1915-10-01','julien.screve@etu.utc.fr','JS139');
INSERT INTO adherent (idAdherent,nom,prenom,ddn,email,carte_adherent) VALUES (2,'Costermans','Luc','1937-04-14','luc.costermans@etu.utc.fr','LC283');
INSERT INTO adherent (idAdherent,nom,prenom,ddn,email,carte_adherent) VALUES (3,'Valdivia','Osvaldo','1968-07-28','osvaldo.valdivia@etu.utc.fr','OV241');
INSERT INTO adherent (idAdherent,nom,prenom,ddn,email,carte_adherent) VALUES (4,'Rodriguez','Come','2006-12-25','come.rodriguez@etu.utc.fr','CR143');

INSERT INTO personnel (idPersonnel,nom,prenom,ddn,email) VALUES (1,'Screve','Julien','1915-10-01','julien.screve@etu.utc.fr');

INSERT INTO compte (login,motDePasse,adherent,personnel) VALUES ('screveju','passwordSJ',1,1);
INSERT INTO compte (login,motDePasse,adherent) VALUES ('costerlu','passwordLC',2);
INSERT INTO compte (login,motDePasse,adherent) VALUES ('valdivos','passwordOV',3);
INSERT INTO compte (login,motDePasse,adherent) VALUES ('rodrigco','passwordCR',4);

INSERT INTO film VALUES (1,'Avengers','01-01-2012',NULL,'Super-héros','TS3X1000','anglais','02:12:00','Les Avengers doivent affronter Loki, le frère de Thor');

INSERT INTO enregistrement VALUES (1,'Une nuit sur le mont chauve',NULL,NULL,NULL,'M132','01:00:00');
INSERT INTO enregistrement VALUES (2,'Non, Je ne regrette rien',NULL,NULL,NULL,'EP01','00:02:30');

INSERT INTO livre VALUES (1,'Les fleurs du mal','01-01-2014','Poche',NULL,'CB14','2253007102123','français',NULL);
INSERT INTO livre VALUES (2,'Les fleurs du mal','01-01-2009','Galimard',NULL,'CB15','2253008102143','français',NULL);

INSERT INTO enregistrementCompositeur VALUES (1,4);
INSERT INTO enregistrementInterprete VALUES (2,7);
INSERT INTO filmRealisateur VALUES (1,3);
INSERT INTO livreAuteur VALUES (1,2);
INSERT INTO livreAuteur VALUES (2,2);
INSERT INTO filmActeur VALUES (1,5);
INSERT INTO filmActeur VALUES (1,6);

INSERT INTO exemplaire (idExemplaire,livre) VALUES (1,1);
INSERT INTO exemplaire (idExemplaire,enregistrement) VALUES (2,2);
INSERT INTO exemplaire (idExemplaire,film) VALUES (3,1);
INSERT INTO exemplaire (idExemplaire,enregistrement) VALUES (4,1);

INSERT INTO pret(idPret,duree,emprunteur) VALUES (1,7,2);
INSERT INTO pret(idPret,dateEmprunt,duree,dateRetour,emprunteur) VALUES (2,'2020-11-23',3,'2020-11-28',1);

INSERT INTO exemplairePret VALUES (1,1);
INSERT INTO exemplairePret VALUES (2,1);
INSERT INTO exemplairePret VALUES (3,1);
INSERT INTO exemplairePret VALUES (4,2);

INSERT INTO deterioration VALUES (1,2,4,'2020-11-28',150);
