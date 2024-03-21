USE dbnasa;
GO

INSERT INTO CialoNiebieskie (Masa, Srednica, Nazwa, CzyZbadane)
VALUES 
    (5.972E24, 12742, 'Ziemia', 1),
    (1.989E30, 1392680, 'S�o�ce', 0),
    (7.342E22, 3474, 'Ksi�yc', 1),
    (5.972E24, 12756, 'Jowisz', 0),
    (86.813E24, 139820, 'Saturn', 0),
    (1.024E26, 142984, 'Uran', 0),
    (1.049E26, 120536, 'Neptun', 0),
	(4.8675E24, 12742, 'Mars', 1);

INSERT INTO Orbita (TypOrbity, SredniaOdlegloscOdCentrum, NachylenieOrbity, Mimo�r�d, ArgumentPerycentrum, DlugoscWezlaWstegujacego, SredniRuchDzienny)
VALUES 
    ('Orbita eliptyczna', 0, 0, 0.0167, 101.92, 0, 360/365.25),
    ('Orbita satelity', 125, 102.17, 2.91, 0.043, 41.756, 0.41),
    ('Orbita ksi�yca', 384700, 350, 0.0549, 53, 125.1, 360/27.3),
    ('Orbita stacji kosmicznej', 408, 5.14, 0.0549, 53, 125.1, 360/27.3),
	('Orbita Jowisza', 778360000, 1.303, 0.0489, 273.867, 100.556, 13.06),
    ('Orbita Saturna', 1426666422, 2.485, 0.0565, 339.392, 113.715, 9.68),
    ('Orbita Urana', 2870658186, 0.772, 0.0464, 96.998, 74.006, 6.81),
    ('Orbita Neptuna', 4503443661, 1.769, 0.0095, 265.159, 131.784, 5.43),
    ('Orbita Marsa', 227936637, 1.849, 0.0934, 336.041, 49.578, 24.07);

INSERT INTO RelacjeZOrbita (CzyOkr��a, CzyPosiada, Inne, FK_ID_CialoNiebieskie, FK_ID_Orbita)
VALUES
    (1, 0, 'Ziemia-S�o�ce', (SELECT Id FROM CialoNiebieskie WHERE Nazwa = 'Ziemia'), (SELECT Id FROM Orbita Where TypOrbity = 'Orbita eliptyczna')),
    (0, 1, 'S�o�ce-Ziemi�', (SELECT Id FROM CialoNiebieskie WHERE Nazwa = 'S�o�ce'), (SELECT Id FROM Orbita Where TypOrbity = 'Orbita eliptyczna')),
    (1, 0, 'Ksi�yc-Ziemi�', (SELECT Id FROM CialoNiebieskie WHERE Nazwa = 'Ksi�yc'), (SELECT Id FROM Orbita Where TypOrbity = 'Orbita ksi�yca')),
    (0, 1, 'Ziemia-Ksi�yc', (SELECT Id FROM CialoNiebieskie WHERE Nazwa = 'Ziemia'), (SELECT Id FROM Orbita Where TypOrbity = 'Orbita ksi�yca')),
	(1, 0, 'Jowisz-S�o�ce', (SELECT Id FROM CialoNiebieskie WHERE Nazwa = 'Jowisz'), (SELECT Id FROM Orbita Where TypOrbity = 'Orbita Jowisza')),
    (0, 1, 'S�o�ce-Jowisz', (SELECT Id FROM CialoNiebieskie WHERE Nazwa = 'S�o�ce'), (SELECT Id FROM Orbita Where TypOrbity = 'Orbita Jowisza')),
	(1, 0, 'Saturn-S�o�ce', (SELECT Id FROM CialoNiebieskie WHERE Nazwa = 'Saturn'), (SELECT Id FROM Orbita Where TypOrbity = 'Orbita Saturna')),
    (0, 1, 'S�o�ce-Saturn', (SELECT Id FROM CialoNiebieskie WHERE Nazwa = 'S�o�ce'), (SELECT Id FROM Orbita Where TypOrbity = 'Orbita Saturna')),
	(1, 0, 'Uran-S�o�ce', (SELECT Id FROM CialoNiebieskie WHERE Nazwa = 'Uran'), (SELECT Id FROM Orbita Where TypOrbity = 'Orbita Urana')),
    ( 0, 1, 'S�o�ce-Uran', (SELECT Id FROM CialoNiebieskie WHERE Nazwa = 'S�o�ce'), (SELECT Id FROM Orbita Where TypOrbity = 'Orbita Urana')),
	(1, 0, 'Neptun-S�o�ce', (SELECT Id FROM CialoNiebieskie WHERE Nazwa = 'Neptun'), (SELECT Id FROM Orbita Where TypOrbity = 'Orbita Neptuna')),
    ( 0, 1, 'S�o�ce-Neptun', (SELECT Id FROM CialoNiebieskie WHERE Nazwa = 'S�o�ce'), (SELECT Id FROM Orbita Where TypOrbity = 'Orbita Neptuna')),
	(1, 0, 'Mars-S�o�ce', (SELECT Id FROM CialoNiebieskie WHERE Nazwa = 'Mars'), (SELECT Id FROM Orbita Where TypOrbity = 'Orbita Marsa')),
    ( 0, 1, 'S�o�ce-Mars', (SELECT Id FROM CialoNiebieskie WHERE Nazwa = 'S�o�ce'), (SELECT Id FROM Orbita Where TypOrbity = 'Orbita Marsa'));

