{% req user %}
SELECT COUNT(*) AS count FROM bank_churners 
WHERE CLIENTNUM = {{ context.params.id }}
{% endreq %}

{% if user.value()[0].count == 0 %}
  {% error "CUSTOMER_NOT_FOUND" %}
{% endif %}

SELECT * FROM (
  SELECT
    CLIENTNUM as id,
    Customer_Age AS age,
    Gender AS gender,
    Education_Level AS education_level,
    Marital_Status AS marital_status,
    Income_Category AS income_category,
    Card_Category AS card_category,
    CASE
      WHEN Attrition_Flag = 'Existing Customer' 
        THEN false
        ELSE true 
    END AS attrited
  FROM bank_churners
) AS customers
WHERE customers.id = {{ context.params.id }}
LIMIT 1