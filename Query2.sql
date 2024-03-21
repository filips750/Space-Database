-- 4

-- Mamy dziury w bud�ecie i zdecydowali�my si� na zwolnienie najmniej pracuj�cych
-- pracownik�w, znajd� po jednej osobie z ka�dego warszatu technicznego, kt�ra
-- wykona�a najmniejsz� ilo�� napraw przez ostatnie 2 lata i j� usu�

CREATE VIEW RANKED_OSOBY AS
SELECT
    o.ID AS OsobaID,
    o.Imie,
    o.Nazwisko,
    wo.FK_ID_Warsztatu,
    ROW_NUMBER() OVER (PARTITION BY wo.FK_ID_Warsztatu ORDER BY COUNT(u.ID) ASC) AS RN
FROM
    Osoby o
    JOIN UczestnictwaWNaprawie u ON o.ID = u.FK_ID_Osoby
    JOIN WarsOsob wo ON o.ID = wo.FK_ID_Osoby
    JOIN HistorieNaprawy hn ON u.FK_ID_HistoriiNaprawy = hn.ID
WHERE
    hn.PoczatekNaprawy >= DATEADD(YEAR, -2, GETDATE()) -- tylko naprawy z ostatnich 2 lat
GROUP BY
    o.ID, o.Imie, o.Nazwisko, wo.FK_ID_Warsztatu;

