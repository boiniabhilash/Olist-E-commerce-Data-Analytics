create database olist_analytics;
use olist_analytics;
select database();
create table customers(
customer_id varchar(50),
customer_unique_id varchar(50),
customer_zip_code__prefix int,
customer_city varchar(100),
customer_state varchar(10));
show tables;
describe customers;
select count(*) as total_customers from customers;
select * from customers limit 10;

create table orders(
order_id varchar(50),
customer_id varchar(50),
order_status varchar(30),
order_purchase_time varchar(50),
order_approved_at varchar(50),
order_delivered_carrier_date varchar(50),
order_delivered_customer_date varchar(50),
order_estimated_delivery_date varchar(50));
describe orders;
select * from orders limit 10;
select count(*) as total_orders,
count(distinct order_id) as unique_orders from orders; 

create table order_items(
	order_id varchar(50),
    order_item_id int,
    product_id varchar(50),
    seller_id varchar(50),
    shipping_limit_date varchar(20),
    price decimal(10,2),
    freight_value decimal(10,2));
select count(*) from order_items;
SELECT *
FROM order_items
LIMIT 10;

  create table order_payments(
	order_id varchar(50),
    payment_sequential int,
    payment_type varchar(20),
    payment_installments int,
    payment_value decimal (10,2));
select count(*) as total_payments_records from order_payments;
-- Calculate total payment value
select round(sum(payment_value), 2) as total_payment_value
from order_payments;

-- ============================================================
-- ORDER ANALYSIS
-- ============================================================
-- OVERALL BUSINESS KPIs
SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(price), 2) AS total_product_sales,
    ROUND(SUM(freight_value), 2) AS total_freight,
    ROUND(SUM(price + freight_value), 2) AS total_order_item_value,
    ROUND(SUM(price + freight_value) / COUNT(DISTINCT order_id),2) AS average_order_value
FROM order_items;

-- MONTHLY SALES & ORDER TREND
-- Analyze how order volume and sales changed over time.
select year(str_to_date(o.order_purchase_time,'%m/%d/%Y %H:%i')) as purchase_year,
	month(str_to_date(o.order_purchase_time,'%m/%d/%Y %H:%i')) as purchase_month,
    count(distinct o.order_id) as total_orders,
    round(sum(oi.price), 2) as products_sales,
    round(sum(oi.freight_value), 2) as freight_value,
    round(sum(oi.price + oi.freight_value), 2) as total_sales
from orders o 
inner join order_items oi
	on o.order_id = oi.order_id
group by year(str_to_date(o.order_purchase_time,'%m/%d/%Y %H:%i')),
	month(str_to_date(o.order_purchase_time,'%m/%d/%Y %H:%i'))
order by purchase_year, purchase_month;

-- PAYMENT METHOD ANALYSIS
-- Understand which payment methods are most frequently used
-- and which contribute the most payment value.
select payment_type, count(*) as payment_transactions,
	round(sum(payment_value), 2) as total_payment_value,
    round(avg(payment_value), 2) as average_payment_value
from order_payments
group by payment_type
order by total_payment_value desc;

-- PAYMENT METHOD CONTRIBUTION %
-- Calculate each payment method's contribution to the overall payment value.
select payment_type,
	round(sum(payment_value),2) as total_payment_value,
   round(sum(payment_value)/(select sum(payment_value) 
			from order_payments) * 100, 2) as payment_value_percentage
from order_payments
group by payment_type
order by payment_value_percentage desc;


-- CUSTOMER ORDER FREQUENCY
-- Calculate how many orders each customer has placed.
-- identify repeat customers.
with customer_orders as(select customer_id, count(distinct order_id)as total_orders
		from orders
        group by customer_id)
	select total_orders, count(*) as number_of_customers
    from customer_orders
    group by total_orders
    order by total_orders;

-- Recalculate Early, On Time, and Late deliveries using
-- one common delay calculation to ensure our final numbers are consistent.
WITH delivery_data AS (
-- Calculate delivery delay for every eligible order
    SELECT order_id,
DATEDIFF(STR_TO_DATE(order_delivered_customer_date,'%m/%d/%Y %H:%i'),
                STR_TO_DATE(order_estimated_delivery_date,'%m/%d/%Y %H:%i')) AS delivery_delay_days
    FROM orders
    WHERE order_status = 'delivered'
      AND order_delivered_customer_date IS NOT NULL
      AND order_estimated_delivery_date IS NOT NULL)
SELECT
    -- Classify each order based on delivery delay
    CASE WHEN delivery_delay_days < 0
            THEN 'Early'

WHEN delivery_delay_days = 0
            THEN 'On Time'
WHEN delivery_delay_days > 0
		THEN 'Late'
    END AS delivery_performance,
    -- Count orders in each category
    COUNT(*) AS total_orders,
    -- Calculate percentage of eligible delivered orders
    ROUND(COUNT(*) * 100.0 /(SELECT COUNT(*) FROM delivery_data),2) AS percentage_of_orders
