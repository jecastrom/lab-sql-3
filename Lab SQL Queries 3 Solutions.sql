/*
Lab | SQL Queries 3
In this lab, you will be using the Sakila database of movie rentals. You have been using this database
for a couple labs already, but if you need to get the data again, refer to the official installation link.
*//*
Instructions:

1) How many distinct (different) actors' last names are there?
*/
SELECT count(DISTINCT last_name)
FROM actor;








/*
2) In how many different languages where the films originally produced? (Use the column language_id from the film table)
*/
SELECT DISTINCT language_id
FROM film;








/*
3) How many movies were released with "PG-13" rating?
*/
SELECT count(DISTINCT rating)
FROM film
WHERE rating = 'PG-13';








/*
4) Get 10 the longest movies from 2006.
*/
SELECT *
FROM film
WHERE release_year = 2006
ORDER BY LENGTH DESC LIMIT 10;







/*
5) How many days has been the company operating (check DATEDIFF() function)?
*/
SELECT datediff(now(), (min(rental_date)))
FROM rental;
/*
The result is 6049 days in operation
*//*

To express the same result in years:

Using the timestamdiff() function which give us an extra argument to format
the result either in month, years, days.
*/
SELECT timestampdiff(YEAR, (min(rental_date)), now()) AS Time_in_operations
FROM rental;

/*
To express the dame result in years and month:

To obtain the year, I calculate the time period with timestampdiff in months,
using the floor() function, will make the result to go to the lowest integer.

floor(timestampdiff(MONTH, (min(rental_date)), now()) / 12)

To calculate the months, I use the same operation but this time using the MOD() function,
which will multiply only the reminder or the decimal part of the calculation, which is
a decimal of months (0.5 month). On the second argument of the MOD() function I use 12
so MOD() can multiply the decimal reminder by 12, as 0.5 years * 12 is 6 months

mod(timestampdiff(MONTH, (min(rental_date)), now()), 12)

             
*/
SELECT CONCAT(
                 floor(timestampdiff(MONTH, (min(rental_date)), now()) / 12),
                 ' Years ',
                 mod(timestampdiff(MONTH, (min(rental_date)), now()), 12),
                 ' Month'
             ) AS No_of_years_month_in_operation
FROM rental;






/*

6) Show rental info with additional columns month and weekday. Get 20.

I have chosen date_format() function as it gives me more fredom on the date format I want.
The extract() function only extracts the numerical values of the date.
*/
SELECT *,
       date_format(rental_date, '%M') AS month_,
       date_format(rental_date, '%W') AS weekday
FROM rental
LIMIT 20;






/*
7) Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
*/

SELECT
    *,
    CASE
        WHEN week_day_index BETWEEN 2 AND 6 THEN 'Workday'
        ELSE 'Weekend'
    END AS day_type
FROM
    rental,
    (
        SELECT
            dayofweek(rental_date) AS week_day_index
        FROM
            rental
    ) AS t_temp
LIMIT 10;
    
    
    
    
    
    
/*
8) How many rentals were in the last month of activity?
*/

# There were 182 rentals
# I found best to do a subquery as the WHRER clause does not allow to filter (max(rental_date))

SELECT
    count(*)
FROM
    rental
WHERE
    rental_date = (
        SELECT
            max(rental_date)
        FROM
            rental
    );


				










