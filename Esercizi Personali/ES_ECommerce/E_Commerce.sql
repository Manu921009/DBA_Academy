DROP DATABASE IF EXISTS ECommerce;
CREATE DATABASE ECommerce;
USE ECommerce;

CREATE TABLE Utente(ID_Utente INTEGER PRIMARY KEY AUTO_INCREMENT,
                    Nominativo VARCHAR(200) NOT NULL,
                    CF VARCHAR(16) NOT NULL UNIQUE,
                    DataNasc DATE);
                    
CREATE TABLE Ordine(ID_Ordine INTEGER PRIMARY KEY AUTO_INCREMENT,
                    RIF_Utente INTEGER NOT NULL,
                    DataOrdine DATETIME DEFAULT CURRENT_TIMESTAMP,
                    TipoPagamento VARCHAR(200) DEFAULT "Contanti",
                    FOREIGN KEY (RIF_Utente) REFERENCES Utente(ID_Utente) ON DELETE CASCADE);
                                             
CREATE TABLE NFT(Codice_NFT INTEGER PRIMARY KEY AUTO_INCREMENT,
                 RIF_Ordine INTEGER,
                 Nome_NFT VARCHAR(200) NOT NULL,
                 Prezzo DECIMAL(10,2),
                 FOREIGN KEY (RIF_Ordine) REFERENCES Ordine(ID_Ordine) ON DELETE SET NULL);
                 
CREATE TABLE Categoria(Codice_Cat INTEGER PRIMARY KEY AUTO_INCREMENT,
                       Nome_Cat VARCHAR(200) NOT NULL);
                       
CREATE TABLE NFT_Categoria(RIF_Cat INTEGER NOT NULL,
                           RIF_NFT INTEGER NOT NULL,
                           FOREIGN KEY (RIF_Cat) REFERENCES Categoria(Codice_Cat) ON DELETE CASCADE,
                           FOREIGN KEY (RIF_NFT) REFERENCES NFT(Codice_NFT) ON DELETE CASCADE,
                           UNIQUE (RIF_Cat,RIF_NFT));
                           
                           
                           
                           
                       
					   
