#!/usr/bin/python3

import psycopg2

""""
HOST = "localhost"
USER = "postgres"
PASSWORD = "root"
DATABASE = "biblioNF18"
"""
HOST = "localhost"
USER = "postgres"
PASSWORD = "root"
DATABASE = "nf18"


conn = psycopg2.connect("host=%s dbname=%s user=%s password=%s" % (HOST, DATABASE, USER, PASSWORD))
cur = conn.cursor()


#################################################### Vues

def auteursLesPlusLus():
    sql = "SELECT * FROM auteurslespluslus;"
    cur.execute(sql)
    res = cur.fetchall()

    print('| Auteur |  Nom   | Prenom   | N° empruntés |')
    print('_____________________________________________')
    for line in res:
        print ( '| %s | %s | %s | %s |' % (line[0], line[1],line[2],line[3]))
    print()


def blacklist(): ############################################### PAS CREEE
    sql = "SELECT * FROM blacklist;"
    cur.execute(sql)
    res = cur.fetchall()

    print('| Login |  Nom   | Prenom   |')
    print('_____________________________')
    for line in res:
        print ( '| %s | %s | %s |' % (line[0], line[1],line[2]))
    print()


def livresdispo():
    sql = "SELECT * FROM livresdispo;"
    cur.execute(sql)
    res = cur.fetchall()

    print('| ID exemplaire |  Code Livre   | Titre  |')
    print('__________________________________________')
    for line in res:
        print ( '| %s | %s | %s |' % (line[0], line[1],line[2]))
    print()

def enregistrementsdispo():
    sql = "SELECT * FROM enregistrementsdispo;"
    cur.execute(sql)
    res = cur.fetchall()

    print('| ID exemplaire |  Code Enregistrement   | Titre  |')
    print('___________________________________________________')
    for line in res:
        print ( '| %s | %s | %s |' % (line[0], line[1],line[2]))
    print()


def filmsdispo():
    sql = "SELECT * FROM filmsdispo;"
    cur.execute(sql)
    res = cur.fetchall()

    print('| ID exemplaire |  Code Film   | Titre  |')
    print('___________________________________________________')
    for line in res:
        print ( '| %s | %s | %s |' % (line[0], line[1],line[2]))
    print()


def grandsretardataires():
    sql = "SELECT * FROM grandsretardataires;"
    cur.execute(sql)
    res = cur.fetchall()

    print('| ID Adherent |  Login   | N° retards  |')
    print('___________________________________________________')
    for line in res:
        print ( '| %s | %s | %s |' % (line[0], line[1],line[2]))
    print()


def livresLesPlusEmpruntes():
    sql = "SELECT * FROM livreslesplusempruntes;"
    cur.execute(sql)
    res = cur.fetchall()

    print('| ID Exemplaire |  Code Livre   | Titre  | N° emprunts |')
    print('___________________________________________________')
    for line in res:
        print ( '| %s | %s | %s | %s |' % (line[0], line[1],line[2],line[3]))
    print()



def mauvaisEtat():
    sql = "SELECT * FROM mauvaisetat;"
    cur.execute(sql)
    res = cur.fetchall()

    print('| ID Exemplaire |  Login   | Date de retour | Montant | Date Remboursement |')
    print('___________________________________________________')
    for line in res:
        print ( '| %s | %s | %s | %s | %s | ' % (line[0], line[1],line[2],line[3],line[4]))
    print()

def retards():
    sql = "SELECT * FROM retard;"
    cur.execute(sql)
    res = cur.fetchall()

    print('| ID prêt |  Date emprunt   | Date retour  | Emprunteur | Durée emprunte | Durée totale |')
    print('___________________________________________________')
    for line in res:
        print ( '| %s | %s | %s | %s | %s | %s |' % (line[0], line[1],line[2],line[3],line[4],line[5]))
    print()


############################################# Requetes


