# Data

## Source

Brazilian E-Commerce Public Dataset by Olist  
Source: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce  
Downloaded: 27 July 2026

This dataset contains anonymized information about approximately 100,000 e-commerce orders in Brazil.

## Local storage

The original CSV files are stored in `data/raw/`.

The `data/raw/` folder is excluded from GitHub because the raw files are relatively large. Each team member should download the dataset from the source above and place the CSV files in their own local `data/raw/` folder.

## Files

- `olist_customers_dataset.csv`: customer identifiers and locations
- `olist_geolocation_dataset.csv`: postcode coordinates
- `olist_order_items_dataset.csv`: products, sellers, prices and freight values
- `olist_order_payments_dataset.csv`: payment information
- `olist_order_reviews_dataset.csv`: customer ratings and review comments
- `olist_orders_dataset.csv`: order status and purchase/delivery dates
- `olist_products_dataset.csv`: product characteristics and categories
- `olist_sellers_dataset.csv`: seller identifiers and locations
- `product_category_name_translation.csv`: Portuguese-to-English category names

## Main tables for this project

The first stage of the analysis will focus on:

- Orders
- Customer reviews
- Customers
- Order items
- Products
- Sellers
- Product category translations