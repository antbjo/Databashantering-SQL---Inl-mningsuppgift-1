-- Startskript som skapar en ny databas om den redan finns!
USE MASTER;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE NAME = 'FailSafeIT_Inlämningsuppgift1')
BEGIN
    ALTER DATABASE FailSafeIT_Inlämningsuppgift1 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE FailSafeIT_Inlämningsuppgift1;
END
GO

CREATE DATABASE FailSafeIT_Inlämningsuppgift1
GO

USE FailSafeIT_Inlämningsuppgift1
GO

PRINT 'Databasen är skapad!'
GO

-- Tar bort tabeller om de redan finns!
DROP TABLE IF EXISTS Kunder;
DROP TABLE IF EXISTS Konsulter;
DROP TABLE IF EXISTS Uppdrag;
GO

-- Skapa tabellerna:
CREATE TABLE [Kunder] (
  [Id] INT IDENTITY (1,1) NOT NULL,
  [OrganisationsNummer] INT UNIQUE NOT NULL,
  [FöretagsNamn] NVARCHAR(100) UNIQUE NOT NULL,
  [Epost] NVARCHAR(250) UNIQUE NOT NULL,
  [TelefonNummer] NVARCHAR(25) UNIQUE NOT NULL,
  PRIMARY KEY ([Id])
);

CREATE TABLE [Konsulter] (
  [Id] INT IDENTITY (1,1) NOT NULL,
  [PersonNummer] NVARCHAR(25) UNIQUE NOT NULL,
  [Namn] NVARCHAR(100) NOT NULL,
  [TimPris] INT NOT NULL,
  [Specialitet] NVARCHAR(100) NOT NULL,
  PRIMARY KEY ([Id])
);

CREATE TABLE [Uppdrag] (
  [Id] INT IDENTITY (1,1) NOT NULL,
  [StartDatum] DATE NOT NULL,           -- Använder DATE för att bara visa datumet och inte klockslag.
  [SlutDatum] DATE NOT NULL,
  [RollBeskrivning] NVARCHAR(100),
  [KonsultId] INT,
  [KundId] INT,
  PRIMARY KEY ([Id]),
  CONSTRAINT [FK_Uppdrag_KundId]
    FOREIGN KEY ([KundId])
      REFERENCES [Kunder]([Id]),
  CONSTRAINT [FK_Uppdrag_KonsultID]
    FOREIGN KEY ([KonsultID])
      REFERENCES [Konsulter]([Id])
);

-- Testdata genererad i Mockaroo som jag redigerat lite
insert into Kunder (OrganisationsNummer, FöretagsNamn, Epost, TelefonNummer) values ('320266480', 'Trilith', 'cfarbrace0@trilith.com', '0791112233');
insert into Kunder (OrganisationsNummer, FöretagsNamn, Epost, TelefonNummer) values ('863449130', 'Livepath', 'ncaccavari1@livepath.tv', '0712223311');
insert into Kunder (OrganisationsNummer, FöretagsNamn, Epost, TelefonNummer) values ('649139304', 'Yodoo', 'eblagdon2@yodoo.org', '0721231212');
insert into Kunder (OrganisationsNummer, FöretagsNamn, Epost, TelefonNummer) values ('729884241', 'Jazzy', 'dcreed3@jazzy.com', '0730001122');
insert into Kunder (OrganisationsNummer, FöretagsNamn, Epost, TelefonNummer) values ('916608796', 'Feedfire', 'eforcade4@feedfire.com', '0763211231');

insert into Konsulter (PersonNummer, Namn, TimPris, Specialitet) values ('880302-1234', 'Neville Snoxell', 1800, 'Lösningsarkitekt');
insert into Konsulter (PersonNummer, Namn, TimPris, Specialitet) values ('690531-4321', 'Sybille Cay', 1350, 'Cybersäkerhet');
insert into Konsulter (PersonNummer, Namn, TimPris, Specialitet) values ('860804-2143', 'Eugenio De La Coste', 1000, 'C#-utvecklare');
insert into Konsulter (PersonNummer, Namn, TimPris, Specialitet) values ('001210-1122', 'Georgianne Braybrookes', 1250, 'DevOps');
insert into Konsulter (PersonNummer, Namn, TimPris, Specialitet) values ('910523-0031', 'Sissy Anand', 1150, 'DevOps');

-- Dålig koll på vad eventuella rollbeskrivningar skulle kunna heta, så jag tog hjälp av AI att generera rollbeskrivningar.
INSERT INTO Uppdrag (StartDatum, SlutDatum, RollBeskrivning, KonsultId, KundId) VALUES ('2026-11-27', '2026-12-10', 'Säkerhetsgranskning av API-miljö', 2, 4)
INSERT INTO Uppdrag (StartDatum, SlutDatum, RollBeskrivning, KonsultId, KundId) VALUES ('2026-11-13', '2026-12-13', 'Arkitektur och teknisk systemdesign', 1, 5)
INSERT INTO Uppdrag (StartDatum, SlutDatum, RollBeskrivning, KonsultId, KundId) VALUES ('2026-10-10', '2026-11-20', 'Utveckling av backend-tjänst i C#', 3, 2)
INSERT INTO Uppdrag (StartDatum, SlutDatum, RollBeskrivning, KonsultId, KundId) VALUES ('2027-01-01', '2027-02-28', 'Implementering av CI/CD-pipeline', 5, 1)
INSERT INTO Uppdrag (StartDatum, SlutDatum, RollBeskrivning, KonsultId, KundId) VALUES ('2026-12-01', '2027-03-25', 'Driftoptimering', 4, 1)

-- Fråga A
SELECT * FROM Konsulter 
WHERE TimPris > 1200
ORDER BY TimPris DESC

-- Fråga B
SELECT u.RollBeskrivning AS Uppdrag, ku.FöretagsNamn AS Företag, ko.Namn AS Konsult, u.StartDatum AS Startdatum, u.SlutDatum AS Slutdatum
FROM Kunder ku
INNER JOIN Uppdrag u ON ku.Id = u.KundId
INNER JOIN Konsulter ko ON ko.Id = u.KonsultId

-- Fråga C
SELECT k.FöretagsNamn, COUNT (u.Id) AS [Antal uppdrag]
FROM Kunder k
INNER JOIN Uppdrag u ON k.Id = u.KundId
GROUP BY k.FöretagsNamn

-- Fråga D
UPDATE Konsulter
SET TimPris = 2000
WHERE Id = 1
SELECT * FROM Konsulter

-- Fråga E
DELETE FROM KUNDER 
WHERE NOT EXISTS (
	SELECT 1
	FROM Uppdrag
	WHERE Uppdrag.KundId = Kunder.Id
);
SELECT * FROM Kunder