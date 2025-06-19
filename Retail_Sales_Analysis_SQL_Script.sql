-- SQL Retail Sales Analysis - P1
CREATE DATABASE sql_project_p1;

-- createing table
DROP TABLE IF EXISTS retail_sales;
create table retail_sales(
		transactions_id INT,
		sale_date DATE,
		sale_time TIME,
		customer_id INT,
		gender VARCHAR(15),
		age INT,
		category VARCHAR(25),
		quantity INT,
		price_per_unit INT,
		cogs FLOAT,
		total_sale INT
		);

-- checking the rows of created table
SELECT * FROM retail_sales
LIMIT 10

-- getting count of rows in the table
SELECT
	COUNT(*)
FROM retail_sales;

-- data cleaning 
SELECT * FROM retail_sales
WHERE transactions_id IS NULL

SELECT * FROM retail_sales
WHERE sale_date IS NULL

SELECT * FROM retail_sales
WHERE customer_id IS NULL

SELECT * FROM retail_sales
WHERE age IS NULL

SELECT * FROM retail_sales
WHERE 
	transactions_id IS NULL
	OR 
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	gender IS NULL
	OR
	category IS NULL
	OR 
	quantity IS NULL
	OR 
	cogs IS NULL
	OR
	total_sale IS NULL

DELETE FROM retail_sales
WHERE 
	transactions_id IS NULL
	OR 
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	gender IS NULL
	OR
	category IS NULL
	OR 
	quantity IS NULL
	OR 
	cogs IS NULL
	OR
	total_sale IS NULL

-- Data exploration

-- How many sales we have?
SELECT COUNT(*) AS age FROM retail_sales

-- How many unique customers we have?
SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales

SELECT DISTINCT category FROM retail_sales

-- Data Analysis & Business Key Problems & Answers

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- SQL script for Q
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
-- SQL script for Q
SELECT * FROM retail_sales
WHERE 
	category = 'Clothing' 
	AND
	quantity >= 4
	AND
	TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- SQL script for Q
SELECT 
	category,
	SUM(total_sale) AS total_sale_catwise
FROM retail_sales
GROUP BY 1

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- SQL script for Q
SELECT 
	category, ROUND(AVG(age),2) as average_age
FROM retail_sales
GROUP BY 1

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- SQL script for Q
SELECT *
FROM retail_sales
WHERE total_sale > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- SQL script for Q
SELECT 
	gender, category, COUNT(transactions_id) as no_of_tarnsact
FROM retail_sales
GROUP BY 1, 2

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- SQL script for Q
SELECT
	EXTRACT (YEAR FROM sale_date) as year,
	EXTRACT (MONTH FROM sale_date) as month,
	ROUND(AVG(total_sale),2) as avg_sale_month_wise,
	RANK() OVER(PARTITION BY EXTRACT (YEAR FROM sale_date) ORDER BY ROUND(AVG(total_sale),2) DESC )
FROM retail_sales
GROUP BY 1,2
-- ORDER BY 1, 3 DESC

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- SQL script for Q
SELECT 
	customer_id,
	SUM(total_sale)
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- SQL script for Q
SELECT 
	category,
	COUNT(DISTINCT customer_id) AS unique_customer
FROM retail_sales
GROUP BY 1

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
-- SQL script for Q
SELECT 
	CASE 
		WHEN EXTRACT(HOUR FROM sale_time) <= 12 THEN 'morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17  THEN 'afternoon'
		ELSE 'evening'
	END AS shift,
	COUNT(*) AS hourly_sale
FROM retail_sales
GROUP BY 1

-- END OF PROJECT 