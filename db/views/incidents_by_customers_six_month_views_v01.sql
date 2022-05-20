SELECT          A."Month",
                B.customer_id,
                B.incidents
FROM            (
                       SELECT To_char(dd, 'Mon') AS "Month"
                       FROM   generate_series ( CURRENT_DATE - interval '6 months', CURRENT_DATE, '1 month':: interval) dd) A
LEFT OUTER JOIN
                (
                         SELECT   to_char(created_at, 'Mon') AS "Month",
                                  customer_id ,
                                  count(customer_id) incidents
                         FROM     product_incidents
                         WHERE    product_incidents.created_at > CURRENT_DATE - interval '6 months'
                         GROUP BY "Month",
                                  customer_id) B
ON              A."Month" = B."Month";