INSERT INTO SztuczneSatelity (RodzajSatelity, Zastosowanie, Wlasciciel, FK_ID_Orbity)
VALUES
  ('Edukacyjny', 'Wsparcie edukacyjne', 'UNESCO', NULL),
  ('Komunikacyjny', '��czno�� satelitarna', 'GlobalSat', (SELECT Id FROM Orbita Where TypOrbity = 'Orbita ksi�yca')),
  ('Naukowy', 'Badania naukowe', 'NASA', (SELECT Id FROM Orbita Where TypOrbity = 'Orbita Marsa')),
  ('Meteorologiczny', 'Monitorowanie pogody', 'NOAA', (SELECT Id FROM Orbita Where TypOrbity = 'Orbita stacji kosmicznej')),
  ('Szpiegowski', 'Zbieranie informacji wywiadowczych', 'CIA', NULL),
  ('Nawigacyjny', 'Wsparcie nawigacji', 'ESA', (SELECT Id FROM Orbita Where TypOrbity = 'Orbita stacji kosmicznej')),
  ('Wojskowy', 'Zastosowania militarno-obronne', 'Ministerstwo Obrony', (SELECT Id FROM Orbita Where TypOrbity = 'Orbita stacji kosmicznej')),
  ('Rozrywkowy', 'Transmisje telewizyjne', 'HollywoodSat', (SELECT Id FROM Orbita Where TypOrbity = 'Orbita ksi�yca')),
  ('Zwiadowczy', 'Przeszukiwanie terenu', 'NSA', (SELECT Id FROM Orbita Where TypOrbity = 'Orbita Marsa')),
  ('Medyczny', 'Telemedycyna', 'WHO', (SELECT Id FROM Orbita Where TypOrbity = 'Orbita stacji kosmicznej'));

INSERT INTO Umiejetnosci (OpisUmiejetnosci, Uprawnienia)
VALUES
  ('Wymiana Ma�ych Komponent�w', 'Uprawniony do wymiany ma�ych komponent�w w sprz�cie kosmicznym.'),
  ('Wymiana Du�ych Komponent�w', 'Uprawniony do wymiany du�ych komponent�w w zaawansowanych systemach kosmicznych.'),
  ('Obs�uga Narz�dzi Specjalistycznych 1', 'Uprawniony do obs�ugi narz�dzi do naprawy satelit�w.'),
  ('Obs�uga Narz�dzi Specjalistycznych 2', 'Uprawniony do obs�ugi i konserwacji specjalistycznych narz�dzi do naprawy satelit�w.'),
  ('Programowanie System�w Nawigacyjnych', 'Posiada umiej�tno�ci programowania system�w nawigacyjnych dla sztucznych satelit�w.'),
  ('Zaawansowana Diagnostyka Elektroniczna', 'Posiada zaawansowane umiej�tno�ci diagnostyki awarii w systemach elektronicznych.'),
  ('Kosmiczne In�ynieria Materia�owa', 'Specjalizuje si� w doborze i zastosowaniu materia��w kosmicznych w konstrukcji satelit�w.'),
  ('Testy Oprogramowania Kosmicznego', 'Specjalizuje si� w przeprowadzaniu test�w oprogramowania dla system�w kosmicznych.'),
  ('Zaawansowane Technologie Energetyczne', 'Posiada umiej�tno�ci w dziedzinie zaawansowanych technologii energetycznych stosowanych w kosmosie.');

INSERT INTO StacjeKosmiczne (MaxIloscCzlonkow, AktualnaIloscCzlonkow, Wlasciciel, FK_ID_Orbity)
VALUES (10, 5, 'NASA', (SELECT Id FROM Orbita Where TypOrbity = 'Orbita stacji kosmicznej')),
       (20, 17, 'UNESCO',(SELECT Id FROM Orbita Where TypOrbity = 'Orbita stacji kosmicznej')),
	   (17, 5, 'CIA', (SELECT Id FROM Orbita Where TypOrbity = 'Orbita stacji kosmicznej')),
       (23, 13, 'MSWiA', (SELECT Id FROM Orbita Where TypOrbity = 'Orbita ksi�yca')),
	   (19, 8, 'NSA',(SELECT Id FROM Orbita Where TypOrbity = 'Orbita stacji kosmicznej')),
       (34, 18, 'WHO', (SELECT Id FROM Orbita Where TypOrbity = 'Orbita stacji kosmicznej')),
	   (39, 27, 'NASA2', (SELECT Id FROM Orbita Where TypOrbity = 'Orbita stacji kosmicznej')),
       (19, 4, 'FBI',(SELECT Id FROM Orbita Where TypOrbity = 'Orbita Marsa'));

INSERT INTO WarsztatyTechniczne (DokladnaLokalizacja, FK_ID_StacjiKosmicznej, FK_ID_CialaNiebieskiego)
VALUES
  ('Modu� techniczny A', (SELECT Id FROM StacjeKosmiczne WHERE Wlasciciel = 'NASA'), NULL),
  ('USA, Colorado, Denver', NULL, (SELECT Id FROM CialoNiebieskie WHERE Nazwa = 'Ziemia')),
  ('Modu� techniczny B', (SELECT Id FROM StacjeKosmiczne WHERE Wlasciciel = 'UNESCO'), NULL),
  ('Rosja, Moskwa', NULL, (SELECT Id FROM CialoNiebieskie WHERE Nazwa = 'Ziemia')),
  ('Modu� naukowy', (SELECT Id FROM StacjeKosmiczne WHERE Wlasciciel = 'MSWiA'), NULL),
  ('USA, California, Los Angeles', NULL, (SELECT Id FROM CialoNiebieskie WHERE Nazwa = 'Ziemia')),
  ('Niemcy, Berlin', NULL, (SELECT Id FROM CialoNiebieskie WHERE Nazwa = 'Ziemia')),
  ('Modu� naprawczy', (SELECT Id FROM StacjeKosmiczne WHERE Wlasciciel = 'NSA'), NULL),
  ('USA, Texas, Houston', NULL, (SELECT Id FROM CialoNiebieskie WHERE Nazwa = 'Ziemia')),
  ('Modu� eksperymentalny', NULL, (SELECT Id FROM CialoNiebieskie WHERE Nazwa = 'Ziemia'));

