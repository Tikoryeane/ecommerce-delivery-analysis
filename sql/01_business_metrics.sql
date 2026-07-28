-- Olist E-commerce Delivery Analysis
-- Initial business metrics
-- Run this script from the project root directory.

-- Load the two core CSV files as reusable DuckDB views.

CREATE OR REPLACE VIEW orders_raw AS
SELECT *
FROM read_csv_auto(
    'data/raw/olist_orders_dataset.csv'
);

CREATE OR REPLACE VIEW reviews_raw AS
SELECT *
FROM read_csv_auto(
    'data/raw/olist_order_reviews_dataset.csv'
);


-- 1. Order status distribution

SELECT
    order_status,
    COUNT(*) AS order_count,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),
        2
    ) AS order_percent
FROM orders_raw
GROUP BY order_status
ORDER BY order_count DESC;


-- 2. Customer review-score distribution

SELECT
    review_score,
    COUNT(*) AS review_count,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),
        2
    ) AS review_percent
FROM reviews_raw
GROUP BY review_score
ORDER BY review_score;


-- 3. Customer-satisfaction groups

WITH classified_reviews AS (
    SELECT
        review_score,
        CASE
            WHEN review_score IN (1, 2) THEN 'Low rating'
            WHEN review_score = 3 THEN 'Neutral rating'
            WHEN review_score IN (4, 5) THEN 'High rating'
        END AS satisfaction_group
    FROM reviews_raw
)

SELECT
    satisfaction_group,
    COUNT(*) AS review_count,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),
        2
    ) AS review_percent
FROM classified_reviews
GROUP BY satisfaction_group
ORDER BY review_percent DESC;


-- 4. Delivery-status distribution

WITH delivered_orders AS (
    SELECT
        order_id,
        DATE_DIFF(
            'day',
            CAST(order_estimated_delivery_date AS DATE),
            CAST(order_delivered_customer_date AS DATE)
        ) AS delivery_delay_days
    FROM orders_raw
    WHERE order_status = 'delivered'
      AND order_delivered_customer_date IS NOT NULL
      AND order_estimated_delivery_date IS NOT NULL
),

classified_orders AS (
    SELECT
        order_id,
        delivery_delay_days,
        CASE
            WHEN delivery_delay_days > 0 THEN 'Delayed'
            ELSE 'On time or early'
        END AS delivery_status
    FROM delivered_orders
)

SELECT
    delivery_status,
    COUNT(*) AS order_count,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),
        2
    ) AS order_percent
FROM classified_orders
GROUP BY delivery_status
ORDER BY order_count DESC;


-- 5. Preliminary comparison of delivery status and review score

WITH delivered_orders AS (
    SELECT
        order_id,
        DATE_DIFF(
            'day',
            CAST(order_estimated_delivery_date AS DATE),
            CAST(order_delivered_customer_date AS DATE)
        ) AS delivery_delay_days,
        CASE
            WHEN DATE_DIFF(
                'day',
                CAST(order_estimated_delivery_date AS DATE),
                CAST(order_delivered_customer_date AS DATE)
            ) > 0
            THEN 'Delayed'
            ELSE 'On time or early'
        END AS delivery_status
    FROM orders_raw
    WHERE order_status = 'delivered'
      AND order_delivered_customer_date IS NOT NULL
      AND order_estimated_delivery_date IS NOT NULL
),

reviews_by_order AS (
    SELECT
        order_id,
        AVG(review_score) AS review_score
    FROM reviews_raw
    GROUP BY order_id
),

analysis_data AS (
    SELECT
        o.order_id,
        o.delivery_delay_days,
        o.delivery_status,
        r.review_score
    FROM delivered_orders AS o
    INNER JOIN reviews_by_order AS r
        ON o.order_id = r.order_id
)

SELECT
    delivery_status,
    COUNT(*) AS orders_with_reviews,
    ROUND(AVG(review_score), 2) AS average_review_score
FROM analysis_data
GROUP BY delivery_status
ORDER BY average_review_score DESC;