DROP DATABASE IF EXISTS E_Learning;
CREATE DATABASE E_Learning;
USE E_Learning;

CREATE TABLE Studente(Matricola INTEGER PRIMARY KEY AUTO_INCREMENT,
                      Nome_Stud VARCHAR(200) NOT NULL,
                      Cognome_Stud VARCHAR(200) NOT NULL,
                      Data_Nasc DATE,
                      Cellulare INTEGER,
                      Email VARCHAR(200));
                            
CREATE TABLE Corso(Cod_Corso INTEGER PRIMARY KEY AUTO_INCREMENT, 
                   Tit_Corso VARCHAR(200) NOT NULL,
                   Crediti INTEGER NOT NULL DEFAULT 1);
                   
CREATE TABLE Lezione(ID_Lezione INTEGER PRIMARY KEY AUTO_INCREMENT, 
                     Tit_Lezione VARCHAR(200) NOT NULL,
                     Contenuto TEXT,
                     RIF_Corso INTEGER NOT NULL,
                     FOREIGN KEY(RIF_Corso) REFERENCES Corso(Cod_Corso) ON DELETE CASCADE);
                     
CREATE TABLE Esame(ID_Esame INTEGER PRIMARY KEY AUTO_INCREMENT, 
	               Tit_Esame VARCHAR(200) NOT NULL,
                   RIF_Corso INTEGER NOT NULL,
                   FOREIGN KEY(RIF_Corso) REFERENCES Corso(Cod_Corso) ON DELETE CASCADE);
                   
CREATE TABLE Studente_Corso(RIF_Studente INTEGER NOT NULL,
							RIF_Corso INTEGER NOT NULL,
                            FOREIGN KEY(RIF_Studente) REFERENCES Studente(Matricola) ON DELETE CASCADE ,
                            FOREIGN KEY(RIF_Corso) REFERENCES Corso(Cod_Corso) ON DELETE CASCADE);
                            
CREATE TABLE Studente_Lezione(RIF_Studente INTEGER NOT NULL,
                              RIF_Lezione INTEGER NOT NULL,
                              DataCompletamento DATETIME,
                              FOREIGN KEY(RIF_Studente) REFERENCES Studente(Matricola) ON DELETE CASCADE,
                              FOREIGN KEY(RIF_Lezione) REFERENCES Lezione(ID_Lezione) ON DELETE CASCADE);
                              
CREATE TABLE Studente_Esame(RIF_Studente INTEGER NOT NULL,
                            RIF_Esame INTEGER NOT NULL,
                            Esito VARCHAR(10) NOT NULL,
                            FOREIGN KEY(RIF_Studente) REFERENCES Studente(Matricola) ON DELETE CASCADE,
                            FOREIGN KEY(RIF_Esame) REFERENCES Esame(ID_Esame) ON DELETE CASCADE);
                            
CREATE TABLE Certificato(Codice INTEGER PRIMARY KEY AUTO_INCREMENT,
                         RIF_Studente INTEGER NOT NULL,
                         RIF_Corso INTEGER NOT NULL,
                         DataRilascio DATETIME,
                         FOREIGN KEY(RIF_Studente) REFERENCES Studente(Matricola) ON DELETE CASCADE,
                         FOREIGN KEY(RIF_Corso) REFERENCES Corso(Cod_Corso) ON DELETE CASCADE);
                         
CREATE TABLE Domanda(Cod_Domanda INTEGER PRIMARY KEY AUTO_INCREMENT,
					 RIF_Esame INTEGER NOT NULL,
                     Testo_Domanda TEXT,
                     FOREIGN KEY(RIF_Esame) REFERENCES Esame(ID_Esame) ON DELETE CASCADE);
                     
CREATE TABLE Risposta(Cod_Risposta INTEGER PRIMARY KEY AUTO_INCREMENT,
					  RIF_Domanda INTEGER NOT NULL,
                      Testo_Risposta TEXT,
                      Giusta BOOLEAN,
                      FOREIGN KEY (RIF_Domanda) REFERENCES Domanda(Cod_Domanda) ON DELETE CASCADE);
                      
                      
                     
                     
               