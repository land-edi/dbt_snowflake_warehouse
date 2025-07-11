{%- test row_count_variation(model, column_name = 'event_timestamp', granularity = 'DAY', window = 7, threshold = 15) -%}
  WITH

    row_counts AS (
        SELECT
            DATE_TRUNC({{ granularity }}, {{ column_name }}) AS truncated_date,
            COUNT(*) AS row_count
        FROM
            {{ model }}
        WHERE
            {{ column_name }} IS NOT NULL
            AND DATE_TRUNC({{ granularity }}, {{ column_name }}) < DATE_TRUNC({{ granularity }}, CURRENT_TIMESTAMP())
        GROUP BY
            truncated_date
        ORDER BY
            truncated_date DESC
        LIMIT {{ window }}
    ),

    differences AS (
        SELECT
            truncated_date,
            (row_count - (LAG(row_count) OVER (ORDER BY truncated_date)))* 100 / row_count AS count_variation
        FROM row_counts
    )

    SELECT
        truncated_date,
        count_variation
    FROM 
        differences
    WHERE 
        ABS(count_variation) > {{ threshold }}
    ORDER BY 
        truncated_date DESC

{%- endtest -%}
