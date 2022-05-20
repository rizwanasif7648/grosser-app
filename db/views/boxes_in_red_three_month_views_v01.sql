SELECT          a."Month",
                b.customer_id,
                b.boxes
FROM            (
                       SELECT To_char(dd, 'Mon') AS "Month"
                       FROM   generate_series ( CURRENT_DATE - INTERVAL '3 months', CURRENT_DATE, '1 month':: INTERVAL) dd) a
LEFT OUTER JOIN
                (
                         SELECT   to_char(UPDATED_AT, 'Mon') AS "Month",
                                  customer_id ,
                                  count(customer_id) boxes
                         FROM     boxes
                         WHERE    boxes.UPDATED_AT > CURRENT_DATE - INTERVAL '3 months'
					     AND  boxes.color = 'health-red'
                         GROUP BY "Month",
                                  customer_id) b
ON              a."Month" = b."Month";
