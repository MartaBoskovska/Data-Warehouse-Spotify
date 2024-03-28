DROP TABLE ECOUTE;
DROP TABLE BRIDGE_ARTISTE_MUSIQUE;
DROP TABLE MUSIQUE;
DROP TABLE UTILISATEUR;
DROP TABLE ARTISTE;
DROP TABLE DISPOSITIF_ECOUTE;
DROP TABLE GENRE;
DROP TABLE TEMPS;
DROP TABLE ABONNEMENT;
DROP VIEW VUE_UNE_DATE;
DROP TABLE UNE_DATE;
DROP TABLE TYPE_ABONNEMENT;
DROP TABLE MODE_PAIMENT;
DROP TABLE TYPE_UTILISATEUR;
DROP TABLE TYPE_PROMOTION;


CREATE TABLE MUSIQUE (
    id_musique NUMBER(11) PRIMARY KEY,
    titre VARCHAR2(100),
    duree NUMBER(4),
    date_sortie DATE,
    langue VARCHAR2(50),
    parole VARCHAR2(1000)
);

CREATE TABLE UTILISATEUR (
    id_user NUMBER(11) PRIMARY KEY,
    email VARCHAR2(50),
    numero NUMBER(10),
    nom VARCHAR2(50),
    prenom VARCHAR2(50),
    date_naissance DATE,
    date_inscription DATE,
    ville VARCHAR2(50),
    pays VARCHAR2(50)
);

CREATE TABLE ARTISTE (
    id_artiste NUMBER(11) PRIMARY KEY,
    email VARCHAR2(50),
    numero NUMBER(10),
    pseudo VARCHAR2(25),
    nom VARCHAR2(25),
    prenom VARCHAR2(25),
    label VARCHAR2(25),
    nombre_abonne NUMBER(10)
);

CREATE TABLE UNE_DATE (
  id_date NUMBER(11) PRIMARY KEY,
  date_col DATE,
  description_date VARCHAR2(100),
  jour NUMBER(2),
  mois VARCHAR2(20),
  annee NUMBER(4),
  info_week_end VARCHAR2(20),
  info_vacance VARCHAR2(20)
);

CREATE VIEW VUE_UNE_DATE AS
SELECT
  id_date,
  date_col,
  description_date,
  jour,
  mois,
  annee,
  info_week_end,
  info_vacance
FROM UNE_DATE;


CREATE TABLE DISPOSITIF_ECOUTE (
    id_dispositif NUMBER(11) PRIMARY KEY,
    numero_model NUMBER(10),
    nom_modele VARCHAR(25),
    versionSysteme VARCHAR(25),
    marque VARCHAR(25),
    qualite_son_max VARCHAR(25)
);

CREATE TABLE GENRE (
    id_genre NUMBER(11) PRIMARY KEY,
    nom VARCHAR(25),
    origine_culturelle VARCHAR(50),
    origine_stylistique VARCHAR(100),
    periode_historique VARCHAR(25),
    caracteristiques VARCHAR(150),
    emotions VARCHAR(150)
);

CREATE TABLE TEMPS (
    id_temps NUMBER(11) PRIMARY KEY,
    temps TIMESTAMP,
    heure NUMBER(2),
    am_pm VARCHAR(2),
    partie_du_jour VARCHAR(25),
    shift VARCHAR(25)
);

CREATE TABLE BRIDGE_ARTISTE_MUSIQUE (
    id_musique NUMBER(11) REFERENCES MUSIQUE(id_musique),
    id_artiste NUMBER(11) REFERENCES ARTISTE(id_artiste),
    coef_ecoute NUMBER(2,1),
    PRIMARY KEY(id_musique,id_artiste)
);

CREATE TABLE ECOUTE (
    id_user NUMBER(11) REFERENCES UTILISATEUR(id_user),
    id_musique NUMBER(11) REFERENCES MUSIQUE(id_musique),
    id_artiste NUMBER(11) REFERENCES ARTISTE(id_artiste),
    id_genre NUMBER(11) REFERENCES GENRE(id_genre),
    id_dispositif NUMBER(11) REFERENCES DISPOSITIF_ECOUTE(id_dispositif),
    id_date NUMBER(11) REFERENCES UNE_DATE(id_date),
    id_temps NUMBER(11) REFERENCES TEMPS(id_temps),
    duree_ecoute NUMBER(4),
    PRIMARY KEY(id_user,id_musique,id_artiste,id_genre,id_dispositif,id_date,id_temps)
);



/************************ ABONNEMENT ***********************************/


CREATE TABLE TYPE_ABONNEMENT (
  id_type_abonnement NUMBER(11) PRIMARY KEY,
  nom VARCHAR(60),
  description_type VARCHAR2(1000),
  tarif_dollar NUMBER(4,2),
  nb_appareil_max NUMBER(2),
  duree_jour NUMBER(3)
);

CREATE TABLE MODE_PAIMENT (
  id_mode_paiment NUMBER(11) PRIMARY KEY,
  mode_paiment VARCHAR(50),
  type_carte VARCHAR(50),
  pays_transaction VARCHAR(50),
  devise VARCHAR(25)
);

CREATE TABLE TYPE_UTILISATEUR (
  id_type_utilisateur NUMBER(11) PRIMARY KEY,
  sexe VARCHAR(1),
  pays VARCHAR(25),
  tranche_age_sup NUMBER(3),
  tranche_age_inf NUMBER(3),
  statut_pro VARCHAR(50),
  niveau_education VARCHAR(30)
);


CREATE TABLE TYPE_PROMOTION (
  id_type_promotion NUMBER(11) PRIMARY KEY,
  nom VARCHAR(20),
  pourcent_remise NUMBER(2),
  mois_offerts NUMBER(2)
);


CREATE TABLE ABONNEMENT(
    id_type_utilisateur NUMBER(11) REFERENCES TYPE_UTILISATEUR(id_type_utilisateur),
    id_type_abonnement NUMBER(11) REFERENCES TYPE_ABONNEMENT(id_type_abonnement),
    id_type_promotion NUMBER(11) REFERENCES TYPE_PROMOTION(id_type_promotion),
    id_mode_paiment NUMBER(11) REFERENCES MODE_PAIMENT(id_mode_paiment),
    id_date NUMBER(11) REFERENCES UNE_DATE(id_date),
    nombre_abonnement NUMBER(4),
    PRIMARY KEY(id_type_utilisateur,id_type_abonnement,id_type_promotion,id_mode_paiment,id_date)
);