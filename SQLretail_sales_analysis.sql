CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
SELECT * FROM retail_sales;
-- Show the first 10 observations.
SELECT * 
FROM retail_sales
LIMIT 10;

-- Find out the number of rows/observations.
SELECT count(*)
FROM retail_sales;

-- Sort the values based on trasaction_id.
SELECT *
FROM retail_sales
ORDER BY transactions_id; 

-- Keep the null values if any at the top.
SELECT * 
FROM retail_sales
ORDER BY transactions_id NULLS FIRST;

-- Check each column if any null value exist.
SELECT * FROM retail_sales
WHERE 
	sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL or gender IS NULL 
	OR age IS NULL OR category IS NULL OR quantity IS NULL OR price_per_unit IS NULL
	OR cogs IS NULL OR total_sale IS NULL;
-- Delet the rows with null if any value.
DELETE FROM retail_sales
WHERE
	sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL or gender IS NULL 
	OR age IS NULL OR category IS NULL OR quantity IS NULL OR price_per_unit IS NULL
	OR cogs IS NULL OR total_sale IS NULL;

SELECT count(*) AS total_sales
FROM retail_sales;

-- How many sales we have?
SELECT COUNT(*) AS total_sale 
FROM retail_sales;  -- We are 1987 sales

-- How many unique customers we have ?
SELECT count(DISTINCT customer_id) AS total_customers
FROM retail_sales;  -- There are 155 unique customers

-- How many unique categories we have?
SELECT count(DISTINCT category) AS total_categories
FROM retail_sales;  -- We have 3 unique categories



-- Business Key Problems & Answers
-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT *
FROM retail_sales
WHERE sale_date='2022-11-05';


-- Q.2 Write a SQL query to retrieve all transactions where the category is 
-- 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022 
SELECT *
FROM retail_sales;


SELECT transactions_id, sale_date
FROM retail_sales -- There are 29 transactions occur.
WHERE category='Clothing' AND quantity > 2 AND TO_CHAR(sale_date, 'YYYY-MM')='2022-11'; 


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category, sum(total_sale) AS total_sales_cat
FROM retail_sales
GROUP BY category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT  ROUND(avg(age), 2)
FROM retail_sales
WHERE category='Beauty'; -- The average age of customers is 40.


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT transactions_id, total_sale
FROM retail_sales
WHERE total_sale>1000;   -- There 306 trasactions occur with total sales greater than 1000.



-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT count(transactions_id) AS total_transactions, gender, category
FROM retail_sales
GROUP BY gender, category;


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT EXTRACT(YEAR FROM sale_date) AS year, avg(total_sale)
FROM retail_sales
GROUP BY year; -- The best selling month is 2022.
--or
SELECT TO_CHAR(sale_date, 'YYYY') AS year, avg(total_sale)
FROM retail_sales
GROUP BY year; -- The best selling month is 2022.
--or
SELECT DATE_PART('year', sale_date) AS year, avg(total_sale)
FROM retail_sales
GROUP BY year; -- The best selling month is 2022.


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT customer_id, sum(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;  -- Top five customers are customer_ids with 3, 1, 5, 2 and 4.


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT customer_id, count(DISTINCT category) AS categories
FROM retail_sales
GROUP BY customer_id
HAVING count(DISTINCT category) = (
	SELECT count(DISTINCT category)
	FROM retail_sales
);   -- There are 128 customers who purchased item from each category.


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
WITH shifts AS (SELECT *, CASE 
			WHEN EXTRACT(hour FROM sale_time) <12 THEN 'Morning'
			WHEN EXTRACT(hour FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
			ELSE 'Evening'
			END AS shift FROM retail_sales)
SELECT shift, count(*) AS total_orders
FROM shifts
GROUP BY shift;
