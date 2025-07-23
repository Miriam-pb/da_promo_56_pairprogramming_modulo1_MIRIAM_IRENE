USE northwind
SELECT * FROM products;
SELECT MIN(UnitPrice) AS lowestPrice, MAX(UnitPrice) AS highestPrice FROM products
SELECT COUNT(UnitsInStock) FROM products
SELECT SUM(UnitsInStock), AVG(UnitPrice) FROM products
SELECT * FROM orders;
SELECT DISTINCT ShipCountry FROM orders
SELECT MIN(Freight), MAX(Freight)
FROM orders
WHERE ShipCountry = "UK";
SELECT AVG(UnitPrice) FROM products
SELECT ProductName, UnitPrice FROM products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM products)
ORDER BY UnitPrice ASC
-- Qué productos se han descontinuado:
SELECT productname, Discontinued FROM products
WHERE Discontinued = 1

SELECT COUNT(Discontinued) FROM products
WHERE Discontinued = 1
-- EJER 6: dicionalmente nos piden detalles de aquellos productos no descontinuados
SELECT productid, productname FROM products 
WHERE discontinued = 0
ORDER BY productid DESC
LIMIT 10
-- otra opción
SELECT COUNT(Discontinued) FROM products
GROUP BY Discontinued
HAVING Discontinued = 1;

-- EJER 7: Relación entre número de pedidos y máxima carga:
-- num_pedidos, freight, employeeid
SELECT * FROM orders

SELECT employeeid AS empleado, COUNT(orderid) AS num_pedidos, MAX(Freight) AS carga_max FROM orders
GROUP BY employeeid

-- EJER 8 Descartar pedidos sin fecha y ordénalos
SELECT employeeid AS empleado, COUNT(orderid) AS num_pedidos, MAX(Freight) AS carga_max, ShippedDate FROM orders
WHERE ShippedDate IS NOT NULL
GROUP BY employeeid, ShippedDate

SELECT employeeid AS empleado, COUNT(orderid) AS num_pedidos, MAX(Freight) AS carga_max, ShippedDate FROM orders
GROUP BY employeeid, ShippedDate
HAVING ShippedDate IS NOT NULL
-- EJER 9 Números de pedidos por día
SELECT COUNT(orderid) AS num_pedidos, 
DAY(ShippedDate) AS día, MONTH(ShippedDate) AS mes, YEAR(ShippedDate) AS año FROM orders
GROUP BY ShippedDate
HAVING día IS NOT NULL




