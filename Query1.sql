use dbnasa;

-- 1
-- Nasa chce przyci�c koszty i musi zrezygnowac z jednego rodzaju satelit. Przygotuj
-- zestawienie 10 najcz�ciej psuj�cych si� rodzaji satelity(malej�co).
SELECT TOP 10
    s.RodzajSatelity,
    COUNT(*) AS LiczbaAwarii
FROM
    HistorieNaprawy hn
    JOIN Diagnozy d ON hn.FK_ID_Diagnozy = d.ID
    JOIN SztuczneSatelity s ON d.FK_ID_SztucznegoSatelity = s.ID
GROUP BY
    s.RodzajSatelity
ORDER BY
    LiczbaAwarii DESC;

-- 2

-- Ludzie na robice XXXX, chc� z�o�yc prezent osobie kt�ra serwisuje ich satelity. Przygotuj
-- zestawienie 10 os�b, kt�re wykona�y najwi�cej napraw na orbicie XXXX

SELECT
    o.Imie,
    o.Nazwisko,
    COUNT(DISTINCT u.ID) AS IloscNapraw
FROM
    UczestnictwaWNaprawie u
    JOIN Osoby o ON u.FK_ID_Osoby = o.ID
	JOIN WarsOsob wo on o.ID = wo.FK_ID_Osoby
	JOIN WarsztatyTechniczne wt on wt.ID = wo.FK_ID_Warsztatu
	JOIN StacjeKosmiczne sk on sk.ID = wt.FK_ID_StacjiKosmicznej
WHERE
    sk.FK_ID_Orbity = (SELECT Id FROM Orbita WHERE TypOrbity = 'Orbita stacji kosmicznej')
GROUP BY
    o.ID, o.Imie, o.Nazwisko
ORDER BY
    IloscNapraw DESC;

-- 3

-- Dostali�my zlecenie od jednej z naszych wsp�pracuj�cych firm aby znale�� 5
-- (rosn�co) orbit na kt�rych firma GlobalSat mia�a najwi�kszy �redni bud�et na
-- naprawe swoich sztucznych satelit.

SELECT TOP 5 
		o.ID AS OrbitaID,
		o.TypOrbity,
		AVG(hn.Wydatki) AS SrednieWydatki
	FROM Orbita o
	JOIN SztuczneSatelity ss ON o.ID = ss.FK_ID_Orbity
	JOIN Diagnozy d ON ss.ID = d.FK_ID_SztucznegoSatelity
	JOIN HistorieNaprawy hn ON d.ID = hn.FK_ID_Diagnozy
	WHERE ss.Wlasciciel LIKE 'GlobalSat'
GROUP BY o.ID, o.TypOrbity
ORDER BY AVG(hn.Wydatki) DESC;

-- 5

-- Na ksi�ycu zepsu�a si� Stacja kosmiczna NASA, znajd� imi� i nazwisko osoby
-- kt�ra jest na tym ciele niebieskim, ma aktualne uprawnienia na wymian� ma�ych komponent�w
-- oraz ma du�o wykonanych napraw
SELECT
    Osoby.Imie,
    Osoby.Nazwisko,
    COUNT(DISTINCT UczestnictwaWNaprawie.ID) AS IloscNapraw
FROM
    UczestnictwaWNaprawie
    JOIN HistorieNaprawy ON UczestnictwaWNaprawie.FK_ID_HistoriiNaprawy = HistorieNaprawy.ID
    JOIN Diagnozy ON HistorieNaprawy.FK_ID_Diagnozy = Diagnozy.ID
    JOIN SztuczneSatelity ON Diagnozy.FK_ID_SztucznegoSatelity = SztuczneSatelity.ID
    JOIN Osoby ON UczestnictwaWNaprawie.FK_ID_Osoby = Osoby.ID
    JOIN WarsOsob ON Osoby.ID = WarsOsob.FK_ID_Osoby
    JOIN WarsztatyTechniczne ON WarsOsob.FK_ID_Warsztatu = WarsztatyTechniczne.ID
    JOIN PotwierdzeniaUmiejetnosci ON Osoby.ID = PotwierdzeniaUmiejetnosci.FK_ID_Osoby
    JOIN Umiejetnosci ON PotwierdzeniaUmiejetnosci.FK_ID_Umiejetnosci = Umiejetnosci.ID
