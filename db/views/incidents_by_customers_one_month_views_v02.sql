SELECT A.week,
       B.customer_id,
       B.incidents
FROM   (SELECT date_part('week', dd:: DATE)  AS week
        FROM   generate_series ( current_date - 30, current_date - 1, '1 week'::
               interval)
               DD) A
       LEFT OUTER JOIN (SELECT
  date_part('week', created_at::date) AS week,
  customer_id ,
    COUNT(customer_id) incidents
FROM product_incidents
WHERE product_incidents.created_at > CURRENT_DATE - INTERVAL '1 months'
AND  product_incidents.status not in (2)
GROUP BY "week",
         customer_id) B
                    ON A.week = B.week;
