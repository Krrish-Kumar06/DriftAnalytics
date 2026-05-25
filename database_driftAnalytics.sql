CREATE DATABASE IF NOT EXISTS DriftAnalytics;
USE DriftAnalytics;


CREATE TABLE `Analisi` (
  `id` int NOT NULL,
  `idSessione` int NOT NULL
);


CREATE TABLE `Citta` (
  `cap` int NOT NULL,
  `nome` varchar(255) NOT NULL,
  `provincia` varchar(255) NOT NULL,
  `regione` varchar(255) NOT NULL
) ;


CREATE TABLE `Dati_Telemetrici` (
  `id` int NOT NULL,
  `velocita` decimal(5,2) NOT NULL,
  `angolo_derapata` decimal(6,2) NOT NULL,
  `accelerazione_laterale` decimal(5,2) NOT NULL,
  `accelerazione_longitudinale` decimal(5,2) NOT NULL,
  `yaw_rate` decimal(6,2) NOT NULL,
  `latitudine` decimal(9,6) NOT NULL,
  `longitudine` decimal(9,6) NOT NULL,
  `timestamp` datetime NOT NULL,
  `idSensore` int NOT NULL,
  `idSessione` int NOT NULL
) ;


CREATE TABLE `Pista` (
  `id` int NOT NULL,
  `nome` varchar(255) NOT NULL,
  `lunghezza` decimal(5,2) NOT NULL,
  `descrizione` text,
  `capCitta` int NOT NULL
) ;


CREATE TABLE `Possedere` (
  `id` int NOT NULL,
  `idUtente` int NOT NULL,
  `idVeicolo` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `Sensore` (
  `id` int NOT NULL,
  `tipo` varchar(255) NOT NULL,
  `descrizione` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `Sessione` (
  `id` int NOT NULL,
  `data` datetime NOT NULL,
  `durata` int NOT NULL,
  `idUtente` int NOT NULL,
  `idPista` int NOT NULL,
  `idVeicolo` int NOT NULL
) ;


CREATE TABLE `Utente` (
  `id` int NOT NULL,
  `nome` varchar(255) NOT NULL,
  `cognome` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `capCitta` int NOT NULL,
  `pin` varchar(6) NOT NULL DEFAULT '',
  `email_verificata` tinyint(1) NOT NULL DEFAULT '0',
  `token_verifica` varchar(64) DEFAULT NULL,
  `token_scadenza` datetime DEFAULT NULL
);


CREATE TABLE `Veicolo` (
  `id` int NOT NULL,
  `marca` varchar(255) NOT NULL,
  `modello` varchar(255) NOT NULL,
  `anno` int NOT NULL,
  `potenza` int NOT NULL
) ;
