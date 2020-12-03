-- 1
/* show data from Spai from march */

SELECT name, DAY(whn),
confirmed, deaths, recovered
FROM covid
WHERE name = 'Spain'
AND MONTH(whn) = 3
ORDER BY whn

-- 2
/* show confirmed for the day before. */

SELECT name, DAY(whn), confirmed,
LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn) as lag
FROM covid
WHERE name = 'Italy'
AND MONTH(whn) = 3
ORDER BY whn

-- 3
/* Show the number of new cases for each day, for Italy, for March. */

SELECT name, DAY(whn), confirmed - LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn) as new_cases
FROM covid
WHERE name = 'Italy'
AND MONTH(whn) = 3
ORDER BY whn

-- 4
/* Show the number of new cases in Italy for each week - show Monday only. */

SELECT name, DATE_FORMAT(whn,'%Y-%m-%d') as date, confirmed - LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn) as new_cases
FROM covid
WHERE name = 'Italy' and WEEKDAY(whn) = 0
AND WEEKDAY(whn) = 0
ORDER BY whn
