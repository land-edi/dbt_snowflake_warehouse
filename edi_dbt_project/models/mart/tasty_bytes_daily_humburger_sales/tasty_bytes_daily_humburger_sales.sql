SELECT 
  event_timestamp,
  total_sales
FROM {{ ref('base__tasty_bytes_daily_humburger_sales') }}
