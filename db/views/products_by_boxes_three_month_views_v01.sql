SELECT
  product_incidents.box_id,
  products.code,
  products.name,
  product_incidents.product_id,
  SUM(quantity) quantity
FROM product_incidents,
     products
WHERE products.id = product_incidents.product_id
AND product_incidents.created_at > CURRENT_DATE - INTERVAL '3 months'
GROUP BY product_incidents.box_id,
         products.code,
         products.name,
         product_incidents.product_id
ORDER BY box_id,quantity DESC;
