SELECT 
  "DATE_TRUNC(LITERAL(), ORDER_TS)" AS event_timestamp,
  TOTAL_SALES AS total_sales
FROM {{ source('raw_pos', 'daily_sales_hamburg_t') }}
