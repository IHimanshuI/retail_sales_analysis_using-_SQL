# Retail Sales Analysis SQL Project

## Project Overview

**Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `sql_project_p1`

This project demonstrates key SQL techniques used by data analysts to explore and analyze retail sales data. You’ll set up a sales database, perform data cleaning, and answer key business questions using SQL.

---

## Objectives

- Set up a retail sales database and table
- Clean the data by identifying and removing nulls
- Perform exploratory data analysis (EDA)
- Use SQL to answer common business questions

---

## Project Structure

### 1. Database & Table Setup

```sql
CREATE DATABASE sql_project_p1;

DROP TABLE IF EXISTS retail_sales;

CREATE TABLE retail_sales (
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
```

---

### 2. Data Cleaning

Check and remove rows with missing values:
```sql
-- Identify NULL values
SELECT * FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR gender IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

-- Delete records with NULLs
DELETE FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR gender IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
```

---

### 3. 🔍 Data Exploration

```sql
-- Preview rows
SELECT * FROM retail_sales LIMIT 10;

-- Total transactions
SELECT COUNT(*) FROM retail_sales;

-- Unique customers
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

-- Product categories
SELECT DISTINCT category FROM retail_sales;
```

---

##  Business Analysis SQL Queries

**Q1. Sales on 2022-11-05**
```sql
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';
```

**Q2. 'Clothing' sales (qty > 4) in Nov 2022**
```sql
SELECT * FROM retail_sales
WHERE category = 'Clothing'
  AND quantity >= 4
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';
```

**Q3. Total sales by category**
```sql
SELECT category, SUM(total_sale) AS total_sale_catwise
FROM retail_sales
GROUP BY category;
```

**Q4. Average age by category**
```sql
SELECT category, ROUND(AVG(age), 2) AS average_age
FROM retail_sales
GROUP BY category;
```

**Q5. Transactions with total_sale > 1000**
```sql
SELECT * FROM retail_sales
WHERE total_sale > 1000;
```

**Q6. Transaction count by gender and category**
```sql
SELECT gender, category, COUNT(transactions_id) AS no_of_transact
FROM retail_sales
GROUP BY gender, category;
```

**Q7. Best-selling month of each year**
```sql
SELECT
    EXTRACT(YEAR FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    ROUND(AVG(total_sale), 2) AS avg_sale_month_wise,
    RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY ROUND(AVG(total_sale), 2) DESC) AS rank
FROM retail_sales
GROUP BY year, month;
```

**Q8. Top 5 customers by total sales**
```sql
SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

**Q9. Unique customers by category**
```sql
SELECT category, COUNT(DISTINCT customer_id) AS unique_customer
FROM retail_sales
GROUP BY category;
```

**Q10. Orders by shift**
```sql
SELECT 
    CASE 
        WHEN EXTRACT(HOUR FROM sale_time) <= 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS hourly_sale
FROM retail_sales
GROUP BY shift;
```

---

##  Insights & Findings

- **Customer Reach**: The business has a diverse customer base with various age groups.
- **Product Popularity**: 'Clothing' and 'Beauty' categories show strong performance.
- **High-Value Transactions**: Numerous sales exceed ₹1000.
- **Sales Trends**: Month-wise analysis identifies seasonal performance.
- **Customer Loyalty**: Top customers contribute significantly to revenue.

---

## Reports

- **Sales Summary**: Aggregated totals by category and time.
- **Customer Insights**: Unique and top-spending customer profiles.
- **Time-based Trends**: Shift and monthly performance.

---

## Conclusion

This project offers practical SQL experience in handling real-world sales data. By completing this project, you develop skills in data exploration, cleaning, and analytical querying — essential for any aspiring data analyst.
