SELECT k.FöretagsNamn, COUNT (u.Id) AS [Antal uppdrag]
FROM Kunder k
INNER JOIN Uppdrag u ON k.Id = u.KundId
GROUP BY k.FöretagsNamn

