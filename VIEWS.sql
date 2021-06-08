DROP VIEW IF EXISTS MauvaisEtat;
DROP VIEW IF EXISTS LivresDispo;
DROP VIEW IF EXISTS FilmsDispo;
DROP VIEW IF EXISTS EnregistrementsDispo;
DROP VIEW IF EXISTS EmpruntEnCours;
DROP VIEW IF EXISTS LivresLesPlusEmpruntes;
DROP VIEW IF EXISTS GrandsRetardataires;
DROP VIEW IF EXISTS retard;

/*Lors de notre passage au JSON, les tables suivantes ne pourront pas être créés au niveau du SQL, car les attributs auquelles elles font référence sont en JSON. Cependant, une version équivalente pourra être reproduite en applicatif */
--DROP VIEW IF EXISTS AuteursLesPlusLus;
--DROP VIEW IF EXISTS Blacklist;

/* l'attribut blacklist étant contenu dans l'attribut JSON personne, cette table devra être créée au niveau applicatif
-- Comptes blacklisté
CREATE VIEW Blacklist (login, nom, prenom) 
AS 
SELECT login, nom, prenom
FROM Adherent, Compte
WHERE Adherent.Blacklist AND Adherent.idAdherent = Compte.adherent;
*/

-- Exemplaire déteriores 
CREATE VIEW MauvaisEtat (idExemplaire, login, dateRetour, Montant, Rembourse)
AS
SELECT idExemplaire, login, dateRetour, Remboursement, dateRemboursement IS NULL AS Rembourse
FROM Adherent, Pret, Deterioration
WHERE Pret.emprunteur = Adherent.login AND Deterioration.idPret = Pret.idPret;

--Documents qui peuvent être empruntes (disponibles et en bon état)
CREATE VIEW LivresDispo (idExemplaire,codeLivre,titre)
AS
SELECT idExemplaire, codeLivre, titre
FROM exemplaire, livre
WHERE livre IS NOT NULL AND codeLivre = livre AND disponibilite AND bonEtat;

CREATE VIEW FilmsDispo (idExemplaire,codeFilm,titre)
AS
SELECT idExemplaire, codeFilm, titre
FROM exemplaire, film
WHERE film IS NOT NULL AND codeFilm = film AND disponibilite AND bonEtat;

CREATE VIEW EnregistrementsDispo (idExemplaire,codeEnregistrement,titre)
AS
SELECT idExemplaire, codeEnregistrement, titre
FROM exemplaire, enregistrement
WHERE enregistrement IS NOT NULL AND codeEnregistrement = enregistrement AND disponibilite AND bonEtat;

-- Documents qui sont empruntés

-- Les plus empruntés

-- Jointure gauche pour ajouter au classement les livres qui n'ont jamais été empruntés
-- View similaire pour film et enregistrement (il suffit de remplacer les references à livre par les autres)
CREATE VIEW LivresLesPlusEmpruntes(idExemplaire,codeLivre,titre,nEmprunt)
AS
SELECT e.idExemplaire, codeLivre, titre, COUNT(ep.idExemplaire) as nEmprunt
FROM exemplaire e
INNER JOIN livre l 
ON e.livre = l.codeLivre
LEFT JOIN exemplairePret ep
ON e.idExemplaire = ep.idExemplaire 
GROUP BY  e.idExemplaire, l.codeLivre, titre
ORDER BY nEmprunt DESC, e.idExemplaire;

-- Listes des utilisateurs qui ont/ont eu des retards pour rendre des prêts

CREATE VIEW GrandsRetardataires(idAdherent,login,nRetard)
AS
SELECT emprunteur, login, COUNT(emprunteur) as nRetard
FROM Pret, compte
WHERE
CASE WHEN (dateRetour IS NOT NULL) THEN dateRetour - dateEmprunt > duree 
ELSE CURRENT_DATE - dateEmprunt > duree 
END
AND emprunteur = Adherent
GROUP BY emprunteur, login
ORDER BY nRetard DESC;



CREATE VIEW retard AS
SELECT idPret, dateemprunt, dateRetour, emprunteur, duree, CASE
	WHEN dateRetour IS NOT NULL THEN dateRetour-dateEmprunt
	ELSE CURRENT_DATE - dateEmprunt
	END
	AS dureeTotale
FROM pret pr WHERE
(SELECT CASE
	WHEN dateRetour IS NOT NULL THEN dateRetour-dateEmprunt
	ELSE CURRENT_DATE - dateEmprunt
	END
FROM pret WHERE idPret = pr.idPret) > duree;

/* Auteur devenant un attribut JSON de livre, cette table devra être crée au niveau applicatif
CREATE VIEW AuteursLesPlusLus(Auteur,nom,prenom,nEmprunt)
AS
SELECT idAuteur, nom, prenom, count(idAuteur) as nEmprunt
FROM exemplairePret ep, exemplaire e, livreAuteur la, contributeur c
WHERE 
e.livre IS NOT NULL AND
e.livre = la.codeLivre AND
ep.idExemplaire = e.idExemplaire AND
c.idContributeur = la.idAuteur
GROUP BY idAuteur, nom, prenom
ORDER BY nEmprunt DESC;
*/