WHERE
    WarsztatyTechniczne.FK_ID_StacjiKosmicznej = (SELECT ID FROM StacjeKosmiczne WHERE Wlasciciel = 'NASA')
	AND Umiejetnosci.Id = (SELECT ID FROM Umiejetnosci WHERE OpisUmiejetnosci = 'Wymiana Ma�ych Komponent�w')
    AND PotwierdzeniaUmiejetnosci.CzyAktywne = 1
    AND PotwierdzeniaUmiejetnosci.DataWygasniecia < GETDATE()
GROUP BY
	IloscNapraw,
    Osoby.Imie,
    Osoby.Nazwisko
ORDER BY
    IloscNapraw ASC;


-- 6
-- Po raz kolejny psuje si� komputer pok�adowy. Kierownik zaczyna podejrzewa� �e,
-- osoby naprawiaj�ce komputer pok�adowy nie mia�y odpowiednich uprawnie� w tamtym okresie.
-- Zweryfikuj poprawno�� ich uprawnie� dla wszystkich napraw kt�re zosta�y wykonane

SELECT
    Osoby.Imie,
    Osoby.Nazwisko,
    potrzebne.OpisUmiejetnosci AS potrzebneOpis,
	posiadane.OpisUmiejetnosci AS posiadaneOpis,
    Diagnozy.DokladnyOpisAwarii,
	PotwierdzeniaUmiejetnosci.DataZdobycia,
    PotwierdzeniaUmiejetnosci.DataWygasniecia,
	HistorieNaprawy.poczatekNaprawy AS poczatekNaprawy,
	HistorieNaprawy.KoniecNaprawy AS koniecNaprawy
FROM
    HistorieNaprawy
	JOIN UczestnictwaWNaprawie ON HistorieNaprawy.ID = UczestnictwaWNaprawie.FK_ID_HistoriiNaprawy
	JOIN Osoby ON UczestnictwaWNaprawie.FK_ID_Osoby = Osoby.ID
	JOIN PotwierdzeniaUmiejetnosci ON Osoby.ID = PotwierdzeniaUmiejetnosci.FK_ID_Osoby
	JOIN Umiejetnosci AS posiadane ON PotwierdzeniaUmiejetnosci.FK_ID_Umiejetnosci = posiadane.ID
	JOIN Diagnozy ON Diagnozy.ID = HistorieNaprawy.FK_ID_Diagnozy
	JOIN DiagNapr ON DiagNapr.FK_ID_Diagnozy = Diagnozy.ID
	JOIN Naprawy ON Naprawy.ID = DiagNapr.FK_ID_Naprawy
	JOIN NaprUmie ON NaprUmie.FK_ID_Naprawy = Naprawy.ID
	JOIN Umiejetnosci AS potrzebne ON NaprUmie.FK_ID_Umiejetnosci = potrzebne.ID
WHERE
    HistorieNaprawy.Opis LIKE '%'
	AND potrzebne.Id = posiadane.Id
    -- AND PotwierdzeniaUmiejetnosci.CzyAktywne = 1
    AND (PotwierdzeniaUmiejetnosci.DataWygasniecia >= HistorieNaprawy.KoniecNaprawy
    OR PotwierdzeniaUmiejetnosci.DataZdobycia <= HistorieNaprawy.PoczatekNaprawy)
GROUP BY
	HistorieNaprawy.Id,
	Osoby.Imie,
    Osoby.Nazwisko,
    potrzebne.OpisUmiejetnosci,
	posiadane.OpisUmiejetnosci,
    Diagnozy.DokladnyOpisAwarii,
	PotwierdzeniaUmiejetnosci.DataZdobycia,
    PotwierdzeniaUmiejetnosci.DataWygasniecia,
	poczatekNaprawy,
	koniecNaprawy
ORDER BY
	Osoby.Imie,
    Osoby.Nazwisko;


-- 7
-- Za sprawne wykrycie powa�nej awarii szef NASA chce wynagrodzi� osob� kt�ra zg�osi�a najdro�sz� awari�
-- Znajd� jej imi� i nazwisko

WITH SumaWydatkowNaOsobe AS (
    SELECT
        O.Imie + ' ' + O.Nazwisko AS Osoba,
        SUM(hn.Wydatki) AS SumaWydatkow
    FROM
    Osoby O
    JOIN DiagOsob ON DiagOsob.FK_ID_Osoby = O.ID
	JOIN Diagnozy ON Diagnozy.ID = DiagOsob.FK_ID_Diagnozy
	JOIN HistorieNaprawy hn ON hn.FK_ID_Diagnozy = Diagnozy.Id
    GROUP BY
        O.Imie, O.Nazwisko
)
SELECT TOP 1
    Osoba,
	SumaWydatkow
FROM
    SumaWydatkowNaOsobe
ORDER BY
    SumaWydatkow DESC;
