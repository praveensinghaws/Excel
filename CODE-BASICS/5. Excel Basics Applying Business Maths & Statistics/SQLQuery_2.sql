WITH cte AS
    (SELECT movie_id,
            currency,
            ROUND(CASE
                      WHEN unit = 'Billions'
                           AND currency = 'USD' THEN budget * 80000
                      WHEN unit = 'Thousands'
                           AND currency = 'USD' THEN budget * 80 / 1000
                      WHEN currency = 'USD' THEN budget * 80
                      WHEN unit = 'Billions' THEN budget * 1000
                      WHEN unit = 'Thousands' THEN budget / 1000
                      ELSE budget
                  END, 2) AS budgetmlnINR,
            ROUND(CASE
                      WHEN unit = 'Billions'
                           AND currency = 'USD' THEN revenue * 80000
                      WHEN unit = 'Thousands'
                           AND currency = 'USD' THEN revenue * 80 / 1000
                      WHEN currency = 'USD' THEN revenue * 80
                      WHEN unit = 'Billions' THEN revenue * 1000
                      WHEN unit = 'Thousands' THEN revenue / 1000
                      ELSE revenue
                  END, 2) AS revenuemlnINR
     FROM financials)
SELECT m.title,
       cte.*
from cte
JOIN movies m on m.movie_id = cte.movie_id;