# Analysis Plan

## Project objective

This project investigates the relationship between delivery delays and customer satisfaction using the Olist Brazilian e-commerce dataset.

The analysis will identify whether delayed orders tend to receive lower customer-review scores and explore which types of orders are more likely to experience delays.

The results will be interpreted as associations rather than definitive causal effects.

## Main research question

How do delivery delays affect customer satisfaction?

## Supporting questions

1. What proportion of delivered orders arrive later than the estimated delivery date?
2. Do delayed orders receive lower review scores than on-time orders?
3. Does customer satisfaction decline as the number of delayed days increases?
4. Which product categories, locations or time periods have higher delay rates?
5. What practical actions could an e-commerce business take to improve delivery performance and customer satisfaction?

## Core metrics

### Delivery delay days

```text
delivery_delay_days =
actual delivery date - estimated delivery date
```

- A positive value means that the order arrived late.
- Zero or a negative value means that the order arrived on time or early.

### Delayed order

```text
is_delayed = 1 if delivery_delay_days > 0
is_delayed = 0 otherwise
```

### Delivery time

```text
delivery_time_days =
actual delivery date - purchase date
```

### Customer satisfaction

Customer satisfaction will primarily be measured using `review_score`, which ranges from 1 to 5.

Additional indicators may include:

- low rating: review score of 1 or 2;
- high rating: review score of 4 or 5.

## Initial analysis sample

The initial sample will retain orders that:

- were marked as delivered;
- have an actual delivery date;
- have an estimated delivery date;
- can be matched to a customer review.

The initial data audit identified approximately 95,824 eligible orders.

## Main tables

### Core tables

- `olist_orders_dataset.csv`
- `olist_order_reviews_dataset.csv`

### Additional tables

- `olist_customers_dataset.csv`
- `olist_order_items_dataset.csv`
- `olist_products_dataset.csv`
- `olist_sellers_dataset.csv`
- `product_category_name_translation.csv`

Payment and geolocation data may be added later if they materially improve the analysis.

## Planned workflow

1. Initial structural data audit
2. Statistical and data-quality audit
3. Construction of the core analysis dataset
4. SQL-based descriptive analysis
5. Statistical comparison and modelling
6. Power BI dashboard
7. Business interpretation and final report
8. Portfolio presentation

## Team responsibilities

### Economics and business analysis

- Project coordination
- Business-question design
- Core metric definitions
- SQL-based business analysis
- Power BI dashboard
- Business recommendations
- Final report and portfolio presentation

### Mathematics and statistical analysis

- SQL-based data validation
- Python data processing
- Data-quality checks
- Descriptive statistics
- Statistical testing
- Model selection and validation
- Interpretation of quantitative results

Both members will learn and use SQL. The economics member will lead the design of business metrics, while the mathematics member will use SQL to validate and prepare data for statistical analysis.

## Initial limitations

- The dataset is observational, so an association does not automatically prove causation.
- The data describe historical Brazilian e-commerce orders and may not represent every market.
- Not every order has a customer review.
- Delivery delays may be related to product, seller, region, season and other factors that should be considered during the analysis.
- Customer-review scores may reflect experiences beyond delivery performance.