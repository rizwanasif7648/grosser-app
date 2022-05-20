SELECT A.DATE,
       B.customer_id,
       B.incidents
FROM   (SELECT Date_trunc('day', dd) :: DATE AS DATE
        FROM   generate_series ( current_date - 7, current_date - 1, '1 day'::
               interval)
               DD) A
       LEFT OUTER JOIN (SELECT created_at :: DATE AS DATE,
                               customer_id,
                               Count(customer_id) incidents
                        FROM   product_incidents
                        WHERE  created_at > current_date - 7
                        AND    product_incidents.status not in (2)
                        GROUP  BY created_at :: DATE,
                                  customer_id) B
                    ON A.DATE = B.DATE;