def tousLesLivres():
    sql = "SELECT * FROM livre;"
    cur.execute(sql)
    res = cur.fetchall()

    print('| Code Livre |  Titre   | Date   | Editeur |  Genre  | CodeClassif | ISBN   | Langue  | Resumé  | Auteurs |')
    print('_________________________________________________________________________________________________')
    for line in res:
        print ('%s | %s | %s | %s | %s | %s | %s | %s | %s | %s |' % (line[0],line[1],line[2],line[3],line[4],line[5],line[6],line[7],line[8], line[9]))
    print()



def tousLesFilms():
    sql = "SELECT * FROM film;"
    cur.execute(sql)
    res = cur.fetchall()

    print('| Code Film |  Titre   | Date   | Editeur |  Genre  | CodeClassif | Langue  | Longueur  | Synopsis | Realisateurs | Auteurs |')
    print('_________________________________________________________________________________________________')
    for line in res:
        print ('%s | %s | %s | %s | %s | %s | %s | %s | %s | %s | %s |' % (line[0],line[1],line[2],line[3],line[4],line[5],line[6],line[7],line[8],line[9],line[10]))
    print()

def tousLesEnregistrements():
    sql = "SELECT * FROM enregistrement;"
    cur.execute(sql)
    res = cur.fetchall()

    print('| Code Enregistrement |  Titre   | Date   | Editeur |  Genre  | CodeClassif | Durée | Compositeurs | Interpretes |')
    print('_____________________________________________________________________________________')
    for line in res:
        print ('| %s | %s | %s | %s | %s | %s | %s | %s | %s |' % (line[0],line[1],line[2],line[3],line[4],line[5],line[6],line[7],line[8]))
    print()


def tousLesAdherents():
    sql = "SELECT * FROM adherent;"
    cur.execute(sql)
    res = cur.fetchall()

    print('| Login |  Mot de passe   | Nom   | Prenom | Date de naissance | Email | Téléphone | Adresse |')
    print('_________________________________________________________________________________________________________________________________________')
    for line in res:
        print ('%s | %s | %s | %s | %s | %s | %s | %s |' % (line[0],line[1],line[2],line[3],line[4],line[5],line[6],line[7]))
    print()




def tousLesPrets():
    sql = "SELECT * FROM pret;"
    cur.execute(sql)
    res = cur.fetchall()

    print('| ID Prêt    |  Date emprunt   | Date retour   | Emprunteur |  Duree  |')
    print('______________________________________________________________________')
    for line in res:
        print ('%s | %s | %s | %s | %s |' % (line[0],line[1],line[2],line[3],line[4]))
    print()


def infoLivre():
    print("Tappez le code du livre")
    code = input()

    sql = "SELECT * FROM livre WHERE codeLivre = '%s';" %(code)
    cur.execute(sql)
    res = cur.fetchall()

    print('| Code Livre |  Titre   | Date   | Editeur |  Genre  | CodeClassif | ISBN   | Langue  | Resumé  | Auteurs |')
    print('_________________________________________________________________________________________________')
    for line in res:
        print ('%s | %s | %s | %s | %s | %s | %s | %s | %s | %s |' % (line[0],line[1],line[2],line[3],line[4],line[5],line[6],line[7],line[8], line[9]))
    print()




def infoFilm():
    print("Tappez le code du film")
    code = input()

    sql = "SELECT * FROM film WHERE codeFilm = '%s';" %(code)
    cur.execute(sql)
    res = cur.fetchall()

    print('| Code Film |  Titre   | Date   | Editeur |  Genre  | CodeClassif | Langue  | Longueur  | Synopsis | Realisateurs | Auteurs |')
    print('_________________________________________________________________________________________________')
    for line in res:
        print ('%s | %s | %s | %s | %s | %s | %s | %s | %s | %s | %s |' % (line[0],line[1],line[2],line[3],line[4],line[5],line[6],line[7],line[8],line[9],line[10]))
    print()


