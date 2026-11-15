SELECT u.RollBeskrivning AS Uppdrag, ku.FöretagsNamn AS Företag, ko.Namn AS Konsult, u.StartDatum AS Startdatum, u.SlutDatum AS Slutdatum
FROM Kunder ku
INNER JOIN Uppdrag u ON ku.Id = u.KundId
INNER JOIN Konsulter ko ON ko.Id = u.KonsultId