INSERT INTO Osoby (Imie, Nazwisko, Wiek, Narodowosc, Specjalizacja, IloscNapraw, FK_ID_Przeloznego)
VALUES
	  ('Joe', 'Smith', 35, 'USA', 'CEO', 5, NULL),
	  ('Martin', 'Johnson', 28, 'Canada', 'Stellar Scientist', 3, (SELECT Id FROM Osoby WHERE Imie = 'Joe' AND Nazwisko = 'Smith')),
	  ('Jones', 'Williams', 40, 'UK', 'Quantum Navigator', 7, (SELECT Id FROM Osoby WHERE Imie = 'Joe' AND Nazwisko = 'Smith')),
	  ('Pulsar', 'Brown', 32, 'Australia', 'Celestial Mechanic', 4, (SELECT Id FROM Osoby WHERE Imie = 'Joe' AND Nazwisko = 'Smith')),
	  ('Anders', 'Miller', 45, 'Germany', 'Astrophysicist', 8, (SELECT Id FROM Osoby WHERE Imie = 'Joe' AND Nazwisko = 'Smith')),
	  ('Jacques', 'Supernova', 29, 'France', 'Space Biologist', 2, (SELECT Id FROM Osoby WHERE Imie = 'Joe' AND Nazwisko = 'Smith')),
	  ('Quark', 'Taylor', 38, 'Russia', 'Cosmic Chemist', 6, (SELECT Id FROM Osoby WHERE Imie = 'Joe' AND Nazwisko = 'Smith')),
	  ('Yu', 'Anderson', 42, 'China', 'Astroarchitect', 9, (SELECT Id FROM Osoby WHERE Imie = 'Pulsar' AND Nazwisko = 'Brown')),
	  ('Paolo', 'White', 31, 'Brazil', 'Exoplanet Explorer', 3, (SELECT Id FROM Osoby WHERE Imie = 'Joe' AND Nazwisko = 'Smith')),
	  ('Parag', 'Pimputkar', 36, 'India', 'Galactic Geologist', 5, (SELECT Id FROM Osoby WHERE Imie = 'Joe' AND Nazwisko = 'Smith'));

INSERT INTO PotwierdzeniaUmiejetnosci (DataZdobycia, DataWygasniecia, CzyAktywne, FK_ID_Umiejetnosci, FK_ID_Osoby)
VALUES ('2022-01-01', '2023-01-01', 1, (SELECT Id FROM Umiejetnosci WHERE OpisUmiejetnosci = 'Wymiana Ma�ych Komponent�w'), (SELECT Id FROM Osoby WHERE Imie = 'Joe' AND Nazwisko = 'Smith')),
       ('2021-06-15', '2022-06-15', 0, (SELECT Id FROM Umiejetnosci WHERE OpisUmiejetnosci = 'Wymiana Ma�ych Komponent�w'), (SELECT Id FROM Osoby WHERE Imie = 'Martin' AND Nazwisko = 'Johnson')),
	   ('2022-02-01', '2023-02-01', 1, (SELECT Id FROM Umiejetnosci WHERE OpisUmiejetnosci = 'Wymiana Du�ych Komponent�w'), (SELECT Id FROM Osoby WHERE Imie = 'Joe' AND Nazwisko = 'Smith')),
	   ('2021-07-01', '2022-07-01', 0, (SELECT Id FROM Umiejetnosci WHERE OpisUmiejetnosci = 'Wymiana Du�ych Komponent�w'), (SELECT Id FROM Osoby WHERE Imie = 'Pulsar' AND Nazwisko = 'Brown')),
	   ('2023-03-01', '2024-03-01', 1, (SELECT Id FROM Umiejetnosci WHERE OpisUmiejetnosci = 'Obs�uga Narz�dzi Specjalistycznych 1'), (SELECT Id FROM Osoby WHERE Imie = 'Pulsar' AND Nazwisko = 'Brown')),
	   ('2021-08-15', '2022-08-15', 0, (SELECT Id FROM Umiejetnosci WHERE OpisUmiejetnosci = 'Zaawansowana Diagnostyka Elektroniczna'), (SELECT Id FROM Osoby WHERE Imie = 'Jones' AND Nazwisko = 'Williams')),
	   ('2022-04-01', '2023-04-01', 1, (SELECT Id FROM Umiejetnosci WHERE OpisUmiejetnosci = 'Obs�uga Narz�dzi Specjalistycznych 2'),  (SELECT Id FROM Osoby WHERE Imie = 'Yu' AND Nazwisko = 'Anderson')),
   	   ('2021-09-01', '2022-09-01', 0, (SELECT Id FROM Umiejetnosci WHERE OpisUmiejetnosci = 'Obs�uga Narz�dzi Specjalistycznych 2'), (SELECT Id FROM Osoby WHERE Imie = 'Parag' AND Nazwisko = 'Pimputkar')),
	   ('2022-05-01', '2023-05-01', 1, (SELECT Id FROM Umiejetnosci WHERE OpisUmiejetnosci = 'Programowanie system�w nawigacyjnych'), (SELECT Id FROM Osoby WHERE Imie = 'Parag' AND Nazwisko = 'Pimputkar')),
	   ('2021-03-01', '2022-03-01', 1, (SELECT Id FROM Umiejetnosci WHERE OpisUmiejetnosci = 'Wymiana Ma�ych Komponent�w'), (SELECT Id FROM Osoby WHERE Imie = 'Parag' AND Nazwisko = 'Pimputkar')),
	   ('2021-10-15', '2022-10-15', 0, (SELECT Id FROM Umiejetnosci WHERE OpisUmiejetnosci = 'Programowanie system�w nawigacyjnych'),  (SELECT Id FROM Osoby WHERE Imie = 'Jones' AND Nazwisko = 'Williams'));

