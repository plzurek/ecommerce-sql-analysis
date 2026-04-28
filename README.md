# ecommerce-sql-analysis
E-commerce Data Analysis (SQL Project)

Overview
This project analyzes an e-commerce dataset using PostgreSQL.
The goal was to explore revenue patterns, customer segmentation and delivery performance.

Key Analyses
Revenue trends
Top products
Customer segmentation
Pareto analysis (80/20 rule)
Delivery performance vs customer reviews

Assumptions
Revenue calculations include only delivered orders.
Canceled, unavailable, created, approved and invoiced orders were excluded to ensure accuracy of realized revenue.

Key Insights
Revenue is moderately concentrated across products but less across customers
Around 26% of products generate 80% of revenue
Around 45% of customers generate 80% of revenue
Customer satisfaction strongly decreases as delivery time increases, with reviews dropping from ~4.4 for fast deliveries to below 2 for slow deliveries
Customer satisfaction decreases with delivery delays. Orders delivered more than 4 days late receive an average rating below 2

Tools
PostgreSQL

Future Improvements
Regional delivery analysis
Outlier handling improvements
Visualization in Power BI
