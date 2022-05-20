SELECT
  product_incidents.customer_id,
  products.code,
  products.name,
  product_incidents.product_id,
  SUM(quantity) quantity
FROM product_incidents,
     products
WHERE products.id = product_incidents.product_id
GROUP BY product_incidents.customer_id,
         products.code,
         products.name,
         product_incidents.product_id
ORDER BY quantity DESC;