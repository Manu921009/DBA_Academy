-- DDL
DROP DATABASE IF EXISTS Dietologo;
CREATE DATABASE Dietologo;
USE Dietologo;

CREATE TABLE Cliente(ID_Cl INTEGER PRIMARY KEY AUTO_INCREMENT,
                     Nome_Cl VARCHAR(250) NOT NULL,
                     Cognome_Cl VARCHAR(250) NOT NULL,
                     CF VARCHAR(16) NOT NULL UNIQUE,
                     Indirizzo VARCHAR(250) NOT NULL);
                     
CREATE TABLE Controllo(ID_Contr INTEGER PRIMARY KEY AUTO_INCREMENT,
					   RIF_Cl INTEGER NOT NULL,
					   Data_Contr DATE,
                       Esito_Contr VARCHAR(250) NOT NULL,
                       FOREIGN KEY (RIF_Cl) REFERENCES Cliente(ID_Cl) ON DELETE CASCADE);  
                       
CREATE TABLE Visita(ID_Vis INTEGER PRIMARY KEY AUTO_INCREMENT,
					RIF_Cl INTEGER NOT NULL,
					Data_Vis DATE,
                    Esito_Vis VARCHAR(250) NOT NULL,
                    FOREIGN KEY (RIF_Cl) REFERENCES Cliente(ID_Cl) ON DELETE CASCADE);
                    
CREATE TABLE Dieta(ID_Dieta INTEGER PRIMARY KEY AUTO_INCREMENT,
                   RIF_Vis INTEGER NOT NULL,
                   Data_Iniz DATE, 
                   Data_Fine DATE,
                   FOREIGN KEY (RIF_Vis) REFERENCES Visita(ID_Vis) ON DELETE CASCADE);
                   
CREATE TABLE Ricetta(ID_Ricetta INTEGER PRIMARY KEY AUTO_INCREMENT,
                     Nome_Ricetta VARCHAR(250) NOT NULL); 
                     
CREATE TABLE Ingrediente(Codice INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
                         Nome_Ingr VARCHAR(250) NOT NULL,
                         Tipo VARCHAR(250) NOT NULL,
                         Calorie_100g INTEGER NOT NULL,
                         Carb_100g DECIMAL (4,2) NOT NULL,
                         Grassi_100g DECIMAL (4,2) NOT NULL,
                         Proteine_100g DECIMAL (4,2) NOT NULL);
                         
CREATE TABLE Ricetta_Ingrediente(RIF_Ricetta INTEGER NOT NULL,
                                 RIF_Ingr INTEGER NOT NULL,
                                 Qta_Ingr INTEGER NOT NULL,
								 FOREIGN KEY (RIF_Ricetta) REFERENCES Ricetta(ID_Ricetta) ON DELETE CASCADE,
								 FOREIGN KEY (RIF_Ingr) REFERENCES Ingrediente(Codice) ON DELETE CASCADE);
                                 
CREATE TABLE Pasto(ID_Pasto INTEGER PRIMARY KEY AUTO_INCREMENT,
                   RIF_Dieta INTEGER NOT NULL,
                   RIF_Ricetta INTEGER NOT NULL,
				   Nome_Pasto VARCHAR(250) NOT NULL,
                   Descr_Pasto VARCHAR(250),
                   Qta_Pasto INTEGER NOT NULL,
                   FOREIGN KEY (RIF_Dieta) REFERENCES Dieta(ID_Dieta) ON DELETE CASCADE,
                   FOREIGN KEY (RIF_Ricetta) REFERENCES Ricetta(ID_Ricetta) ON DELETE CASCADE);
                   
CREATE TABLE Giornata(ID_Giorno INTEGER PRIMARY KEY AUTO_INCREMENT, 
                      Giorno VARCHAR(250) NOT NULL);
                     
CREATE TABLE Pasto_Giornata(RIF_Pasto INTEGER NOT NULL,
                            RIF_Giorno INTEGER NOT NULL,
                            Intervallo VARCHAR(250) NOT NULL,
                            FOREIGN KEY (RIF_Pasto) REFERENCES Pasto(ID_Pasto) ON DELETE CASCADE,
                            FOREIGN KEY (RIF_Giorno) REFERENCES Giornata(ID_Giorno) ON DELETE CASCADE,
                            UNIQUE(RIF_Pasto,RIF_Giorno,Intervallo));
                            
CREATE TABLE Categoria(ID_Cat INTEGER PRIMARY KEY AUTO_INCREMENT,
                       Tipo VARCHAR(250) NOT NULL);
                       
CREATE TABLE Pasto_Categoria(RIF_Pasto INTEGER NOT NULL,
                             RIF_Cat INTEGER NOT NULL,
                             FOREIGN KEY (RIF_Pasto) REFERENCES Pasto(ID_Pasto) ON DELETE CASCADE,
                             FOREIGN KEY (RIF_Cat) REFERENCES Categoria(ID_Cat) ON DELETE CASCADE,
                             UNIQUE(RIF_Pasto,RIF_Cat));
                             
