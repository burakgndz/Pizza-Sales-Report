
SELECT 
CAST(SUM(total_price) AS decimal(10,2)) AS TOTAL_REVENUE,
COUNT(DISTINCT order_id) AS TOTAL_ORDERS,
SUM(quantity) AS TOTAL_PIZZA_SOLD,
CAST(CAST(SUM(total_price) AS decimal(10,2))/COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS AVG_ORDER_VALUE,
CAST(CAST(SUM(quantity) AS decimal(10,2))/COUNT(DISTINCT order_id) AS decimal(10,2)) AS AVG_PIZZA_PER_ORDER
FROM pizza_sales

SELECT
DATENAME(DW,order_date) AS ORDER_DAY,
COUNT(DISTINCT order_id) AS TOTAL_ORDERS
FROM pizza_sales
GROUP BY DATENAME(DW,order_date)
ORDER BY TOTAL_ORDERS DESC

SELECT
DATENAME(MONTH, order_date) AS ORDER_MONTH,
COUNT(DISTINCT order_id) AS TOTAL_ORDERS
FROM pizza_sales
GROUP BY DATENAME(MONTH,order_date)
ORDER BY TOTAL_ORDERS DESC


SELECT
pizza_category,
CAST(SUM(total_price) AS decimal(10,2)) AS TOTAL_REVENUE,
CAST(CAST(100*SUM(total_price) AS decimal(10,2))/(SELECT SUM(total_price) FROM pizza_sales)
AS decimal(10,2)) AS '% OF REVENUE'
FROM pizza_sales
GROUP BY pizza_category
ORDER BY '% OF REVENUE' DESC



SELECT
pizza_size,
CAST(SUM(total_price) AS decimal(10,2)) AS TOTAL_REVENUE,
CAST(CAST(100*SUM(total_price) AS decimal(10,2))/(SELECT SUM(total_price) FROM pizza_sales)
AS decimal(10,2)) AS '% OF REVENUE'
FROM pizza_sales
GROUP BY pizza_size
ORDER BY '% OF REVENUE' DESC



SELECT
pizza_category,
SUM(quantity) AS 'Total Pizza Sold'
FROM pizza_sales
GROUP BY pizza_category
ORDER BY 'Total Pizza Sold' DESC

SELECT
TOP 5
pizza_name,
SUM(total_price) AS TOTAL_REVENUE
FROM pizza_sales
GROUP BY pizza_name
ORDER BY TOTAL_REVENUE DESC



SELECT
TOP 5
pizza_name,
CAST(SUM(total_price) AS decimal(10,2)) AS TOTAL_REVENUE
FROM pizza_sales
GROUP BY pizza_name
ORDER BY TOTAL_REVENUE ASC


SELECT
TOP 5
pizza_name,
COUNT(DISTINCT order_id) AS TOTAL_ORDERS
FROM pizza_sales
GROUP BY pizza_name
ORDER BY TOTAL_ORDERS DESC



SELECT
TOP 5
pizza_name,
COUNT(DISTINCT order_id) AS TOTAL_ORDERS
FROM pizza_sales
GROUP BY pizza_name
ORDER BY TOTAL_ORDERS ASC


SELECT
TOP 5
pizza_name,
SUM(quantity) AS 'Total Pizza Sold'
FROM pizza_sales
GROUP BY pizza_name
ORDER BY 'Total Pizza Sold' DESC



SELECT
TOP 5
pizza_name,
SUM(quantity) AS 'Total Pizza Sold'
FROM pizza_sales
GROUP BY pizza_name
ORDER BY 'Total Pizza Sold' ASC