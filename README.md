# E-commerce SQL Analysis
E-commerce Data Analysis (SQL Project)


## Overview
This project analyzes an e-commerce dataset using PostgreSQL.
The goal was to explore revenue patterns, customer segmentation and delivery performance.


## Project Structure
- **001_total_revenue.sql**        - Total revenue from delivered orders
- 002_revenue_per_month_2017.sql   -> Monthly revenue trends 
- 003_top_products.sql             -> Top products by quantity sold  
- 004_product_revenue.sql          -> Top products by generated revenue
- 005_category_analysis.sql        -> Revenue distribution across product categories
- 006_top_customers.sql            -> Customers generating the highest revenue
- 007_customer_segmentation.sql    -> Customers divided into revenue-based segments (VIP to Low)
- 008_pareto_customers.sql         -> Pareto Analysis for customers
- 009_pareto_products.sql          -> Pareto Analysis for products
- 010_delivery_time_impact.sql     -> Delivery time vs review score
- 011_delivery_delay_impact.sql    -> Delivery delays vs review score


## Key Analyses
- Revenue trends
- Top products
- Customer segmentation
- Pareto analysis (80/20 rule)
- Delivery performance vs customer reviews


## Assumptions
Only delivered orders were included in revenue calculations
The following statuses were excluded:
- canceled
- unavailable
- created
- approved
- invoiced

This ensures analysis reflects realized revenue.


## Key Insights
- Revenue is moderately concentrated across products but less across customers
- Around 26% of products generate 80% of revenue
- Around 45% of customers generate 80% of revenue
- Customer satisfaction strongly decreases as delivery time increases, with reviews dropping from ~4.4 for fast deliveries to below 2 for slow deliveries
- Customer satisfaction decreases with delivery delays. Orders delivered more than 4 days late receive an average rating below 2


## Tools
PostgreSQL


## Future Improvements
- Regional delivery analysis
- Outlier handling improvements
- Visualization in Power BI


## Dataset
- customers
- order_items
- order_reviews
- orders
- product_category_name_translation
- products


## Data Source
Brazilian E-Commerce Public Dataset by Olist (Kaggle)