INSERT INTO Diagnozy (Priorytet, KomponentyDoNaprawy, DokladnyOpisAwarii, Przyczyna, Budzet, FK_ID_StacjiKosmicznej, FK_ID_SztucznegoSatelity)
VALUES (2, 'Antena', 'Brak sygna�u', 'Uszkodzenie mechaniczne', 50000.0, NULL, (SELECT Id FROM SztuczneSatelity WHERE Wlasciciel = 'UNESCO')),
       (1, 'Bateria', 'Awaria zasilania', 'B��d elektryczny', 100000.0, (SELECT Id FROM StacjeKosmiczne WHERE Wlasciciel = 'NASA'), NULL),
	   (2, 'Komputer pok�adowy i systemy komunikacyjne, antena', 'B��d ��czno�ci', 'Wirus komputerowy', 75000.0, (SELECT Id FROM StacjeKosmiczne WHERE Wlasciciel = 'NASA'), NULL),
	   (1, 'Zbiornik tlenu', 'Wyciek gazu', 'Uszkodzenie strukturalne', 120000.0, NULL, (SELECT Id FROM SztuczneSatelity WHERE Wlasciciel = 'ESA')),
	   (3, 'Nap�d g��wny', 'Brak nap�du', 'Usterka mechaniczna', 90000.0, (SELECT Id FROM StacjeKosmiczne WHERE Wlasciciel = 'NSA'), NULL),
	   (2, 'System nawigacyjny', 'Zawieszony system', 'Awaria oprogramowania', 80000.0, NULL, (SELECT Id FROM SztuczneSatelity WHERE Wlasciciel = 'CIA')),
	   (1, 'Panel s�oneczny', 'Brak zasilania', 'Uszkodzenie elektryczne', 110000.0, NULL, (SELECT Id FROM SztuczneSatelity WHERE Wlasciciel = 'GlobalSat')),
	   (1, 'Podgrzewane siedzenia', 'Brak podgrzewania', 'Usterka elektryczna', 95000.0, (SELECT Id FROM StacjeKosmiczne WHERE Wlasciciel = 'NASA'), NULL),
	   (2, 'Klimatyzacja', 'Brak ch�odzenia', 'Uszkodzenie uk�adu ch�odzenia', 85000.0, NULL, (SELECT Id FROM SztuczneSatelity WHERE Wlasciciel = 'GlobalSat')),
	   (1, 'System komunikacji', 'Brak ��czno�ci', 'Uszkodzenie anteny', 130000.0, 2, NULL);

INSERT INTO HistorieNaprawy (CzySukces, Opis, PoczatekNaprawy, KoniecNaprawy, Wydatki, FK_ID_Diagnozy)
VALUES
    (1, 'Naprawa anteny zako�czona sukcesem. Wymieniono uszkodzone elementy, co przywr�ci�o pe�n� funkcjonalno�� anteny.', '2022-03-10', '2022-03-20', 30000.0, (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'Antena')),
    (1, 'Naprawa baterii zako�czona sukcesem. Uszkodzone ogniwa zosta�y wymienione, przywracaj�c pe�n� moc zasilania.', '2020-05-05', '2022-06-01', 80000.0, (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'Bateria')),
    (0, 'Naprawa komputera pok�adowego. Niestety, z powodu braku wystarczaj�cego bud�etu, naprawa zosta�a przerwana. Konieczne jest pozyskanie dodatkowych �rodk�w finansowych.', '2019-06-15', '2022-06-25', 45000.0, (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'Komputer pok�adowy i systemy komunikacyjne, antena')),
    (1, 'Ponowna naprawa komputera pok�adowego. Po uzyskaniu dodatkowych �rodk�w finansowych zako�czono napraw�, przywracaj�c pe�n� funkcjonalno�� komputera.', '2017-07-28', '2022-08-06', 65000.0, (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'Komputer pok�adowy i systemy komunikacyjne, antena')),
    (1, 'Naprawa zbiornika tlenu zako�czona sukcesem. Uszkodzone elementy zosta�y wymienione, co przywr�ci�o stabilno�� i bezpiecze�stwo zbiornika.', '2021-08-03', '2022-08-15', 110000.0, (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'Zbiornik tlenu')),
    (1, 'Naprawa nap�du g��wnego. Wymieniono uszkodzone cz�ci nap�du, przywracaj�c pe�n� sprawno�� systemu nap�dowego.', '2023-09-20', '2022-10-10', 88000.0, (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'Nap�d g��wny')),
    (1, 'Naprawa systemu nawigacyjnego zako�czona sukcesem. Uszkodzone elementy zosta�y naprawione, co przywr�ci�o precyzj� systemu nawigacyjnego.', '2022-11-05', '2022-11-15', 75000.0, (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'System nawigacyjny')),
    (1, 'Naprawa panelu s�onecznego zako�czona sukcesem. Wymieniono uszkodzone ogniwa s�oneczne, przywracaj�c pe�n� sprawno�� panelu.', '2023-01-10', '2023-01-20', 105000.0,(SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'Panel s�oneczny')),
    (0, 'Naprawa podgrzewanych siedze�. Niestety, naprawa nie zosta�a jeszcze wykonana ze wzgl�du na stosunkowo niski priorytet i brak �rodk�w', '2023-07-11', NULL, 92000.0, (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'Podgrzewane siedzenia')),
    (1, 'Naprawa podgrzewania zako�czona sukcesem. Wymieniono uszkodzone elementy, przywracaj�c funkcj� podgrzewania.', '2022-11-08', '2022-12-15', 75000.0, (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'Podgrzewane siedzenia')),
    (1, 'Naprawa nap�d�w bocznych zako�czona sukcesem. Wymieniono uszkodzone elementy nap�du, co przywr�ci�o pe�n� sprawno�� nap�d�w bocznych.', '2021-01-10', '2023-01-20', 105000.0, (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'Nap�d g��wny')),
	(0, 'Naprawa uk�adu komunikacyjnego zako�czona niepowodzeniem. Napotkano trudno�ci w identyfikacji przyczyny awarii.', '2023-03-01', '2023-03-10', 40000.0, (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'Nap�d g��wny')),
    (1, 'Naprawa uk�adu komunikacyjnego. Po dodatkowych badaniach zidentyfikowano i naprawiono problem, przywracaj�c pe�n� funkcjonalno��.', '2023-03-15', '2023-03-25', 35000.0, (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'Nap�d g��wny')),
    (0, 'Naprawa systemu �yciowego zako�czona niepowodzeniem. Napotkano trudno�ci w dost�pie do niekt�rych komponent�w.', '2023-05-10', '2023-05-20', 55000.0, (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'System nawigacyjny')),
    (1, 'Naprawa systemu �yciowego. Po uzyskaniu dodatkowych �rodk�w i specjalistycznego sprz�tu, zako�czono napraw�, przywracaj�c niezb�dne funkcje.', '2023-06-01', '2023-06-15', 65000.0, (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'Zbiornik tlenu')),
    (0, 'Naprawa systemu hamowania atmosferycznego zako�czona niepowodzeniem. Uszkodzenia okaza�y si� bardziej rozleg�e, ni� pierwotnie przewidywano.', '2023-08-15', '2023-09-01', 80000.0, (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'System nawigacyjny')),
    (1, 'Naprawa systemu hamowania atmosferycznego. Po przeprowadzeniu dodatkowej diagnostyki i wymianie krytycznych komponent�w, system zosta� przywr�cony do pe�nej sprawno�ci.', '2023-09-10', '2023-09-25', 90000.0, (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'System nawigacyjny'));

