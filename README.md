# Inlämningsuppgift 1
Bild på ER-diagrammet från Lucidchart finns i repot.

## Normaliseringsmotivering
1NF: Tabellerna uppfyller kraven för 1NF då kolumnerna innehåller atomära värden och har unika primärnycklar.

2NF: Tabellerna uppfyller kraven för 2NF då tabellerna saknar partiella beroenden. Jag har delat upp informationen i 3 olika tabeller där alla kolumner i varsin tabell är beroende av en enda primärnyckel.
     Det finns alltså inte flera primärnycklar i samma tabell där exempelvis vissa kolumner är beroende av ena medan vissa kolumner är beroende av den andra.
     
3NF: Tabellerna innehåller inte några transitiva beroenden, vilket betyder att mina icke-nycklar inte är beroende av något annat än tabellens primärnyckel.
     Jag har som tidigare nämnt delat upp informationen i tre tabeller vilket gör att exempelvis tabellen Kunder exempelvis inte innehåller någon information kring konsulter eller uppdrag.

## Om din databas nås via en publik webbapplikation, på vilket sätt skyddar du systemet så att en angripare inte kan skriva skadlig SQL-kod i ett inmatningsfält och radera hela din databas (SQL Injection)?
Genom att använda parametriserade SQL-frågor där användar-input behandlas som data och inte körbar kod.

## Om FailSafe IT växer till tusentals kunder och miljontals uppdrag, vilken databasfunktion bör du implementera på tabellerna för att säkerställa att sökningar efter specifika organisationsnummer fortfarande går blixtsnabbt?
Genom att implementera Non-Clustered Index vilket gör det snabbare att söka efter specifik data utan att leta igenom hela tabellen. Dessutom skriva SARGable kod!
