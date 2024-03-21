USE db6;
GO

DELETE FROM SztuczneSatelity WHERE Wlasciciel = 'UNESCO';
DELETE FROM Osoby WHERE Imie = 'Yu';

UPDATE Osoby
SET Nazwisko = 'Muller'
WHERE Nazwisko = 'Miller';


SELECT * FROM SztuWars
SELECT * FROM WarsOsob
SELECT * FROM NaprHist
SELECT * FROM DiagOsob
SELECT * FROM DiagNapr
SELECT * FROM NaprUmie
SELECT * FROM Naprawy
SELECT * FROM UczestnictwaWNaprawie
SELECT * FROM HistorieNaprawy
SELECT * FROM ZgloszeniaAwarii
SELECT * FROM Diagnozy
SELECT * FROM RelacjeZOrbita
SELECT * FROM SztuczneSatelity
SELECT * FROM PotwierdzeniaUmiejetnosci
SELECT * FROM Umiejetnosci
SELECT * FROM WarsztatyTechniczne
SELECT * FROM StacjeKosmiczne
SELECT * FROM Osoby
SELECT * FROM CialoNiebieskie
SELECT * FROM Orbita