FROM delivery_data
GROUP BY delivery_performance
ORDER BY total_orders DESC;

-- distribution of orders by status
-- Count the number of orders for each order status and
-- rank the statuses from highest to lowest order volume.
select order_status,
count(*) as order_count
from orders
group by order_status
order by order_count desc;

-- MONTHLY ORDER TREND
-- order volume change over time
-- Convert the text-based purchase timestamp into a proper
-- Analyze monthly order volume to identify growth patterns,
-- seasonal trends, and periods of high/low demand.
select year(str_to_date(order_purchase_time,'%m/%d/%Y %H:%i')) as purchase_year,
	month(str_to_date(order_purchase_time,'%m/%d/%Y %H:%i')) as purchase_month,
	count(*) as order_count
from orders
group by
		year(str_to_date(order_purchase_time,'%m/%d/%Y %H:%i')),
        month(str_to_date(order_purchase_time,'%m/%d/%Y %H:%i'))
order by purchase_year, purchase_month;

-- MONTHLY REVENUE TREND
-- How does product sales change over time
-- Join orders with order items and calculate monthly
-- product sales to identify revenue trends and growth.
select year(str_to_date(o.order_purchase_time,'%m/%d/%Y %H:%i')) as purchase_year,
	month(str_to_date(o.order_purchase_time,'%m/%d/%Y %H:%i')) as purchase_month,
    round(sum(oi.price), 2) as total_sales
    from orders as o
    join order_items as oi
    on o.order_id = oi.order_id
group by 
		year(str_to_date(o.order_purchase_time,'%m/%d/%Y %H:%i')),
		month(str_to_date(o.order_purchase_time,'%m/%d/%Y %H:%i'))
	order by
    purchase_year,
    purchase_month;


-- Identify orders that exist in the orders table but do not
-- have a matching record in order_items.
SELECT
    COUNT(*) AS orders_without_items
FROM orders o
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE oi.order_id IS NULL;

-- STATUS OF ORDERS WITHOUT ITEMS
-- Check whether orders without order-item records are
-- concentrated in particular order statuses.
SELECT o.order_status,
    COUNT(*) AS orders_without_items
FROM orders o
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE oi.order_id IS NULL
GROUP BY
    o.order_status
ORDER BY
    orders_without_items DESC;

-- ORDER STATUS ANALYSIS
-- Understand the distribution of orders across different
-- order lifecycle statuses.
    SELECT order_status,
    COUNT(*) AS total_orders,
    -- Percentage of all orders
    ROUND(COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM orders),2) AS order_percentage
FROM orders
GROUP BY order_status
ORDER By total_orders DESC;

-- CHECK DELIVERY DATE FIELDS
-- Verify the purchase, delivered, and estimated delivery
-- date columns before performing delivery analysis.
SELECT order_purchase_time, order_delivered_customer_date, order_estimated_delivery_date
FROM orders
WHERE order_status = 'delivered'
LIMIT 10;
-- Delivery performance analysis
-- measure actual delivery time and compare it with the estimated delivery date
select round(avg(datediff(str_to_date(order_delivered_customer_date, '%m/%d/%Y %H:%i'),
		str_to_date(order_purchase_time, '%m/%d/%Y %H:%i'))),2) as avg_delivery_days,
	round(avg(datediff(str_to_date(order_delivered_customer_date, '%m/%d/%Y %H:%i'),
		str_to_date(order_estimated_delivery_date, '%m/%d/%Y %H:%i'))),2) as avg_delivery_variance_days
from orders
where order_status = 'delivered'
	and order_delivered_customer_date is not null
    and order_purchase_time is not null
    and order_estimated_delivery_date is not null;
    
 -- DELIVERY PERFORMANCE CLASSIFICATION
-- Classify delivered orders as Early, On Time, or Late
-- based on the estimated delivery date.  
select case when datediff(str_to_date(order_delivered_customer_date, '%m/%d/%Y %H:%i'),
		str_to_date(order_estimated_delivery_date, '%m/%d/%Y %H:%i')) <0 then 'Early'
        when datediff(str_to_date(order_delivered_customer_date, '%m/%d/%Y %H:%i'),
		str_to_date(order_estimated_delivery_date, '%m/%d/%Y %H:%i')) =0 then 'On Time'
        else 'Late'
        end as delivery_performance,
        count(*) as total_orders,
	round(count(*) * 100.0/(select count(*)
    from orders
    where order_status ='delivered'
    and order_delivered_customer_date is not null
    and order_estimated_delivery_date is not null),2) as percentage_of_orders
from orders
where order_status ='delivered'
and order_delivered_customer_date is not null
and order_estimated_delivery_date is not null
group by delivery_performance
order by total_orders desc;

