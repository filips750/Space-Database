use dbnasa;

-- 1
-- Nasa chce przyci¹c koszty i musi zrezygnowac z jednego rodzaju satelit. Przygotuj
-- zestawienie 10 najczêœciej psuj¹cych siê rodzaji satelity(malej¹co).
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

-- Ludzie na robice XXXX, chc¹ z³o¿yc prezent osobie która serwisuje ich satelity. Przygotuj
-- zestawienie 10 osób, które wykona³y najwiêcej napraw na orbicie XXXX

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

-- Dostaliœmy zlecenie od jednej z naszych wspó³pracuj¹cych firm aby znaleœæ 5
-- (rosn¹co) orbit na których firma GlobalSat mia³a najwiêkszy œredni bud¿et na
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

-- Na ksiê¿ycu zepsu³a siê Stacja kosmiczna NASA, znajdŸ imiê i nazwisko osoby
-- która jest na tym ciele niebieskim, ma aktualne uprawnienia na wymianê ma³ych komponentów
-- oraz ma du¿o wykonanych napraw
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
	AND Umiejetnosci.Id = (SELECT ID FROM Umiejetnosci WHERE OpisUmiejetnosci = 'Wymiana Ma³ych Komponentów')
    AND PotwierdzeniaUmiejetnosci.CzyAktywne = 1
    AND PotwierdzeniaUmiejetnosci.DataWygasniecia < GETDATE()
GROUP BY
	IloscNapraw,
    Osoby.Imie,
    Osoby.Nazwisko
ORDER BY
    IloscNapraw ASC;


-- 6
-- Po raz kolejny psuje siê komputer pok³adowy. Kierownik zaczyna podejrzewaæ ¿e,
-- osoby naprawiaj¹ce komputer pok³adowy nie mia³y odpowiednich uprawnieñ w tamtym okresie.
-- Zweryfikuj poprawnoœæ ich uprawnieñ dla wszystkich napraw które zosta³y wykonane

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
-- Za sprawne wykrycie powa¿nej awarii szef NASA chce wynagrodziæ osobê która zg³osi³a najdro¿sz¹ awariê
-- ZnajdŸ jej imiê i nazwisko

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
