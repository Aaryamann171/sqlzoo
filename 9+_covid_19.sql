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

-- 5
/* Show the number of new cases in Italy for each week - show Monday only. */

SELECT tw.name, DATE_FORMAT(tw.whn,'%Y-%m-%d') as date, 
tw.confirmed - lw.confirmed as new_cases -- this week - last week
FROM covid tw LEFT JOIN covid lw ON 
DATE_ADD(lw.whn, INTERVAL 1 WEEK) = tw.whn
AND tw.name=lw.name
WHERE tw.name = 'Italy'
AND WEEKDAY(tw.whn) = 0
ORDER BY tw.whn

-- 6
/* The query shown shows the number of confirmed cases together with the world ranking for cases.

United States has the highest number, Spain is number 2...

Notice that while Spain has the second highest confirmed cases, Italy has the second highest number of deaths due to the virus.

Include the ranking for the number of deaths in the table. */

SELECT 
name, 
confirmed,
RANK() OVER (ORDER BY confirmed DESC) as rc,
deaths,
RANK() OVER (ORDER by deaths DESC) as rd
FROM covid
WHERE whn = '2020-04-20'
ORDER BY confirmed DESC

-- 7
/* The query shown includes a JOIN t the world table so we can access the total population of each country and calculate infection rates (in cases per 100,000).

Show the infect rate ranking for each country. Only include countries with a population of at least 10 million. */

SELECT 
world.name,
ROUND(100000*confirmed/population,0),
RANK() OVER (ORDER BY confirmed/population) AS rank
FROM covid JOIN world ON covid.name=world.name
WHERE whn = '2020-04-20' AND population > 10000000
ORDER BY population DESC

-- 8
/* For each country that has had at last 1000 new cases in a single day, show the date of the peak number of new cases. */
