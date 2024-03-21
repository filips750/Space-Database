USE dbnasa;
GO

CREATE TABLE Orbita (
    ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    TypOrbity VARCHAR(255),
    SredniaOdlegloscOdCentrum FLOAT,
    NachylenieOrbity FLOAT,
    Mimoœród FLOAT,
    ArgumentPerycentrum FLOAT,
    DlugoscWezlaWstegujacego FLOAT,
    SredniRuchDzienny FLOAT
);

CREATE TABLE CialoNiebieskie (
    ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Masa FLOAT,
    Srednica FLOAT,
    Nazwa VARCHAR(255) NOT NULL,
    CzyZbadane BIT
);

CREATE TABLE SztuczneSatelity (
    ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    RodzajSatelity VARCHAR(31),
    Zastosowanie VARCHAR(255),
    Wlasciciel VARCHAR(31),
    FK_ID_Orbity INT,
    FOREIGN KEY (FK_ID_Orbity) REFERENCES Orbita(Id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Umiejetnosci (
    ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    OpisUmiejetnosci VARCHAR(255),
    Uprawnienia VARCHAR(255)
);

CREATE TABLE StacjeKosmiczne (
    ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    MaxIloscCzlonkow INT,
    AktualnaIloscCzlonkow INT,
	Wlasciciel VARCHAR(31),
    FK_ID_Orbity INT,
    FOREIGN KEY (FK_ID_Orbity) REFERENCES Orbita(Id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE WarsztatyTechniczne (
    ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    DokladnaLokalizacja VARCHAR(255),
    FK_ID_StacjiKosmicznej INT,
    FK_ID_CialaNiebieskiego INT,
    FOREIGN KEY (FK_ID_StacjiKosmicznej) REFERENCES StacjeKosmiczne(Id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (FK_ID_CialaNiebieskiego) REFERENCES CialoNiebieskie(Id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Osoby (
    ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Imie VARCHAR(31) NOT NULL,
    Nazwisko VARCHAR(31) NOT NULL,
    Wiek INT,
    Narodowosc VARCHAR(31),
    Specjalizacja VARCHAR(31),
    IloscNapraw INT,
    FK_ID_Przeloznego INT,
    FOREIGN KEY (FK_ID_Przeloznego) REFERENCES Osoby(Id)
);



CREATE TABLE PotwierdzeniaUmiejetnosci (
    ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    DataZdobycia DATE,
    DataWygasniecia DATE,
    CzyAktywne BIT,
    FK_ID_Umiejetnosci INT NOT NULL,
    FK_ID_Osoby INT NOT NULL,
    FOREIGN KEY (FK_ID_Umiejetnosci) REFERENCES Umiejetnosci(Id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (FK_ID_Osoby) REFERENCES Osoby(Id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE RelacjeZOrbita (
    ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    CzyOkr¹¿a BIT,
    CzyPosiada BIT,
    Inne VARCHAR(255),
    FK_ID_CialoNiebieskie INT NOT NULL,
    FK_ID_Orbita INT NOT NULL,
    FOREIGN KEY (FK_ID_CialoNiebieskie) REFERENCES CialoNiebieskie(Id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (FK_ID_Orbita) REFERENCES Orbita(Id) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT CheckRelacje CHECK ((NOT(CzyOkr¹¿a IS NOT NULL AND CzyPosiada IS NOT NULL))AND CzyOkr¹¿a IS NOT NULL OR CzyPosiada IS NOT NULL)
);

CREATE TABLE Diagnozy (
    ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Priorytet INT,
    KomponentyDoNaprawy VARCHAR(255),
    DokladnyOpisAwarii VARCHAR(255),
    Przyczyna VARCHAR(255),
    Budzet FLOAT,
    FK_ID_StacjiKosmicznej INT,
    FK_ID_SztucznegoSatelity INT,
    FOREIGN KEY (FK_ID_StacjiKosmicznej) REFERENCES StacjeKosmiczne(Id),
    FOREIGN KEY (FK_ID_SztucznegoSatelity) REFERENCES SztuczneSatelity(Id)
);

CREATE TABLE HistorieNaprawy (
    ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    CzySukces BIT,
    Opis VARCHAR(255),
    PoczatekNaprawy DATE,
    KoniecNaprawy DATE,
    Wydatki FLOAT,
    FK_ID_Diagnozy INT,
    FOREIGN KEY (FK_ID_Diagnozy) REFERENCES Diagnozy(Id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE UczestnictwaWNaprawie (
    ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    DataRozpoczeciaPracy DATE,
    DataZakonczeniaPracy DATE,
    FK_ID_HistoriiNaprawy INT,
    FK_ID_Osoby INT,
    FOREIGN KEY (FK_ID_HistoriiNaprawy) REFERENCES HistorieNaprawy(Id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (FK_ID_Osoby) REFERENCES Osoby(Id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE ZgloszeniaAwarii (
    ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Opis VARCHAR(255),
    WagaZgloszenia FLOAT,
    SkutkiAwarii VARCHAR(255),
    FK_ID_Diagnozy INT,
    FOREIGN KEY (FK_ID_Diagnozy) REFERENCES Diagnozy(Id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Naprawy (
    ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    CelNaprawy VARCHAR(255),
    InstrukcjaNaprawy VARCHAR(255),
    PotrzebneNarzedzia VARCHAR(255),
    Uwagi VARCHAR(255),
    FK_ID_StacjiKosmicznej INT,
    FK_ID_SztucznegoSatelity INT,
    FOREIGN KEY (FK_ID_StacjiKosmicznej) REFERENCES StacjeKosmiczne(Id),
    FOREIGN KEY (FK_ID_SztucznegoSatelity) REFERENCES SztuczneSatelity(Id)
);

CREATE TABLE DiagNapr (
    FK_ID_Diagnozy INT,
    FK_ID_Naprawy INT,
    PRIMARY KEY (FK_ID_Diagnozy, FK_ID_Naprawy),
    FOREIGN KEY (FK_ID_Diagnozy) REFERENCES Diagnozy(Id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (FK_ID_Naprawy) REFERENCES Naprawy(Id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE DiagOsob (
    FK_ID_Diagnozy INT,
    FK_ID_Osoby INT,
    PRIMARY KEY (FK_ID_Diagnozy, FK_ID_Osoby),
    FOREIGN KEY (FK_ID_Diagnozy) REFERENCES Diagnozy(Id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (FK_ID_Osoby) REFERENCES Osoby(Id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE NaprHist (
    FK_ID_Naprawy INT,
    FK_ID_HistoriiNapraw INT,
    PRIMARY KEY (FK_ID_Naprawy, FK_ID_HistoriiNapraw),
    FOREIGN KEY (FK_ID_Naprawy) REFERENCES Naprawy(Id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (FK_ID_HistoriiNapraw) REFERENCES HistorieNaprawy(Id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE WarsOsob (
    FK_ID_Osoby INT,
    FK_ID_Warsztatu INT,
    PRIMARY KEY (FK_ID_Osoby, FK_ID_Warsztatu),
    FOREIGN KEY (FK_ID_Osoby) REFERENCES Osoby(Id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (FK_ID_Warsztatu) REFERENCES WarsztatyTechniczne(Id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE SztuWars (
    FK_ID_SztucznegoSatelity INT,
    FK_ID_Warsztatu INT,
    PRIMARY KEY (FK_ID_SztucznegoSatelity, FK_ID_Warsztatu),
    FOREIGN KEY (FK_ID_SztucznegoSatelity) REFERENCES SztuczneSatelity(Id),
    FOREIGN KEY (FK_ID_Warsztatu) REFERENCES WarsztatyTechniczne(Id)
);

CREATE TABLE NaprUmie (
    FK_ID_Naprawy INT,
    FK_ID_Umiejetnosci INT,
    PRIMARY KEY (FK_ID_Naprawy, FK_ID_Umiejetnosci),
    FOREIGN KEY (FK_ID_Naprawy) REFERENCES Naprawy(Id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (FK_ID_Umiejetnosci) REFERENCES Umiejetnosci(Id) ON UPDATE CASCADE ON DELETE CASCADE
);
