SELECT 
  {{ dbt_utils.star(from=source('raw_pos', 'country')) }}
FROM {{ source('raw_pos', 'country') }}