INSERT INTO UczestnictwaWNaprawie (DataRozpoczeciaPracy, DataZakonczeniaPracy, FK_ID_HistoriiNaprawy, FK_ID_Osoby)
VALUES 
    ('2022-03-10', '2022-03-15', (SELECT Id FROM HistorieNaprawy WHERE PoczatekNaprawy = '2022-03-10'), (SELECT Id FROM Osoby WHERE Imie = 'Joe')),
    ('2022-03-18', '2022-03-23', (SELECT Id FROM HistorieNaprawy WHERE PoczatekNaprawy = '2022-03-10'), (SELECT Id FROM Osoby WHERE Imie = 'Joe')),
    ('2022-06-01', '2022-06-10', (SELECT Id FROM HistorieNaprawy WHERE PoczatekNaprawy = '2020-05-05'), (SELECT Id FROM Osoby WHERE Imie = 'Parag')),
    ('2022-07-05', '2022-07-15', (SELECT Id FROM HistorieNaprawy WHERE PoczatekNaprawy = '2020-05-05'), (SELECT Id FROM Osoby WHERE Imie = 'Parag')),
    ('2022-09-15', '2022-09-25', (SELECT Id FROM HistorieNaprawy WHERE PoczatekNaprawy = '2022-11-08'), (SELECT Id FROM Osoby WHERE Imie = 'Pulsar')),
    ('2022-11-10', '2022-11-20', (SELECT Id FROM HistorieNaprawy WHERE PoczatekNaprawy = '2023-05-10'), (SELECT Id FROM Osoby WHERE Imie = 'Parag')),
    ('2023-01-15', '2023-01-25', (SELECT Id FROM HistorieNaprawy WHERE PoczatekNaprawy = '2023-08-15'), (SELECT Id FROM Osoby WHERE Imie = 'Martin')),
    ('2023-03-20', '2023-03-30', (SELECT Id FROM HistorieNaprawy WHERE PoczatekNaprawy = '2022-11-08'), (SELECT Id FROM Osoby WHERE Imie = 'Anders')),
    ('2023-05-05', '2023-05-15', (SELECT Id FROM HistorieNaprawy WHERE PoczatekNaprawy = '2023-09-20'), (SELECT Id FROM Osoby WHERE Imie = 'Anders')),
    ('2023-07-01', '2023-07-19', (SELECT Id FROM HistorieNaprawy WHERE PoczatekNaprawy = '2023-05-10'), (SELECT Id FROM Osoby WHERE Imie = 'Pulsar')),
    ('2023-09-10', '2023-09-20', (SELECT Id FROM HistorieNaprawy WHERE PoczatekNaprawy = '2023-09-20'), (SELECT Id FROM Osoby WHERE Imie = 'Parag')),
	('2022-03-16', '2022-03-19', (SELECT Id FROM HistorieNaprawy WHERE PoczatekNaprawy = '2022-03-10'), (SELECT Id FROM Osoby WHERE Imie = 'Parag'));


INSERT INTO ZgloszeniaAwarii (Opis, WagaZgloszenia, SkutkiAwarii, FK_ID_Diagnozy)
VALUES ('Brak sygna�u z satelity', 0.5, 'Brak transmisji danych', (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'Antena')),
       ('Awaria zasilania baterii', 0.9, 'Przerwanie zasilania', (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'Zbiornik tlenu')),
	   ('Uszkodzenie anteny satelity', 0.7, 'Zak��cone dane transmisyjne', NULL),
	   ('Awaria systemu zasilania stacji kosmicznej', 0.8, 'Zagro�enie utraty zasilania', (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'Antena')),
	   ('Niedzia�aj�ce sensory termiczne', 0.6, 'Ryzyko przegrzania', (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'Panel s�oneczny')),
	   ('Awaria komunikacji mi�dzy modu�ami', 0.7, 'Brak synchronizacji', NULL),
	   ('Uszkodzenie uk�adu ch�odzenia', 0.8, 'Zwi�kszone ryzyko przegrzania', (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'Klimatyzacja')),
	   ('Brak danych z orbity', 0.4, 'Zak��cona nawigacja', (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'Antena')),
	   ('Zgubiony sygna� z sondy', 0.6, 'Zak��cenia w obserwacjach', (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'Antena')),
	   ('Problem z nap�dem statku kosmicznego', 0.9, 'Zagro�enie utraty kontroli', (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'Nap�d g��wny'));

