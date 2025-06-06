-- DDL
DROP DATABASE IF EXISTS AmministrazioneStabili;
CREATE DATABASE AmministrazioneStabili;
USE AmministrazioneStabili;

CREATE TABLE Badge(ID_Badge INTEGER PRIMARY KEY AUTO_INCREMENT,
                   DataRilascio DATE); 
				
CREATE TABLE AreaAcc(ID_Area INTEGER PRIMARY KEY AUTO_INCREMENT,
                     Nome_Area VARCHAR(250) NOT NULL);               

CREATE TABLE Badge_AreaAcc(RIF_Badge INTEGER NOT NULL,
						   RIF_Area INTEGER NOT NULL,
                           FOREIGN KEY (RIF_Badge) REFERENCES Badge(ID_Badge) ON DELETE CASCADE,
                           FOREIGN KEY (RIF_Area) REFERENCES AreaAcc(ID_Area) ON DELETE CASCADE,
                           UNIQUE(RIF_Badge,RIF_Area));
                           
CREATE TABLE Staff(ID_Staff INTEGER PRIMARY KEY AUTO_INCREMENT,
				   RIF_Badge INTEGER NOT NULL,
				   Nome_Staff VARCHAR(250) NOT NULL,
                   Cognome_Staff VARCHAR(250) NOT NULL,
                   Email VARCHAR(250),
                   Ruolo VARCHAR(250) NOT NULL,
                   FOREIGN KEY (RIF_Badge) REFERENCES Badge(ID_Badge) ON DELETE CASCADE);
                   
CREATE TABLE Condominio(Codice_Cond INTEGER PRIMARY KEY AUTO_INCREMENT,
                        Indirizzo VARCHAR(250) NOT NULL,
                        NumResidenti INTEGER NOT NULL);
                        
CREATE TABLE Fornitore(ID_Forn INTEGER PRIMARY KEY AUTO_INCREMENT,
	                   Nome_Forn VARCHAR(250) NOT NULL);
                       
CREATE TABLE Lavorazione(ID_Lav INTEGER PRIMARY KEY AUTO_INCREMENT,
                         Tipo_Lav VARCHAR(250) NOT NULL,
                         RIF_Cond INTEGER NOT NULL,
                         RIF_Forn INTEGER NOT NULL,
                         Responsabile INTEGER NOT NULL,
                         FOREIGN KEY (RIF_Cond) REFERENCES Condominio(Codice_Cond) ON DELETE CASCADE,
                         FOREIGN KEY (RIF_Forn) REFERENCES Fornitore(ID_Forn) ON DELETE CASCADE,
                         FOREIGN KEY (Responsabile) REFERENCES Staff(ID_Staff) ON DELETE CASCADE); 
                         
CREATE TABLE Fase(ID_Fase INTEGER PRIMARY KEY AUTO_INCREMENT,
                  RIF_Lav INTEGER NOT NULL,
				  Descrizione VARCHAR(250) NOT NULL,
                  DataIniz DATE,
                  FOREIGN KEY (RIF_Lav) REFERENCES Lavorazione(ID_Lav) ON DELETE CASCADE);
                  
CREATE TABLE Preventivo(Codice_Prev INTEGER PRIMARY KEY AUTO_INCREMENT,
                        RIF_Forn INTEGER NOT NULL,
                        Valore DECIMAL(10,2),
                        FOREIGN KEY (RIF_Forn) REFERENCES Fornitore(ID_Forn) ON DELETE CASCADE);
                        
-- DML 
INSERT INTO Badge(DataRilascio) 
VALUES ("2020-03-12"),("2020-06-30"),("2020-10-09"),("2021-02-28"),("2021-09-24");

INSERT INTO AreaAcc(Nome_Area)
VALUES ("Piano A"), ("Piano B"),("Piano C"),("Piano D"),("Piano E"),("Piano F");

INSERT INTO Badge_AreaAcc(RIF_Badge,RIF_Area)
VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(2,1),(2,2),(2,4),(2,5),(2,6),(3,1),(3,3),(3,4),(3,5),(4,1),(4,2),(4,4),(4,6),(5,1),(5,2),(5,3);

