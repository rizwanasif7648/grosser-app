SELECT A.DATE,
       B.customer_id,
       B.boxes
FROM   (SELECT Date_trunc('day', dd) :: DATE AS DATE
        FROM   generate_series ( current_date - 7, current_date - 1, '1 day'::
               interval)
               DD) A
       LEFT OUTER JOIN (SELECT updated_at :: DATE AS DATE,
                               customer_id,
                               Count(customer_id) boxes
                        FROM   boxes
                        WHERE  updated_at > current_date - 7
  				    AND  boxes.COLOR = 'health-red'
                    AND  boxes.status not in (2)
                        GROUP  BY updated_at :: DATE,
                                  customer_id) B
                    ON A.DATE = B.DATE;