INSERT INTO Naprawy (CelNaprawy, InstrukcjaNaprawy, PotrzebneNarzedzia, Uwagi, FK_ID_StacjiKosmicznej, FK_ID_SztucznegoSatelity)
VALUES ('Naprawa anteny', 'Podmiana uszkodzonej anteny', 'Narz�dzia do monta�u anteny', 'Brak uwag', (SELECT Id FROM StacjeKosmiczne WHERE Wlasciciel = 'NASA'), NULL),
       ('Naprawa baterii', 'Wymiana uszkodzonej baterii', 'Narz�dzia elektryczne', 'Wymagana precyzja', (SELECT Id FROM StacjeKosmiczne WHERE Wlasciciel = 'NSA'), NULL),
	   ('Wymiana anteny satelity', 'Podmiana uszkodzonych element�w anteny', 'Zestaw narz�dzi do naprawy anten', 'Brak dodatkowych uwag', (SELECT Id FROM StacjeKosmiczne WHERE Wlasciciel = 'CIA'), NULL),
	   ('Naprawa systemu zasilania stacji kosmicznej', 'Wymiana uszkodzonych komponent�w', 'Specjalistyczne narz�dzia elektryczne', 'Wymaga ostro�no�ci przy pracy z pr�dem', (SELECT Id FROM StacjeKosmiczne WHERE Wlasciciel = 'UNESCO'), NULL),
	   ('Naprawa sensor�w termicznych', 'Regulacja i kalibracja czujnik�w', 'Narz�dzia do precyzyjnych pomiar�w', 'Czujniki mog�y ulec przegrzaniu', (SELECT Id FROM StacjeKosmiczne WHERE Wlasciciel = 'NASA'), NULL),
	   ('Naprawa systemu komunikacji mi�dzy modu�ami', 'Diagnoza i naprawa uszkodzonych linii komunikacyjnych', 'Narz�dzia do diagnostyki sieci', 'Brak specjalnych uwag', NULL, (SELECT Id FROM SztuczneSatelity WHERE Wlasciciel = 'WHO')),
	   ('Naprawa uk�adu ch�odzenia', 'Wymiana uszkodzonych element�w ch�odz�cych', 'Narz�dzia do obs�ugi system�w ch�odzenia', 'Przegrzanie mog�o spowodowa� uszkodzenia', (SELECT Id FROM StacjeKosmiczne WHERE Wlasciciel = 'NASA2'), NULL),
	   ('Przywr�cenie po��czenia z satelit�', 'Diagnoza i konfiguracja system�w komunikacji satelitarnej', 'Specjalistyczne narz�dzia do konfiguracji', 'Brak dodatkowych uwag', NULL, (SELECT Id FROM SztuczneSatelity WHERE Wlasciciel = 'HollywoodSat')),
	   ('Odzyskanie sygna�u z sondy', 'Analiza i rekonstrukcja sygna�u', 'Narz�dzia do analizy danych', 'Brak specjalnych uwag', NULL, (SELECT Id FROM SztuczneSatelity WHERE Wlasciciel = 'HollywoodSat')),
	   ('Naprawa nap�du statku kosmicznego', 'Wymiana uszkodzonych cz�ci nap�du', 'Zestaw narz�dzi do naprawy mechanicznej', 'Ostro�no�� przy pracy z mechanicznymi elementami', NULL, (SELECT Id FROM SztuczneSatelity WHERE Wlasciciel = 'WHO'));

