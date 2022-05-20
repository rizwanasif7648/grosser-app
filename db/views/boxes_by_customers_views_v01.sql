SELECT
  customers.id,
  customers.name,
  COALESCE(boxes.color,'health-blue') color,
  COUNT(boxes.color) COUNT
FROM customers
     LEFT JOIN boxes
ON customers.id = boxes.customer_id
GROUP BY boxes.color,
         customers.id,
         customers.name
order by customers.id;