INSERT INTO Staff(RIF_Badge,Nome_Staff,Cognome_Staff,Email,Ruolo)
VALUES (1,"Mario","Rossi","mrossi@gmail.com","Ingegnere IV"),
	   (2,"Giuseppe","Verdi","gverdi@gmail.com","Ingegnere IV"), 
       (3,"Salvatore","Esposito","sesp89@look.it","Ingegnere III"), 
       (4,"Antonio","Bianchi","acab44@live.com","Ingegnere III"),
       (5,"Carlo","Monti","","Ingegnere II");
       
INSERT INTO Condominio(Indirizzo,NumResidenti)
VALUES ("Via Gramsci 777",56),("Via Mazzini 30",85),("Corso Roma 865",143),("Via Trieste 4",25),("Via Albergo 155",48),("Via Toledo 278",101);  

INSERT INTO Fornitore(Nome_Forn)
VALUES ("APAC"),("ItalEdile"),("Rosco"),("Buildering"),("Venom"),("HouseConstruct"),("Cementific");

INSERT INTO Lavorazione(Tipo_Lav,RIF_Cond,RIF_Forn,Responsabile)
VALUES ("Rinnovo tetto",2,4,2),("Nuovo Ascensore",2,5,4),("Pannelli solari",4,4,1),("Installazione montascale",6,6,3);
       
INSERT INTO Fase(RIF_Lav,Descrizione,DataIniz) 
VALUES (1,"Rimozione tegole vecchie","2021-06-23"),(1,"Installazione nuove tegole","2021-06-27"),(1,"Lavoro concluso","2021-07-03"),
       (2,"Lavoro sui cavi","2022-02-15"),(2,"Trasporto cabina","2022-02-19"),(2,"Installazione cabina","2022-02-22"),(2,"Lavoro concluso","2022-02-27"),
       (3,"Trasporto pannelli sul tetto","2022-03-12"),(3,"Installazione pannelli","2022-03-17"),(3,"Lavoro concluso","2022-03-20"),
       (4,"Installazione montascale","2022-05-21"),(4,"Lavoro concluso","2022-05-29");
      
INSERT INTO Preventivo(RIF_Forn,Valore)
VALUES (1,349),(2,490),(3,1245),(4,123),(1,876),(6,1879),(2,975),(5,1268);

-- QL
-- 1)Numero residenti in un condominio
SELECT Codice_Cond,NumResidenti FROM Condominio;  

-- 2)Dettaglio dei lavori richiesti dal Condominio con codice=2 (utilizzando vista)
CREATE VIEW DettaglioLavori AS 
SELECT Codice_Cond,Tipo_Lav
FROM Condominio JOIN Lavorazione ON Condominio.Codice_Cond=Lavorazione.RIF_Cond; 
                        
SELECT * FROM DettaglioLavori WHERE Codice_Cond=2;   

-- 3)Fornitori che hanno effettuato più lavori in tutti i condomini, ordinate per numero di lavorazioni
SELECT Nome_Forn,COUNT(*) AS NLavorazioni
FROM Fornitore JOIN Lavorazione ON Fornitore.ID_Forn=Lavorazione.RIF_Forn
GROUP BY (ID_Forn);

-- 4) Valore medio dei preventivi per una lavorazione
SELECT ID_Lav,AVG(Valore) AS PreventivoMedio
FROM Preventivo JOIN Fornitore ON Preventivo.RIF_Forn=Fornitore.ID_Forn
			    JOIN Lavorazione ON Fornitore.ID_Forn=Lavorazione.RIF_Forn
GROUP BY (ID_Lav);

-- 5)Costo totale dei lavori richiesti da un condominio
SELECT Codice_Cond,SUM(Valore)
FROM Condominio JOIN Lavorazione ON Condominio.Codice_Cond=Lavorazione.RIF_Cond
                JOIN Fornitore ON Lavorazione.RIF_Forn=Fornitore.ID_Forn
                JOIN Preventivo ON Fornitore.ID_Forn=Preventivo.RIF_Forn
GROUP BY (Codice_Cond);
                         
                         
                         
                   
                   