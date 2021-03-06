
CREATE VIEW vw_highest_order_numbers
AS 
SELECT shipname, COUNT(shipname) AS "number of orders"
FROM orders
GROUP BY shipname
ORDER BY COUNT(shipname) DESC;
