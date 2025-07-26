## dbt models for tasty_bytes_daily_hamburg_sales

{% docs doc_tasty_bytes_daily_hamburg_sales %}

Description:
Base model for Tasty Bytes daily hamburger sales

Caveat:

Details:
- garin: date
- Primary Key: date

Playbook:
```
SELECT
    *
FROM
    edi_dw.mart.tasty_bytes_daily_hamburg_sales
```

{% enddocs %}
