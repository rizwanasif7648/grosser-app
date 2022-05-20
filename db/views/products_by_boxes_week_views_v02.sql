SELECT
  product_incidents.box_id,
  products.code,
  products.name,
  product_incidents.product_id,
  SUM(quantity) quantity
FROM product_incidents,
     products
WHERE products.id = product_incidents.product_id
AND product_incidents.created_at > CURRENT_DATE - 7
AND product_incidents.status not in (2)
AND products.status not in (2)
GROUP BY product_incidents.box_id,
         products.code,
         products.name,
         product_incidents.product_id
ORDER BY box_id,quantity DESC;
