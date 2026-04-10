CREATE DATABASE IF NOT EXISTS DriftAnalytics;
USE DriftAnalytics;

CREATE TABLE Team (
    id INT(5) AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE Citta (
    cap INT(5) PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    provincia VARCHAR(255) NOT NULL,
    regione VARCHAR(255) NOT NULL
);

CREATE TABLE Sensore (
    id INT(5) AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(255) NOT NULL,
    descrizione TEXT -- per testi lunghi
);

CREATE TABLE Veicolo (
    id INT(5) AUTO_INCREMENT PRIMARY KEY,
    marca VARCHAR(255) NOT NULL,
    modello VARCHAR(255) NOT NULL,
    anno INT(4) NOT NULL CHECK (anno > 1900), -- anno di produzione (YYYY)
    potenza INT(5) NOT NULL CHECK (potenza > 0) -- potenza del veicolo in cavalli (CV)
);

CREATE TABLE Pista (
    id INT(5) AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    lunghezza DECIMAL(5,2) NOT NULL CHECK (lunghezza > 0), -- lunghezza pista in metri (m)
    descrizione TEXT,
    capCitta INT(5) NOT NULL,
    FOREIGN KEY (capCitta) REFERENCES Citta(cap)
        ON UPDATE CASCADE
        ON DELETE RESTRICT -- impedisce l'eliminazione di una città se esistono piste collegate alla città
);

CREATE TABLE Utente (
    id INT(5) AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cognome VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    ruolo VARCHAR(100) NOT NULL,
    capCitta INT(5) NOT NULL,
    idTeam INT(5),
    FOREIGN KEY (capCitta) REFERENCES Citta(cap)
        ON UPDATE CASCADE
        ON DELETE RESTRICT, -- una città non può essere cancellata se esistono utenti che vivono nella città
    FOREIGN KEY (idTeam) REFERENCES Team(id)
        ON UPDATE CASCADE
        ON DELETE SET NULL ù
);

CREATE TABLE Possedere (
    id INT(5) AUTO_INCREMENT PRIMARY KEY,
    idUtente INT(5) NOT NULL,
    idVeicolo INT(5) NOT NULL,
    FOREIGN KEY (idUtente) REFERENCES Utente(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE, 
    FOREIGN KEY (idVeicolo) REFERENCES Veicolo(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE 
);

CREATE TABLE Sessione (
    id INT(5) AUTO_INCREMENT PRIMARY KEY,
    data DATETIME NOT NULL,
    durata INT(5) NOT NULL CHECK (durata > 0), -- durata della sessione in minuti
    idUtente INT(5) NOT NULL,
    idPista INT(5) NOT NULL,
    idVeicolo INT(5) NOT NULL,
    FOREIGN KEY (idUtente) REFERENCES Utente(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (idPista) REFERENCES Pista(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT, -- una pista non può essere eliminata se è stata usata in una sessione
    FOREIGN KEY (idVeicolo) REFERENCES Veicolo(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE Dati_Telemetrici (
    id INT(5) AUTO_INCREMENT PRIMARY KEY,
    velocita DECIMAL(5,2) NOT NULL, -- velocità del veicolo in km/h (rilevata da GPS)
    angolo_derapata DECIMAL(6,2) NOT NULL,-- angolo di derapata in gradi , rilevato dal giroscopio
    accelerazione_laterale DECIMAL(5,2) NOT NULL,-- accelerazione laterale in m/s² (forza G laterale)
    accelerazione_longitudinale DECIMAL(5,2) NOT NULL, -- accelerazione avanti/indietro in m/s²
    yaw_rate DECIMAL(6,2) NOT NULL, -- velocità di rotazione sull'asse verticale in gradi al secondo (°/s)
    latitudine DECIMAL(9,6) NOT NULL,-- coordinata GPS: latitudine in gradi decimali
    longitudine DECIMAL(9,6) NOT NULL,-- coordinata GPS: longitudine in gradi decimali
    timestamp DATETIME NOT NULL,--memorizza una data e un orario
    idSensore INT(5) NOT NULL,
    idSessione INT(5) NOT NULL,
    FOREIGN KEY (idSensore) REFERENCES Sensore(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT, -- un sensore non può essere eliminato se ha generato dati
    FOREIGN KEY (idSessione) REFERENCES Sessione(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE 
);


CREATE TABLE Analisi (
    id INT(5) AUTO_INCREMENT PRIMARY KEY,
    punteggio_generato DECIMAL(5,2) NOT NULL, 
    commenti TEXT,
    idSessione INT(5) NOT NULL UNIQUE,
    FOREIGN KEY (idSessione) REFERENCES Sessione(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
