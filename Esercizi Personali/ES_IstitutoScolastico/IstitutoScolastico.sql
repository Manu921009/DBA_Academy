-- DDL 

DROP DATABASE IF EXISTS Istituto_Scol;
CREATE DATABASE Istituto_Scol;
USE Istituto_Scol;

CREATE TABLE Istituto(ID_Ist INTEGER PRIMARY KEY AUTO_INCREMENT, 
                      Nome_Ist VARCHAR(200) NOT NULL);

CREATE TABLE Indirizzo(ID_Ind INTEGER PRIMARY KEY AUTO_INCREMENT,
					   Tipo_Ind VARCHAR(200) NOT NULL UNIQUE);
                       
CREATE TABLE Aula(ID_Aula INTEGER PRIMARY KEY AUTO_INCREMENT,
				  Piano INTEGER NOT NULL,
                  ID_Ist INTEGER NOT NULL,
                  FOREIGN KEY (ID_Ist) REFERENCES Istituto(ID_Ist) ON DELETE CASCADE);

CREATE TABLE Classe(ID_Classe INTEGER PRIMARY KEY AUTO_INCREMENT,
					Anno INTEGER NOT NULL,
                    Sezione VARCHAR(200) NOT NULL,
                    ID_Ind INTEGER NOT NULL,
                    ID_Aula INTEGER NOT NULL,
                    FOREIGN KEY (ID_Ind) REFERENCES Indirizzo(ID_Ind) ON DELETE CASCADE,
                    FOREIGN KEY (ID_Aula) REFERENCES Aula(ID_Aula) ON DELETE CASCADE);
				
CREATE TABLE Docente(ID_Doc INTEGER PRIMARY KEY AUTO_INCREMENT,
                     Nome_Doc VARCHAR(200) NOT NULL,
                     Cognome_Doc VARCHAR(200) NOT NULL,
                     Email VARCHAR(200) NOT NULL);

CREATE TABLE Studente(Matricola INTEGER PRIMARY KEY AUTO_INCREMENT,
                      Nome_Stud VARCHAR(200) NOT NULL,
                      Cognome_Stud VARCHAR(200) NOT NULL,
                      Data_Nasc DATE,
                      Cellulare VARCHAR(200),
                      ID_Classe INTEGER NOT NULL,
                      FOREIGN KEY (ID_Classe) REFERENCES Classe(ID_Classe) ON DELETE CASCADE);
					  
CREATE TABLE Materia(ID_Doc INTEGER NOT NULL,
				     Matricola INTEGER NOT NULL,
				     Insegnamento VARCHAR(200) NOT NULL,
                     FOREIGN KEY (ID_Doc) REFERENCES Docente(ID_Doc) ON DELETE CASCADE,
                     FOREIGN KEY (Matricola) REFERENCES Studente(Matricola) ON DELETE CASCADE,
                     UNIQUE(ID_Doc,Matricola,Insegnamento));
                     
 CREATE TABLE Docente_Classe(ID_Doc INTEGER NOT NULL,
						     ID_Classe INTEGER NOT NULL,
							 FOREIGN KEY (ID_Doc) REFERENCES Docente(ID_Doc) ON DELETE CASCADE,
							 FOREIGN KEY (ID_Classe) REFERENCES Classe(ID_Classe) ON DELETE CASCADE,
				             UNIQUE(ID_Doc,ID_Classe));
                               
  CREATE TABLE Istituto_Indirizzo(ID_Ist INTEGER NOT NULL,
                                  ID_Ind INTEGER NOT NULL,
                                  FOREIGN KEY (ID_Ist) REFERENCES Istituto(ID_Ist) ON DELETE CASCADE,
                                  FOREIGN KEY (ID_Ind) REFERENCES Indirizzo(ID_Ind) ON DELETE CASCADE,
                                  UNIQUE(ID_Ist,ID_Ind));
                               
-- DML

INSERT INTO Istituto(Nome_Ist) VALUE ("Alberghetti"),("Manzoni");
INSERT INTO Indirizzo(Tipo_Ind) VALUE ("Scientifico"),("Classico"),("Tecnico");
INSERT INTO Aula(Piano,ID_Ist) VALUE (1,2),(2,1),(1,1),(2,2);
INSERT INTO Classe(Anno,Sezione,ID_Ind,ID_Aula) VALUE (1,"B",2,3),(2,"C",1,4),(4,"A",3,2);
INSERT INTO Docente(Nome_Doc,Cognome_Doc,Email) VALUE ("Mario","Rossi","m.rossi@bo.it"),
                                                      ("Gennaro","Esposito","g.esposito@bo.it"),
													  ("Francesco","Neri","f.neri@bo.it");
INSERT INTO Studente(Nome_Stud,Cognome_Stud,Data_Nasc,Cellulare,ID_Classe) 
			   VALUE("Luca","Bianchi","2003-04-21","334674",3),
					("Giuseppe","Verdi","2005-11-30","189045",2),
                    ("Antonio","Rossini","2006-07-23","671022",1);
                    
SELECT * FROM Istituto;    
SELECT * FROM Indirizzo;
SELECT * FROM Aula;
SELECT * FROM Classe;
SELECT * FROM Docente;
SELECT * FROM Studente;

