def infoEnregistrement(): #################################### CHANGE JSON
    print("Tappez le code de l'enregistrement")
    code = input()

    sql = "SELECT * FROM enregistrement WHERE codeEnregistrement = '%s';" %(code)
    cur.execute(sql)
    res = cur.fetchall()

    print('| Code Enregistrement |  Titre   | Date   | Editeur |  Genre  | CodeClassif | Durée | Compositeurs | Interpretes |')
    print('_____________________________________________________________________________________')
    for line in res:
        print ('| %s | %s | %s | %s | %s | %s | %s | %s | %s |' % (line[0],line[1],line[2],line[3],line[4],line[5],line[6],line[7],line[8]))
    print()


####################################### Insertions

def insertLivre():
    print("Donnez les informations nécessaires pour l'insertion d'un livre. Les données avec une étoile * sont obligatoires")
    codelivre=''
    titre =''
    isbn=''
    langue=''

    while(codelivre==''):
        print('Donnez le Code du livre *')
        codelivre = input()
    while titre =='':
        print('Donnez le titre du livre *')
        titre = input()
    print('Donnez la date de publication du livre')
    date = input()
    if(date==''):
        date='NULL' #Insertion de la valeur NULL nécessaire pour les type DATE
    print("Donnez le nom de l'editeur")
    editeur = input()

    print('Donnez le genre du livre')
    genre = input()

    print('Donnez le code de classification du livre')
    codeClassif = input()

    while(isbn==''):
        print('Donnez le ISBN *')
        isbn = input()
    while langue=='':
        print('Donnez la langue du livre *')
        langue = input()
    print('Donnez le resumé du livre ')
    resume = input()

    print("Donnez le nombre d'auteurs")
    nbAuteurs = input()
    noms = []
    prenoms = []
    nationalites = []
    for i in range(int(nbAuteurs)):
        print("Donnez le nom de l'auteur "+str(i+1))
        nom = input()
        print("Donnez le prenom de l'auteur "+str(i+1))
        prenom = input()
        print("Donnez la nationalité de l'auteur "+str(i+1))
        nationalite = input()

    noms.append(nom)
    prenoms.append(prenom)
    nationalites.append(nationalite)

    try:
        sql = "INSERT INTO livre VALUES ('%s','%s',%s,'%s','%s','%s','%s','%s','%s'," % (codelivre,titre,date,editeur,genre,codeClassif,isbn,langue,resume)
        sql+= "'["
        for i in range(len(noms)):
            sql+= '{"nom": "%s", "prenom": "%s", "nationalite": "%s"}'%(noms[i],prenoms[i],nationalites[i])
            if(i < len(noms)-1):
                sql+=","
        sql+="]'"
        sql += ");"
        cur.execute(sql)
        conn.commit()
    except psycopg2.IntegrityError as e:
        print("Message système :", e)









#################### Statistiques courtes
def nbAdherents():
    sql = "SELECT COUNT(*) FROM adherent AS nb_adherents;"
    cur.execute(sql)
    res = cur.fetchall()

    print("| Nombre d'adhérents|")
    print('_____________________')
    for line in res:
        print ('|   %s   |' % (line[0]))
    print()


#####################    Submenus

def menuLivres():
    choix = '1'
    while(choix!='0'):
        print('********** MENU LIVRES **********')
        print('Pour voir la liste des livres tappez 1')
        print('Pour voir la liste des livr qes disponibles 2')
        print("Pour ajouter un livre tappez 3")
        print("Pour consulter l'information d'un livre, tappez 4")
        print('Pour retourner au menu principale tappez 0')
        print()
        choix=input()
        if(choix=='1'):
            tousLesLivres()
        if(choix=='2'):
            livresdispo()
        if(choix=='3'):
            insertLivre()
        if(choix=='4'):
            infoLivre()
        if(choix=='0'):
            menuPrincipale()
            break