INSERT INTO DiagNapr (FK_ID_Diagnozy, FK_ID_Naprawy)
VALUES
  ((SELECT Id FROM Osoby WHERE Imie = 'Joe' AND Nazwisko = 'Smith'), (SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa anteny')),
  ((SELECT Id FROM Osoby WHERE Imie = 'Joe' AND Nazwisko = 'Smith'), (SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa baterii')),
  ((SELECT Id FROM Osoby WHERE Imie = 'Martin' AND Nazwisko = 'Johnson'), (SELECT Id FROM Naprawy WHERE CelNaprawy = 'Wymiana anteny satelity')),
  ((SELECT Id FROM Osoby WHERE Imie = 'Jones' AND Nazwisko = 'Williams'), (SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa sensor�w termicznych')),
  ((SELECT Id FROM Osoby WHERE Imie = 'Jones' AND Nazwisko = 'Williams'), (SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa uk�adu ch�odzenia')),
  ((SELECT Id FROM Osoby WHERE Imie = 'Yu' AND Nazwisko = 'Anderson'), (SELECT Id FROM Naprawy WHERE CelNaprawy = 'Odzyskanie sygna�u z sondy')),
  ((SELECT Id FROM Osoby WHERE Imie = 'Yu' AND Nazwisko = 'Anderson'), (SELECT Id FROM Naprawy WHERE CelNaprawy = 'Przywr�cenie po��czenia z satelit�')),
  ((SELECT Id FROM Osoby WHERE Imie = 'Yu' AND Nazwisko = 'Anderson'), (SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa systemu zasilania stacji kosmicznej')),
  ((SELECT Id FROM Osoby WHERE Imie = 'Anders' AND Nazwisko = 'Miller'), (SELECT Id FROM Naprawy WHERE CelNaprawy = 'Przywr�cenie po��czenia z satelit�')),
  ((SELECT Id FROM Osoby WHERE Imie = 'Anders' AND Nazwisko = 'Miller'), (SELECT Id FROM Naprawy WHERE CelNaprawy = 'Odzyskanie sygna�u z sondy')),
  ((SELECT Id FROM Osoby WHERE Imie = 'Anders' AND Nazwisko = 'Miller'), (SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa systemu zasilania stacji kosmicznej')),
  ((SELECT Id FROM Osoby WHERE Imie = 'Quark' AND Nazwisko = 'Taylor'), (SELECT Id FROM Naprawy WHERE CelNaprawy = 'Odzyskanie sygna�u z sondy'));

INSERT INTO DiagOsob (FK_ID_Osoby, FK_ID_Diagnozy)
VALUES
  ((SELECT Id FROM Osoby WHERE Imie = 'Joe' AND Nazwisko = 'Smith'), (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'Antena')),
  ((SELECT Id FROM Osoby WHERE Imie = 'Joe' AND Nazwisko = 'Smith'), (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'Zbiornik tlenu')),
  ((SELECT Id FROM Osoby WHERE Imie = 'Martin' AND Nazwisko = 'Johnson'), (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'Komputer pok�adowy i systemy komunikacyjne, antena')),
  ((SELECT Id FROM Osoby WHERE Imie = 'Jones' AND Nazwisko = 'Williams'), (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'Bateria')),
  ((SELECT Id FROM Osoby WHERE Imie = 'Jones' AND Nazwisko = 'Williams'), (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'System nawigacyjny')),
  ((SELECT Id FROM Osoby WHERE Imie = 'Yu' AND Nazwisko = 'Anderson'), (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'Klimatyzacja')),
  ((SELECT Id FROM Osoby WHERE Imie = 'Yu' AND Nazwisko = 'Anderson'), (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'Panel s�oneczny')),
  ((SELECT Id FROM Osoby WHERE Imie = 'Yu' AND Nazwisko = 'Anderson'), (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'Antena')),
  ((SELECT Id FROM Osoby WHERE Imie = 'Anders' AND Nazwisko = 'Miller'), (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'Podgrzewane siedzenia')),
  ((SELECT Id FROM Osoby WHERE Imie = 'Anders' AND Nazwisko = 'Miller'), (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'Klimatyzacja')),
  ((SELECT Id FROM Osoby WHERE Imie = 'Anders' AND Nazwisko = 'Miller'), (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'Antena')),
  ((SELECT Id FROM Osoby WHERE Imie = 'Quark' AND Nazwisko = 'Taylor'), (SELECT Id FROM Diagnozy WHERE KomponentyDoNaprawy = 'Antena'));
  
INSERT INTO NaprHist (FK_ID_Naprawy, FK_ID_HistoriiNapraw)
VALUES
    ((SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa anteny'), (SELECT Id FROM HistorieNaprawy WHERE Opis LIKE 'Naprawa anteny%')),
    ((SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa baterii'), (SELECT Id FROM HistorieNaprawy WHERE Opis LIKE 'Naprawa baterii%')),
    ((SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa uk�adu ch�odzenia'), (SELECT Id FROM HistorieNaprawy WHERE Opis LIKE 'Naprawa systemu �yciowego%' AND CzySukces = 0)),
    ((SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa uk�adu ch�odzenia'), (SELECT Id FROM HistorieNaprawy WHERE Opis LIKE 'Naprawa systemu �yciowego%' AND CzySukces = 1)),
    ((SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa nap�du statku kosmicznego'), (SELECT Id FROM HistorieNaprawy WHERE Opis LIKE 'Naprawa systemu hamowania atmosferycznego%' AND CzySukces = 0)),
    ((SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa nap�du statku kosmicznego'), (SELECT Id FROM HistorieNaprawy WHERE Opis LIKE 'Naprawa systemu hamowania atmosferycznego%' AND CzySukces = 1)),
    ((SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa anteny'), (SELECT Id FROM HistorieNaprawy WHERE Opis LIKE 'Naprawa uk�adu komunikacyjnego%' AND CzySukces = 0)),
    ((SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa anteny'), (SELECT Id FROM HistorieNaprawy WHERE Opis LIKE 'Naprawa uk�adu komunikacyjnego%' AND CzySukces = 1));

INSERT INTO WarsOsob (FK_ID_Osoby, FK_ID_Warsztatu)
VALUES
    ((SELECT Id FROM Osoby WHERE Imie = 'Joe' AND Nazwisko = 'Smith'), (SELECT Id FROM WarsztatyTechniczne WHERE DokladnaLokalizacja = 'Modu� techniczny A')),
    ((SELECT Id FROM Osoby WHERE Imie = 'Joe' AND Nazwisko = 'Smith'), (SELECT Id FROM WarsztatyTechniczne WHERE DokladnaLokalizacja = 'Modu� techniczny B')),
    ((SELECT Id FROM Osoby WHERE Imie = 'Martin' AND Nazwisko = 'Johnson'), (SELECT Id FROM WarsztatyTechniczne WHERE DokladnaLokalizacja = 'USA, Colorado, Denver')),
    ((SELECT Id FROM Osoby WHERE Imie = 'Yu' AND Nazwisko = 'Anderson'), (SELECT Id FROM WarsztatyTechniczne WHERE DokladnaLokalizacja = 'Modu� naukowy')),
    ((SELECT Id FROM Osoby WHERE Imie = 'Yu' AND Nazwisko = 'Anderson'), (SELECT Id FROM WarsztatyTechniczne WHERE DokladnaLokalizacja = 'USA, California, Los Angeles')),
    ((SELECT Id FROM Osoby WHERE Imie = 'Anders' AND Nazwisko = 'Miller'), (SELECT Id FROM WarsztatyTechniczne WHERE DokladnaLokalizacja = 'Modu� techniczny A')),
    ((SELECT Id FROM Osoby WHERE Imie = 'Anders' AND Nazwisko = 'Miller'), (SELECT Id FROM WarsztatyTechniczne WHERE DokladnaLokalizacja = 'USA, California, Los Angeles')),
    ((SELECT Id FROM Osoby WHERE Imie = 'Quark' AND Nazwisko = 'Taylor'), (SELECT Id FROM WarsztatyTechniczne WHERE DokladnaLokalizacja = 'Modu� techniczny A')),
	((SELECT Id FROM Osoby WHERE Imie = 'Jones' AND Nazwisko = 'Williams'), (SELECT Id FROM WarsztatyTechniczne WHERE DokladnaLokalizacja = 'Niemcy, Berlin'));


INSERT INTO SztuWars (FK_ID_SztucznegoSatelity, FK_ID_Warsztatu)
VALUES
    ((SELECT Id FROM SztuczneSatelity WHERE Wlasciciel = 'NASA'), (SELECT Id FROM WarsztatyTechniczne WHERE DokladnaLokalizacja = 'Modu� techniczny A')),
    ((SELECT Id FROM SztuczneSatelity WHERE Wlasciciel = 'UNESCO'), (SELECT Id FROM WarsztatyTechniczne WHERE DokladnaLokalizacja = 'Modu� techniczny B')),
    ((SELECT Id FROM SztuczneSatelity WHERE Wlasciciel = 'NASA'), (SELECT Id FROM WarsztatyTechniczne WHERE DokladnaLokalizacja = 'USA, Colorado, Denver')),
    ((SELECT Id FROM SztuczneSatelity WHERE Wlasciciel = 'NSA'), (SELECT Id FROM WarsztatyTechniczne WHERE DokladnaLokalizacja = 'Modu� naukowy')),
    ((SELECT Id FROM SztuczneSatelity WHERE Wlasciciel = 'UNESCO'), (SELECT Id FROM WarsztatyTechniczne WHERE DokladnaLokalizacja = 'USA, California, Los Angeles')),
    ((SELECT Id FROM SztuczneSatelity WHERE Wlasciciel = 'NOAA'), (SELECT Id FROM WarsztatyTechniczne WHERE DokladnaLokalizacja = 'Modu� techniczny A')),
    ((SELECT Id FROM SztuczneSatelity WHERE Wlasciciel = 'WHO'), (SELECT Id FROM WarsztatyTechniczne WHERE DokladnaLokalizacja = 'USA, California, Los Angeles')),
    ((SELECT Id FROM SztuczneSatelity WHERE Wlasciciel = 'CIA'), (SELECT Id FROM WarsztatyTechniczne WHERE DokladnaLokalizacja = 'Modu� techniczny A')),
	((SELECT Id FROM SztuczneSatelity WHERE Wlasciciel = 'NOAA'), (SELECT Id FROM WarsztatyTechniczne WHERE DokladnaLokalizacja = 'Niemcy, Berlin'));


INSERT INTO NaprUmie (FK_ID_Naprawy, FK_ID_Umiejetnosci)
VALUES
    ((SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa anteny'), (SELECT Id FROM Umiejetnosci WHERE OpisUmiejetnosci = 'Wymiana Ma�ych Komponent�w')),
    ((SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa systemu zasilania stacji kosmicznej'), (SELECT Id FROM Umiejetnosci WHERE OpisUmiejetnosci = 'Wymiana Ma�ych Komponent�w')),
    ((SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa uk�adu ch�odzenia'), (SELECT Id FROM Umiejetnosci WHERE OpisUmiejetnosci = 'Wymiana Ma�ych Komponent�w')),
    ((SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa anteny'), (SELECT Id FROM Umiejetnosci WHERE OpisUmiejetnosci = 'Wymiana Du�ych Komponent�w')),
    ((SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa baterii'), (SELECT Id FROM Umiejetnosci WHERE OpisUmiejetnosci = 'Wymiana Du�ych Komponent�w')),
    ((SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa uk�adu ch�odzenia'), (SELECT Id FROM Umiejetnosci WHERE OpisUmiejetnosci = 'Wymiana Du�ych Komponent�w')),
    ((SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa sensor�w termicznych'), (SELECT Id FROM Umiejetnosci WHERE OpisUmiejetnosci = 'Wymiana Du�ych Komponent�w')),
    ((SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa nap�du statku kosmicznego'), (SELECT Id FROM Umiejetnosci WHERE OpisUmiejetnosci = 'Wymiana Du�ych Komponent�w')),
    ((SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa baterii'), (SELECT Id FROM Umiejetnosci WHERE OpisUmiejetnosci = 'Obs�uga Narz�dzi Specjalistycznych 1')),
    ((SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa systemu zasilania stacji kosmicznej'), (SELECT Id FROM Umiejetnosci WHERE OpisUmiejetnosci = 'Obs�uga Narz�dzi Specjalistycznych 1')),
    ((SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa uk�adu ch�odzenia'), (SELECT Id FROM Umiejetnosci WHERE OpisUmiejetnosci = 'Obs�uga Narz�dzi Specjalistycznych 1')),
    ((SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa sensor�w termicznych'), (SELECT Id FROM Umiejetnosci WHERE OpisUmiejetnosci = 'Obs�uga Narz�dzi Specjalistycznych 1')),
    ((SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa baterii'), (SELECT Id FROM Umiejetnosci WHERE OpisUmiejetnosci = 'Obs�uga Narz�dzi Specjalistycznych 2')),
    ((SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa uk�adu ch�odzenia'), (SELECT Id FROM Umiejetnosci WHERE OpisUmiejetnosci = 'Obs�uga Narz�dzi Specjalistycznych 2')),
    ((SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa nap�du statku kosmicznego'), (SELECT Id FROM Umiejetnosci WHERE OpisUmiejetnosci = 'Obs�uga Narz�dzi Specjalistycznych 2')),
    ((SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa anteny'), (SELECT Id FROM Umiejetnosci WHERE OpisUmiejetnosci = 'Programowanie System�w Nawigacyjnych')),
    ((SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa baterii'), (SELECT Id FROM Umiejetnosci WHERE OpisUmiejetnosci = 'Zaawansowane Technologie Energetyczne')),
    ((SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa systemu zasilania stacji kosmicznej'), (SELECT Id FROM Umiejetnosci WHERE OpisUmiejetnosci = 'Zaawansowane Technologie Energetyczne')),
    ((SELECT Id FROM Naprawy WHERE CelNaprawy = 'Naprawa nap�du statku kosmicznego'), (SELECT Id FROM Umiejetnosci WHERE OpisUmiejetnosci = 'Zaawansowane Technologie Energetyczne'));
