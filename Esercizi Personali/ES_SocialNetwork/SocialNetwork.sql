-- DDL
DROP database IF EXISTS SimulazioneIG;
CREATE DATABASE SimulazioneIG;
USE SimulazioneIG;

CREATE TABLE utente (
    nickname varchar(250) PRIMARY KEY,
    url_utente varchar(250) not null unique,
    bio_utente varchar(250)
);

CREATE TABLE listaFollower (
    id_listaFollower INTEGER PRIMARY KEY AUTO_INCREMENT,
    nickname_follower varchar(250) not null,
    url_follower varchar(250) not null,
    lista_rif varchar(250) NOT NULL,
    FOREIGN KEY (lista_rif) REFERENCES utente(nickname) on delete cascade
);

CREATE TABLE contenuto (
    idContenuto INTEGER PRIMARY KEY AUTO_INCREMENT,
    descrizione_contenuto varchar(250) not null,
    didascalia_contenuto varchar(250),
    orario_pubblicazione DATETIME DEFAULT CURRENT_TIMESTAMP,
    utente_rif varchar(250) not null,
    FOREIGN KEY (utente_rif) REFERENCES utente(nickname)
);

CREATE TABLE commento (
    idCommento INTEGER PRIMARY KEY auto_increment,
    descrizione_commento VARCHAR(250) NOT NULL,
    orario_commento DATETIME DEFAULT CURRENT_TIMESTAMP,
    utente_commentatore varchar(250) NOT NULL,
    utente_rif varchar(250) NOT NULL,
    contenuto_rif INTEGER NOT NULL,
    FOREIGN KEY (utente_rif) REFERENCES utente(nickname),
    FOREIGN KEY (contenuto_rif) REFERENCES contenuto(idContenuto)
);

-- DML
INSERT INTO utente(nickname,url_utente,bio_utente)
VALUE ("mar123","123.mar","Amante del mare"),
      ("lun456","456.lun","Sono un lupo mannaro"),
      ("gio987","987.gio",""),
      ("dom370","370.dom","Maestro di sci");
      
INSERT INTO listaFollower(nickname_follower,url_follower,lista_rif)
VALUE ("lun456","456.lun","mar123"),
	  ("mar123","123.mar","dom370"),
      ("gio987","987.gio","dom370"),
      ("mar123","123.mar","gio987"),
      ("dom370","370.dom","gio987"),
      ("gio987","987.gio","lun456");
      
INSERT INTO contenuto(descrizione_contenuto,didascalia_contenuto,utente_rif)
VALUE ("Foto sulla spiaggia","","mar123"),
      ("Montagna imbiancata","","dom370"),
      ("Luna piena","","lun456"),
      ("Mare in tempesta","","mar123");
      
INSERT INTO commento(descrizione_commento,utente_commentatore,utente_rif,contenuto_rif)
VALUE ("Beato te!","gio987","mar123",1),
      ("Che bella vista","lun456","dom370",2),
      ("Hasta la vista","dom370","mar123",1),
      ("Stasera vai a caccia?","gio987","lun456",3),
      ("Con chi sei?","lun456","mar123",4);
      
-- QL
-- 1) mostra tutti i commenti lasciati dall'utente lun456
SELECT descrizione_commento,utente_commentatore 
       FROM commento WHERE utente_commentatore="lun456";

-- 2) mostra tutti i commenti rilasciati al profilo dell'utente mar123
SELECT descrizione_commento,utente_commentatore,utente_rif 
	   FROM commento WHERE utente_rif="mar123";

-- 3) mostra tutti i commenti rilasciati al profilo dell'utente mar123 solo dai follower
SELECT descrizione_commento,utente_commentatore,utente_rif 
	   FROM commento 
       WHERE utente_commentatore IN (SELECT nickname_follower FROM listaFollower WHERE lista_rif="mar123")
       AND utente_rif="mar123";

-- 4) mostra tutti i commenti rilasciati al profilo dell'utente mar123 non dai follower
SELECT descrizione_commento,utente_commentatore,utente_rif 
	   FROM commento 
       WHERE utente_commentatore NOT IN (SELECT nickname_follower FROM listaFollower WHERE lista_rif="mar123")
       AND utente_rif="mar123";
       
