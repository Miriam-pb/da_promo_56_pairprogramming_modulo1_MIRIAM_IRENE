USE northwind;
-- Extraed los pedidos con el máximo "order_date" para cada empleado.
SELECT * FROM orders (
ORDER BY orderdate DESC
GROUP BY employeeid
;

SELECT MAX(orderdate) -- , employeeid 
FROM orders
GROUP BY employeeid;

SELECT o1.orderid, o1.customerid, o1.employeeid, o1.orderdate, o1.requireddate 
FROM orders AS o1
WHERE orderdate = 
(SELECT MAX(orderdate)
				FROM orders AS o2
				WHERE o2.employeeid = o1.employeeid);

-- Extraed información de los productos "Beverages"
-- idproducto nombre del product y id de categoria
-- categories: categoryid, categoryname
-- products: categoryid, productid, productname
-- opción con JOIN
SELECT p.productid, p.productname, p.categoryid, c.categoryid, c.categoryname FROM products AS p
INNER JOIN categories AS c
ON p.categoryid = c.categoryid
WHERE c.categoryname IN ('Beverages');
-- opción con SUBCONSULTA
SELECT productid, productname, categoryid
FROM products
WHERE categoryid IN (
    SELECT categoryid
    FROM categories
    WHERE categoryname = 'Beverages');
    -- 
-- Extraed la lista de países donde viven los clientes, pero no hay ningún proveedor ubicado en ese país
-- customers.country = suppliers.country
-- S.SUPPLIERID, S.COUNTRY
SELECT DISTINCT c.country
FROM customers AS C 
WHERE c.country NOT IN
(SELECT s.country FROM suppliers AS s);
-- (lista de countries donde hay suppliers)

-- Extraer los clientes que compraron mas de 20 artículos "Grandma's Boysenberry Spread"
-- orders_details (orderid, productid) y products (productname)
SELECT * FROM products
SELECT orderid, customerid FROM orders
WHERE productname = "Grandma's Boysenberry Spread" ;
