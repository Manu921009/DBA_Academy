-- DDL

DROP DATABASE IF EXISTS Azienda_manif;
CREATE DATABASE Azienda_manif;
USE Azienda_manif;

CREATE TABLE Prodotto(ID_Pr INTEGER PRIMARY KEY AUTO_INCREMENT,
                      Nome_Pr VARCHAR(200) NOT NULL,
                      Quant_Disp INTEGER CHECK(Quant_Disp >=0));
                      
CREATE TABLE Fornitore(ID_Forn INTEGER PRIMARY KEY AUTO_INCREMENT,
					   Nome_Forn VARCHAR(200) NOT NULL,     
					   Stabilimento VARCHAR(200) NOT NULL); 
                       
CREATE TABLE Componente(ID_Comp INTEGER PRIMARY KEY AUTO_INCREMENT,
                        Nome_Comp VARCHAR(200) NOT NULL,     
                        Descrizione VARCHAR(200),
                        Costo_Comp INTEGER NOT NULL,
                        Prezzo_Comp INTEGER NOT NULL);
                       
CREATE TABLE Componente_Fornitore(ID_Comp INTEGER NOT NULL,
								  ID_Forn INTEGER NOT NULL,
                                  FOREIGN KEY (ID_Comp) REFERENCES Componente(ID_Comp) ON DELETE CASCADE,
							      FOREIGN KEY (ID_Forn) REFERENCES Fornitore(ID_Forn) ON DELETE CASCADE,
								  UNIQUE(ID_Comp,ID_Forn));
                                  
CREATE TABLE Componente_Prodotto(ID_Comp INTEGER NOT NULL,
                                 ID_Pr INTEGER NOT NULL,
								 FOREIGN KEY (ID_Comp) REFERENCES Componente(ID_Comp) ON DELETE CASCADE,
								 FOREIGN KEY (ID_Pr) REFERENCES Prodotto(ID_Pr) ON DELETE CASCADE,
								 UNIQUE(ID_Comp,ID_Pr));                                                  -- va messa quantità per ogni componente
							
-- DML

INSERT INTO Fornitore(Nome_Forn,Stabilimento) 
VALUE ("Arco Colombo","Milano"),("Torre di Babele","Torino"),("Il Rinascimento","Firenze"),("Er Capitale","Roma"),("F.lli Esposito","Napoli");

INSERT INTO Componente(Nome_Comp,Descrizione,Costo_Comp,Prezzo_Comp) 
VALUE ("Farina 00","Adatta per dolci",340650,539850),("Farina Integrale","Ricca di fibre",52000,87500),("Maizena","Amido di Mais",9500,13000),
      ("Farina di Mandorle","",38000,54250),("Uova","Da galline allevate all'aperto",280500,461300),("Latte","Latte parzialmente scremato UHT",128500,210000),
      ("Panna","",12300,18900),("Burro","Grasso animale",15800,21350),("Olio di semi","Ricavato da girasole",9350,16200),("Zucchero","Da Barbabietole",245000,354000),
      ("Zucchero di Canna","",65700,92400),("Miele","Prodotto dalle api",29780,44025),("Cacao","Gocce di cioccolato",4935,7150),
      ("Cioccolato","Ricavato dalla pianta di cacao",3035,4650),("Nocciole","Nocciole DOC",3890,5680),("Lievito","Adatto per dolci",38950,49450),("Sale","",900,1350),
      ("Amido di Frumento","Ricavato dal Frumento",2050,2900),("Aromi","Aromi per dolci",2300,3400),("Sciroppo di glucosio","",950,1510);
      
INSERT INTO Prodotto(Nome_Pr,Quant_Disp) 
VALUE ("Ciambelle Panna e Cioccolato",3250),("Gocciole",4300),("Pan di stelle",5200),("Amaretti",2550),("Frollini al miele",1800),("Frollini integrali",3835),
      ("Frollini con zucchero di canna",1450),("Biscotti Danesi",3400),("Galletti",5680);
      
INSERT INTO Componente_Prodotto(ID_Pr,ID_Comp)
VALUE (1,1),(1,9),(1,10),(1,5),(1,7),(1,8),(1,16),(1,17),(1,18),(1,19),(2,1),(2,9),(2,10),(2,8),(2,14),(2,20),(2,16),(2,17),(2,18),(2,19),
	  (3,1),(3,3),(3,5),(3,6),(3,8),(3,9),(3,10),(3,12),(3,13),(3,14),(3,15),(3,16),(3,17),(3,18),(3,19),(3,20),(4,4),(4,5),(4,10),(4,16),(4,19),
      (5,1),(5,10),(5,9),(5,12),(5,16),(5,17),(5,19),(6,2),(6,10),(6,11),(6,9),(6,6),(6,5),(6,16),(6,17),(6,19),
      (7,1),(7,10),(7,9),(7,11),(7,6),(7,16),(7,17),(7,18),(7,19),(7,20),(8,1),(8,8),(8,5),(8,10),(8,16),(8,17),(8,19),
      (9,1),(9,9),(9,10),(9,6),(9,16),(9,17),(9,18),(9,19),(9,12);
      
INSERT INTO Componente_Fornitore(ID_Forn,ID_Comp)
VALUE (1,6),(1,7),(1,8),(1,9),(2,10),(2,11),(2,12),(4,3),(4,4),(4,5),(4,13),(4,14),(4,15),(4,16),(4,17),(4,19),(4,20),(5,1),(5,2),(5,18);  

-- QL
-- 1)
SELECT Nome_Comp,Stabilimento FROM Componente C                                                                  
							  JOIN Componente_Fornitore CF ON C.ID_Comp=CF.ID_Comp   
                              JOIN Fornitore F ON CF.ID_Forn=F.ID_Forn
                              WHERE Stabilimento IN ("Milano","Torino");
-- 2)						
SELECT Nome_Forn,SUM(Prezzo_Comp-Costo_Comp) Profitto_Forn,COUNT(CF.ID_Forn) NComp 
FROM Fornitore F JOIN Componente_Fornitore CF ON F.ID_Forn=CF.ID_Forn
                  JOIN Componente C ON CF.ID_Comp=C.ID_Comp
GROUP BY(CF.ID_Forn) HAVING Profitto_Forn > 200000 AND NComp <10;        