-- late delivery severity
-- measure how severe delivery delays are among orders that were
-- delivered after the estimated date
select count(*) as late_orders,
		-- average number of days late
        round(avg(datediff(str_to_date(order_delivered_customer_date, '%m/%d/%Y %H:%i'),
					str_to_date(order_estimated_delivery_date, '%m/%d/%Y %H:%i'))),2) as average_days_late,
		-- max observed delivery delay
        max(datediff(str_to_date(order_delivered_customer_date, '%m/%d/%Y %H:%i'),
        str_to_date(order_estimated_delivery_date, '%m/%d/%Y %H:%i'))) as maximum_days_late
from orders
where order_status = 'delivered'
and order_delivered_customer_date is not null
and order_estimated_delivery_date is not null
-- only orders delivered after the estimate date
and datediff(str_to_date(order_delivered_customer_date, '%m/%d/%Y %H:%i'),
		str_to_date(order_estimated_delivery_date, '%m/%d/%Y %H:%i'))>0;
 
 
-- SELLER PERFORMANCE ANALYSIS
-- Evaluate seller performance based on sales, orders,
-- and freight generated.
SELECT seller_id,
-- Number of unique orders handled by the seller
    COUNT(DISTINCT order_id) AS total_orders,
-- Total product sales generated by the seller
    ROUND(SUM(price),2) AS total_product_sales,
-- Total freight generated by the seller
    ROUND(SUM(freight_value),2) AS total_freight,
-- Average value of each order item
    ROUND(AVG(price),2) AS average_item_value
FROM order_items
GROUP BY seller_id
-- Show the highest-selling sellers first
ORDER BY total_product_sales DESC;

-- top sellers ranking
-- rank sellers based on their total product sales
with seller_sales as (
-- Calculate total sales for each seller
    SELECT seller_id,
-- Number of unique orders handled by the seller
        COUNT(DISTINCT order_id) AS total_orders,
-- Total product sales generated by the seller
        ROUND(SUM(price), 2) AS total_product_sales,
-- Total freight generated by the seller
        ROUND(SUM(freight_value), 2) AS total_freight
		FROM order_items
		GROUP BY seller_id)
	SELECT seller_id, total_orders, total_product_sales, total_freight,
-- Rank sellers from highest to lowest sales
    RANK() OVER (ORDER BY total_product_sales DESC) AS seller_rank
FROM seller_sales
-- Display the highest-selling sellers first
ORDER BY seller_rank;


--  SELLER FREIGHT EFFICIENCY
-- Compare seller freight costs against their product sales.
-- This helps identify sellers with a high or low freight burden.

SELECT seller_id,
-- Number of unique orders handled by the seller
    COUNT(DISTINCT order_id) AS total_orders,
-- Total product sales generated by the seller
    ROUND(SUM(price),2) AS total_product_sales,
-- Total freight generated by the seller
    ROUND(SUM(freight_value),2) AS total_freight,
-- Freight as a percentage of product sales
    ROUND(SUM(freight_value) / SUM(price) * 100,2) AS freight_percentage
FROM order_items
GROUP BY seller_id
-- Show sellers with the lowest freight burden first
ORDER BY freight_percentage ASC;

-- PRODUCT PERFORMANCE ANALYSIS
-- Identify the products generating the highest sales
-- and understand their sales volume and pricing.
SELECT product_id,
-- Number of unique orders containing the product
    COUNT(DISTINCT order_id) AS total_orders,
-- Number of times the product was sold
    COUNT(*) AS total_items_sold,
-- Total product sales generated
    ROUND(SUM(price),2) AS total_product_sales,
-- Total freight generated
    ROUND(SUM(freight_value),2) AS total_freight,
-- Average selling price per item
    ROUND(AVG(price),2) AS average_price
FROM order_items
GROUP BY product_id
-- Show highest-selling products first
ORDER BY total_product_sales DESC;

-- MONTH-OVER-MONTH SALES GROWTH
-- Compare each month's sales with the previous month
-- to identify growth and decline.

WITH monthly_sales AS (
-- Calculate total sales for each month
    SELECT
        YEAR(STR_TO_DATE(o.order_purchase_time,'%m/%d/%Y %H:%i')) AS purchase_year,
        MONTH(STR_TO_DATE(o.order_purchase_time,'%m/%d/%Y %H:%i')) AS purchase_month,
        ROUND(SUM(oi.price + oi.freight_value),2) AS total_sales
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY
        YEAR(STR_TO_DATE(o.order_purchase_time,'%m/%d/%Y %H:%i')),
        MONTH(STR_TO_DATE(o.order_purchase_time,'%m/%d/%Y %H:%i')))
