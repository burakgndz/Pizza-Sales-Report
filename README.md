# Pizza-Report

Pizza Sales is a kaggle dataset recorded between january 01 - december 25, 2015. Main goal is to find some insights for pizza sales in order to help the owner to decide what to do.

Here are some insights: 

<ul>
  <li> The total revenue generated from pizza sales throughout the year amounts to $817,860. A total of 49,570 pizzas were sold. The average order value is $38.31, and the average number of pizzas per order is 2.32.</li>
  <li> Analyzing the hourly trend, we see that orders start increasing around 11:00 AM and peak during lunchtime (around 1:00 PM). After the lunch peak, there’s a gradual decline in orders throughout the afternoon. 2:00 PM and 3:00 PM show a dip. Orders start picking up again around 4:00 PM and continue steadily until 7:00 PM. Families and individuals often order pizzas for dinner during these hours. A drop in orders after 7:00 PM, with the lowest point at 11:00 PM.</li>
  <li> There is a noticeable increase in total orders from Wednesday to Friday, with Friday being the peak day for orders. For monlty trend, orders peaked in July and have been on a decline since then</li>
  <li> The Classic category has the highest percentage of sales at 26.91%, closely followed by Supreme (25.46%) and Chicken (23.96%). Veggie pizzas account for 23.68% of sales.</li>
  <li> The Large size dominates sales, constituting 45.89% of total orders. while X-Large pizzas contribute only 1.72%, and XX-Large is even lower at 0.12%. Evaluating whether it’s cost-effective to continue offering these sizes or if they can be phased out, can be discussed with the owner.</li>
</ul>

<hr>

## SQL Part of The Project
SQL is used to check whether the analysis made on Power BI is valid or not.

KPI's: 

```sql

SELECT 
CAST(SUM(total_price) AS decimal(10,2)) AS TOTAL_REVENUE,
COUNT(DISTINCT order_id) AS TOTAL_ORDERS,
SUM(quantity) AS TOTAL_PIZZA_SOLD,
CAST(CAST(SUM(total_price) AS decimal(10,2))/COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS AVG_ORDER_VALUE,
CAST(CAST(SUM(quantity) AS decimal(10,2))/COUNT(DISTINCT order_id) AS decimal(10,2)) AS AVG_PIZZA_PER_ORDER
FROM pizza_sales

```
Output:

![kpis](https://github.com/burakgndz/Pizza-Sales-Report/assets/56515947/c874d6c1-c5a6-4754-be0e-018d1418c6e6)

Order days with total order counts:

```sql
SELECT
DATENAME(DW,order_date) AS ORDER_DAY,
COUNT(DISTINCT order_id) AS TOTAL_ORDERS
FROM pizza_sales
GROUP BY DATENAME(DW,order_date)
ORDER BY TOTAL_ORDERS DESC
```

Output: 

![order_days_with_total_orders](https://github.com/burakgndz/Pizza-Sales-Report/assets/56515947/8d0da23e-d547-45a6-94b9-2dcdaa1dec9b)

Order months with total order counts:

```sql
SELECT
DATENAME(MONTH, order_date) AS ORDER_MONTH,
COUNT(DISTINCT order_id) AS TOTAL_ORDERS
FROM pizza_sales
GROUP BY DATENAME(MONTH,order_date)
ORDER BY TOTAL_ORDERS DESC
```

Output: 

![order_months_with_total_orders](https://github.com/burakgndz/Pizza-Sales-Report/assets/56515947/55502be9-49b5-4524-a948-b2f72247c130)

Pizza categories with total and percentage revenue:

```sql
SELECT
pizza_category,
CAST(SUM(total_price) AS decimal(10,2)) AS TOTAL_REVENUE,
CAST(CAST(100*SUM(total_price) AS decimal(10,2))/(SELECT SUM(total_price) FROM pizza_sales)
AS decimal(10,2)) AS '% OF REVENUE'
FROM pizza_sales
GROUP BY pizza_category
ORDER BY '% OF REVENUE' DESC
```

Output: 

![pizza_categories_with_revenue](https://github.com/burakgndz/Pizza-Sales-Report/assets/56515947/0b399ba4-677c-4fb9-8bd4-9ba221afa30b)

Pizza sizes with total and percentage revenue:

```sql
SELECT
pizza_size,
CAST(SUM(total_price) AS decimal(10,2)) AS TOTAL_REVENUE,
CAST(CAST(100*SUM(total_price) AS decimal(10,2))/(SELECT SUM(total_price) FROM pizza_sales)
AS decimal(10,2)) AS '% OF REVENUE'
FROM pizza_sales
GROUP BY pizza_size
ORDER BY '% OF REVENUE' DESC
```

Output: 

![pizza_sizes_with_revenue](https://github.com/burakgndz/Pizza-Sales-Report/assets/56515947/c9d2925f-43e2-4180-ade6-06ba9b13e2b6)

Pizza categories with total sales:

```sql
SELECT
pizza_category,
SUM(quantity) AS 'Total Pizza Sold'
FROM pizza_sales
GROUP BY pizza_category
ORDER BY 'Total Pizza Sold' DESC
```

Output: 

![pizza_categories_with_sales](https://github.com/burakgndz/Pizza-Sales-Report/assets/56515947/e39bcd9c-c6c0-404c-ba05-190a1f3ea819)

Best/Worst 5 Pizza names with total revenue:

```sql
#BEST 5
SELECT
TOP 5
pizza_name,
SUM(total_price) AS TOTAL_REVENUE
FROM pizza_sales
GROUP BY pizza_name
ORDER BY TOTAL_REVENUE DESC

#WORST 5
SELECT
TOP 5
pizza_name,
CAST(SUM(total_price) AS decimal(10,2)) AS TOTAL_REVENUE
FROM pizza_sales
GROUP BY pizza_name
ORDER BY TOTAL_REVENUE ASC
```

Output: 

![top5_pizza_names_with_revenue](https://github.com/burakgndz/Pizza-Sales-Report/assets/56515947/f1c3fb65-2311-431c-8120-5d88a37272cc)

![bottom5_pizza_names_with_revenue](https://github.com/burakgndz/Pizza-Sales-Report/assets/56515947/81326d8c-4b09-4079-8ca1-92345b5aa8c7)

Pizza names with order counts:

```sql
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
```

Output: 

![MOST ORDERED PIZZAS](https://github.com/burakgndz/Pizza-Sales-Report/assets/56515947/8334ad11-125a-45db-b24a-e89f5aa06790)

![LEAST ORDERED PIZZAS](https://github.com/burakgndz/Pizza-Sales-Report/assets/56515947/c7cbd4ba-8dac-409d-9cb9-5ccadcbf8382)

Total Pizza sold:

```sql
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
```

Output: 

![pizza_names_with_total_order](https://github.com/burakgndz/Pizza-Sales-Report/assets/56515947/91446539-e2e9-47f9-8c35-62410e3e4cc2)

![pizza_names_with_total_order2](https://github.com/burakgndz/Pizza-Sales-Report/assets/56515947/d78098e3-0e3a-415b-b9e1-bb90a56e55c3)


