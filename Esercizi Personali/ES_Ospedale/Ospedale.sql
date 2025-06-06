-- DDL
DROP DATABASE IF EXISTS Ospedale;
CREATE DATABASE Ospedale;
USE Ospedale;

CREATE TABLE Paziente(CodPaz INTEGER PRIMARY KEY,
					  Nome VARCHAR(250),
                      Cognome VARCHAR(250),
                      CF VARCHAR(16) UNIQUE,
                      DataNasc DATE,
                      LuogoNasc VARCHAR(250),
                      Sesso VARCHAR(1) NOT NULL);
                      
CREATE TABLE Reparto(IDRep INTEGER PRIMARY KEY AUTO_INCREMENT,
                     Nome VARCHAR(250) NOT NULL UNIQUE);
                     
CREATE TABLE Paziente_Reparto(RIFPaz INTEGER NOT NULL,
                              RIFRep INTEGER NOT NULL,
                              DataRic DATETIME DEFAULT CURRENT_TIMESTAMP ,
							  FOREIGN KEY (RIFPaz) REFERENCES Paziente(CodPaz) ON DELETE CASCADE,
                              FOREIGN KEY (RIFRep) REFERENCES Reparto(IDRep) ON DELETE CASCADE
                              );
                              
CREATE TABLE Medico(CodMed INTEGER PRIMARY KEY,
					RIFRep INTEGER NOT NULL,
					Nome VARCHAR(250) NOT NULL,
					Cognome VARCHAR(250) NOT NULL,
					DataNasc DATE,
					LuogoNasc VARCHAR(250) NOT NULL,
                    FOREIGN KEY (RIFRep) REFERENCES Reparto(IDRep) ON DELETE CASCADE);
                    
CREATE TABLE Visita(IDVis INTEGER PRIMARY KEY AUTO_INCREMENT,
                    RIFPaz INTEGER NOT NULL,
					RIFMed INTEGER NOT NULL,
					DataVis DATETIME,
                    Esito VARCHAR(250) NOT NULL,
					FOREIGN KEY (RIFPaz) REFERENCES Paziente(CodPaz) ON DELETE CASCADE,
					FOREIGN KEY (RIFMed) REFERENCES Medico(CodMed) ON DELETE CASCADE); 
                    				      
CREATE TABLE Esame(IDEsame INTEGER PRIMARY KEY AUTO_INCREMENT, 
                   RIFPaz INTEGER NOT NULL,  
                   TipoEsame VARCHAR(250) NOT NULL,
                   DataEsame DATETIME DEFAULT CURRENT_TIMESTAMP,
                   Esito VARCHAR(250) NOT NULL,
                   FOREIGN KEY (RIFPaz) REFERENCES Paziente(CodPaz) ON DELETE CASCADE);
                    
                              
                              
                              
                              
                      
                      
                      