SELECT purchase_year, purchase_month, total_sales,
-- Get the previous month's sales
    LAG(total_sales) OVER (
        ORDER BY purchase_year,purchase_month) AS previous_month_sales,
-- Calculate month-over-month growth percentage
    ROUND((total_sales - LAG(total_sales) OVER (
                ORDER BY purchase_year,purchase_month))/LAG(total_sales) OVER (
            ORDER BY purchase_year,purchase_month) * 100,2) AS mom_growth_percentage
FROM monthly_sales
ORDER BY purchase_year,purchase_month;

-- TOP SELLER SALES CONTRIBUTION
-- Measure how much of total product sales is generated
-- by the highest-selling sellers.

WITH seller_sales AS (
-- Calculate total product sales for each seller
    SELECT seller_id,
ROUND(SUM(price),2) AS total_product_sales
    FROM order_items
    GROUP BY seller_id),

ranked_sellers AS (
-- Rank sellers from highest to lowest sales
    SELECT seller_id, total_product_sales,
RANK() OVER (ORDER BY total_product_sales DESC) AS seller_rank
FROM seller_sales)
SELECT seller_rank, seller_id, total_product_sales,
-- Calculate each seller's contribution
-- to total product sales
    ROUND(total_product_sales /(SELECT SUM(total_product_sales)
            FROM seller_sales) * 100,2) AS sales_contribution_percentage
FROM ranked_sellers
-- Show the top 20 sellers only
WHERE seller_rank <= 20
ORDER BY seller_rank;

-- FINAL BUSINESS PERFORMANCE SUMMARY
-- Create a consolidated view of the key business KPIs
-- identified throughout the SQL analysis.

SELECT
-- Total number of orders
    COUNT(*) AS total_orders,
-- Orders marked as delivered
    SUM(CASE
            WHEN order_status = 'delivered'
            THEN 1
            ELSE 0
        END) AS delivered_orders,
-- Orders that were cancelled
    SUM(CASE
            WHEN order_status = 'canceled'
            THEN 1
            ELSE 0
        END) AS canceled_orders,
-- Orders marked unavailable
    SUM(CASE
            WHEN order_status = 'unavailable'
            THEN 1
            ELSE 0
        END) AS unavailable_orders,
-- Percentage of orders marked as delivered
    ROUND(SUM(CASE
                WHEN order_status = 'delivered'
                THEN 1
                ELSE 0
            END) * 100.0 / COUNT(*),2) AS delivery_status_percentage
FROM orders;


-- FINAL DATA QUALITY CHECK
-- Identify the 8 delivered orders that could not be classified
-- as Early, On Time, or Late.

SELECT order_id, order_purchase_time, order_delivered_customer_date, order_estimated_delivery_date,
    -- Recalculate the delivery delay
    DATEDIFF(STR_TO_DATE(order_delivered_customer_date,'%m/%d/%Y %H:%i'),
        STR_TO_DATE(order_estimated_delivery_date,'%m/%d/%Y %H:%i')) AS delivery_delay_days
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL
  -- Find records where the date calculation failed
  AND DATEDIFF(STR_TO_DATE(order_delivered_customer_date,'%m/%d/%Y %H:%i'),
        STR_TO_DATE(order_estimated_delivery_date,'%m/%d/%Y %H:%i')) IS NULL;

-- FINAL DELIVERY PERFORMANCE ANALYSIS
-- Classify delivered orders as Early, On Time, Late,
-- or Unclassified when delivery date information is missing.
SELECT CASE WHEN order_delivered_customer_date IS NULL
             OR order_delivered_customer_date = ''
             OR order_estimated_delivery_date IS NULL
             OR order_estimated_delivery_date = ''
            THEN 'Unclassified'
        WHEN DATEDIFF(STR_TO_DATE(order_delivered_customer_date,'%m/%d/%Y %H:%i'),
            STR_TO_DATE(order_estimated_delivery_date,'%m/%d/%Y %H:%i')) < 0
            THEN 'Early'
        WHEN DATEDIFF(STR_TO_DATE(order_delivered_customer_date,'%m/%d/%Y %H:%i'),
            STR_TO_DATE(order_estimated_delivery_date,'%m/%d/%Y %H:%i')) = 0
            THEN 'On Time'

        WHEN DATEDIFF(STR_TO_DATE(order_delivered_customer_date,'%m/%d/%Y %H:%i'),
		STR_TO_DATE(order_estimated_delivery_date,'%m/%d/%Y %H:%i')) > 0
            THEN 'Late'
            ELSE 'Unclassified'
    END AS delivery_performance,
    COUNT(*) AS total_orders,
    ROUND(COUNT(*) * 100.0 /(SELECT COUNT(*)
            FROM orders
            WHERE order_status = 'delivered'),2) AS percentage_of_orders
FROM orders
WHERE order_status = 'delivered'
GROUP BY delivery_performance
ORDER BY total_orders DESC;
