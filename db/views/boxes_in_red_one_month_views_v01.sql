SELECT a.week,
       b.customer_id,
       b.boxes
FROM   (SELECT Date_part('week', dd:: date)  AS week
        FROM   generate_series ( CURRENT_DATE - 30, CURRENT_DATE - 1, '1 week'::
               interval)
               dd) a
       LEFT OUTER JOIN (SELECT
  date_part('week', updated_at::date) AS week,
  customer_id ,
    count(customer_id) boxes
FROM boxes
WHERE boxes.updated_at > CURRENT_DATE - interval '1 months'
AND  boxes.color = 'health-red'
GROUP BY "week",
         customer_id) b
 ON a.week = b.week;