-- DML
INSERT INTO Cliente(Nome_Cl,Cognome_Cl,CF,Indirizzo)
VALUES ("Maria","Rossi","RSSMRA","Via Mazzini, 23"),
       ("Giuseppe","Verdi","VRDGSP","Via Aida, 67"),
       ("Gennaro","Esposito","SPSGNN","Via Toledo, 9"),
       ("Antonio","Bianchi","BNCNTN","Via Roma, 230"),
       ("Marco","Torrini","TRRMRC","Corso Como, 136"),
       ("Laura","Moscato","MSCLRA","Viale Amendola, 54");
       
INSERT INTO Controllo(RIF_Cl,Data_Contr,Esito_Contr) 
VALUES (2,"2022-03-15","OK"),(4,"2022-03-16","OK"),(6,"2022-03-18","OK"),(2,"2022-06-15","OK"),(4,"2022-08-16","OK"),(6,"2022-09-18","OK"),(1,"2022-09-23","OK"); 
                   
INSERT INTO Visita(RIF_Cl,Data_Vis,Esito_Vis) 
VALUES (3,"2022-04-10","Dieta"),(1,"2022-04-22","Dieta"),(5,"2022-05-02","Dieta");

INSERT INTO Dieta(RIF_Vis,Data_Iniz,Data_Fine)
VALUES (1,"2022-04-11","2022-10-10"),(2,"2022-04-23","2022-09-22"),(3,"2022-05-03","2022-11-26");   

INSERT INTO Ricetta(Nome_Ricetta) 
VALUES ("Riso in bianco"),("Pasta integrale al sugo"),("Latte magro"),("Scaloppine di pollo"),("Fette biscottate"),("Mela");

INSERT INTO Ingrediente(Nome_Ingr,Tipo,Calorie_100g,Carb_100g,Grassi_100g,Proteine_100g)
VALUES ("Riso","Cereale",350,70.5,2.4,8.8),("Pasta integrale","Cereale",335,60.4,2.5,12.5),("Passata pomodoro","Ortaggio",20,9.0,0.4,1.9),("Pollo","Carne",190,5.5,1.9,14.5);

INSERT INTO Ricetta_Ingrediente(RIF_Ricetta,RIF_Ingr,Qta_Ingr)
VALUES (1,1,100),(2,2,80),(2,3,100),(6,4,150);

INSERT INTO Pasto(RIF_Dieta,RIF_Ricetta,Nome_Pasto,Descr_Pasto,Qta_Pasto)
VALUES(1,1,"Riso bianco","",100),(1,2,"Pasta integrale","",80),(2,1,"Riso non condito","",80),(2,4,"Scaloppine","",150);

INSERT INTO Giornata(Giorno)
VALUES ("Lunedi"),("Martedi"),("Mercoledi"),("Giovedi"),("Venerdi"),("Sabato"),("Domenica");

INSERT INTO Pasto_Giornata(RIF_Pasto,RIF_Giorno,Intervallo)
VALUES (1,1,"Pranzo"),(1,2,"Pranzo"),(1,3,"Pranzo"),(2,4,"Pranzo"),(3,5,"Pranzo"),(4,1,"Cena"),(4,5,"Cena");

INSERT INTO Categoria(Tipo)
VALUES ("Senza Glutine"),("Senza Lattosio"),("Vegano"),("Vegetariano");

INSERT INTO Pasto_Categoria(RIF_Pasto,RIF_Cat)
VALUES (1,1),(1,2),(1,3),(1,4),(2,1),(2,2),(2,3),(2,4),(3,1),(3,2),(3,3),(3,4),(4,1),(4,2);

-- QL 
-- 1)Visualizza tutte le visite del paziente selezionato tramite codice fiscale effettuate in un dato intervallo temporale ordinate per data crescente
SELECT CF,Data_Vis 
FROM Cliente JOIN Visita ON Cliente.ID_Cl=Visita.RIF_Cl
WHERE CF="SPSGNN" AND Data_Vis BETWEEN "2022-01-01" AND "2022-12-31"
ORDER BY Data_Vis ASC;

-- 2)Visualizza visite di controllo oppure di emissione di una nuova dieta del paziente selezionato tramite codice fiscale in un dato intervallo di tempo
SELECT CF,Data_Vis,Data_Contr
FROM Cliente JOIN Visita ON Cliente.ID_Cl=Visita.RIF_Cl
			 JOIN Controllo ON Cliente.ID_Cl=Controllo.RIF_Cl
WHERE CF="RSSMRA" AND Data_Vis BETWEEN "2022-01-01" AND "2022-12-31"
                  OR Data_Contr BETWEEN "2022-01-01" AND "2022-12-31";
                  
-- 7) Conta i Carboidrati, Grassi e Proteine del pasto selezionato
SELECT Nome_Pasto,Carb_100g,Grassi_100g,Proteine_100g 
FROM Pasto JOIN Ricetta ON Pasto.RIF_Ricetta=Ricetta.ID_Ricetta
           JOIN Ricetta_Ingrediente ON Ricetta.ID_Ricetta=Ricetta_Ingrediente.RIF_Ricetta
           JOIN Ingrediente ON Ricetta_Ingrediente.RIF_Ingr=Ingrediente.Codice
WHERE Nome_Pasto="Riso bianco";

                  
                   
                    
		             
					