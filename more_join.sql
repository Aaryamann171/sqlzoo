-- 1
/* List the films where the yr is 1962 */

SELECT id, title
FROM movie
WHERE yr = 1962

-- 2
/* Give year of 'Citizen Kane' */

SELECT yr
FROM movie
WHERE title = 'Citizen Kane'

-- 3
/* List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year. */

select id, title, yr
from movie
where title like 'Star Trek%'
order by yr

-- 4
/* What id number does the actor 'Glenn Close' have? */

select id
from actor
where name = 'Glenn Close'

-- 5
/* What is the id of the film 'Casablanca' */

select id
from movie 
where title = 'Casablanca'

-- 6
/* Obtain the cast list for 'Casablanca'. */

select name 
from casting join actor on casting.actorid = actor.id
where movieid = 11768

-- 7
/* Obtain the cast list for the film 'Alien' */

select name from
actor join casting on actor.id = casting.actorid
where movieid = (select id from movie where title = 'Alien')

-- 8
/* List the films in which 'Harrison Ford' has appeared */

select movie.title
from movie join casting on movie.id = casting.movieid
where casting.actorid = (select id from actor where name = 'Harrison Ford')

-- 9
/* List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role] */

select movie.title
from movie join casting on movie.id = casting.movieid
where casting.actorid = (select id from actor where name = 'Harrison Ford') and ord <> 1

-- 10
/* List the films together with the leading star for all 1962 films. */

select title, actor.name
from movie 
join casting on movie.id = casting.movieid
join actor on casting.actorid = actor.id
where movie.yr = 1962 and ord = 1