def menuFilms():
    choix = '1'
    while(choix!='0'):
        print('********** MENU FILMS **********')
        print('Pour voir la liste des films tappez 1')
        print('Pour voir la liste des films disponibles tappez 2')
        print("Pour consulter l'information d'un film tappez 3")
        print('Pour retourner au menu principale tappez 0')
        print()
        choix=input()
        if(choix=='1'):
            tousLesFilms()
        if(choix=='2'):
            filmsdispo()
        if(choix=='3'):
            infoFilm()
        if(choix=='0'):
            menuPrincipale()
            break


def menuEnregistrements():
    choix = '1'
    while(choix!='0'):
        print('********** MENU ENREGISTREMENTS **********')
        print('Pour voir la liste des enregistrements tappez 1')
        print('Pour voir la liste des enregistrements disponibles 2')
        print("Pour afficher l'information d'un enregistrement, tappez 3")
        print('Pour retourner au menu principale tappez 0')
        print()
        choix=input()
        if(choix=='1'):
            tousLesEnregistrements()
        if(choix=='2'):
            enregistrementsdispo()
        if(choix=='3'):
            infoEnregistrement()
        if(choix=='0'):
            menuPrincipale()
            break


def menuAdherets():
    choix = '1'
    while(choix!='0'):
        print('********** MENU ADHERENTS **********')
        print('Pour voir la liste des adherents, tappez 1')
        print("Pour consulter la liste des adhérents dans la blacklist, tappez 2")
        print('Pour retourner au menu principale tappez 0')
        print()
        choix=input()
        if(choix=='1'):
            tousLesAdherents()
        if(choix=='2'):
            blacklist()
        if(choix=='0'):
            menuPrincipale()
            break


def menuPrets():
    choix = '1'
    while(choix!='0'):
        print('********** MENU PRETS **********')
        print('Pour voir la liste des prêts tappez 1')
        print('Pour voir la liste des grands retardataires tappez 2')
        print("Pour consulter la liste des retards, tappez 3")
        print('Pour retourner au menu principale tappez 0')
        print()
        choix=input()
        if(choix=='1'):
            tousLesPrets()
        if(choix=='2'):
            grandsretardataires()
        if(choix=='3'):
            retards()
        if(choix=='0'):
            menuPrincipale()
            break


def menuStatistiques():
    choix = '1'
    while(choix!='0'):
        print('********** MENU STATISTIQUES **********')
        print('Pour voir la liste des auteurs les plus lus tappez 1')
        print("Pour consulter le nombre d'adhérents, tappez 2")
        print("Pour consulter la liste des livres les plus empruntes, tappez 3")
        print('Pour retourner au menu principale tappez 0')
        print()
        choix=input()
        if(choix=='1'):
            auteursLesPlusLus()
        if(choix=='2'):
            nbAdherents()
        if(choix=='3'):
            livresLesPlusEmpruntes()
        if(choix=='0'):
            menuPrincipale()
            break


#Menu principal
def menuPrincipale():
    choix = '1'
    while(choix != '0'):
        print('***************** MENU PRINCIPAL *******************')
        print('Pour ouvrir le menu des livres tappez 1')
        print('Pour ouvrir le menu des films tappez 2')
        print('Pour ouvrir le menu des enregistrements tappez 3')
        print('Pour ouvrir le menu des adherents tappez 4')
        print('Pour ouvrir le menu des prêts tappez 5')
        print('Pour ouvrir le menu des statistiques tappez 6')
        print('Pour sortir tappez 0')
        choix = input()
        if choix=='1':
            menuLivres()
            break
        if choix=='2':
            menuFilms()
            break
        if choix=='3':
            menuEnregistrements()
            break
        if choix=='4':
            menuAdherets()
            break
        if choix=='5':
            menuPrets()
            break
        if choix=='6':
            menuStatistiques()
            break



menuPrincipale()


conn.close()
