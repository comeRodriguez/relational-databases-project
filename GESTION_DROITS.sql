Gestion de Droits:
-- Permet à tout le monde de voir la liste des documents de la bibliotheque
GRANT SELECT ON livre, film, enregistrement, exemplaire, classiflivre, resume, classiffilm, languefilm, classifenregistrement TO PUBLIC

-- Permet au personnel d'insérer ou de modifier des donnés sur toutes les tables sauf la table personnel, mais ne lui permet pas de d'altérer ou supprimer des tables
GRANT INSERT, UPDATE ON livre, film, enregistrement, exemplaire, classiflivre, resume, classiffilm, languefilm, classifenregistrement, contributeur, adherent, compte, pret, deterioration, exemplairepret, livreauteur, filmacteur, filmrealisateur, enregistrementinterpret, enregistrementcompositeur TO personnel WITH GRANT OPTION

-- Donne tous les droits à un superadmin
GRANT ALL PRIVILEGES ON  livre, film, enregistrement, exemplaire, classiflivre, resume, classiffilm, languefilm, classifenregistrement, contributeur, adherent, compte, pret, déterioration, exemplairepret, livreauteur, filmacteur, filmrealisateur, enregistrementinterpret, enregistrementcompositeur, personnel TO superadmin WITH GRANT OPTION
