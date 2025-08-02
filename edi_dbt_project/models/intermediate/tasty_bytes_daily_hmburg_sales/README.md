## dbt models for tasty_bytes_daily_hmburg_sales

{% docs doc_tasty_bytes_daily_hmburg_sales%}

Description:
Intermediate model for Tasty Bytes daily hamburger sales

Caveat:

Details:
- garin: date
- Primary Key: date

Playbook:
```
SELECT
    *
FROM
    edi_dw.intermediate.tasty_bytes_daily_hmburg_sales
```

{% enddocs %}
