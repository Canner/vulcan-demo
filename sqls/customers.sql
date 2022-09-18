
SELECT * FROM (
  SELECT
    {% if context.user.attr.group == 'admin' %} 
      CLIENTNUM 
    {% else %}
      CONCAT(SUBSTR(CLIENTNUM, 0, 4), 'xxxxxx')
    {% endif %} as id,
    Customer_Age AS age,
    Gender AS gender,
    Education_Level AS education_level,
    Marital_Status AS marital_status,
    Income_Category AS income_category,
    CASE
      WHEN Attrition_Flag = 'Existing Customer' 
        THEN false
        ELSE true 
    END AS attrited
  FROM bank_churners
) AS customers

WHERE
age > {{ context.params.age_gt | default(0) }}

{% if context.params.gender %}
AND gender = {{ context.params.gender | upper }}
{% endif %}

OFFSET {{ context.params.offset | default(0) }}
LIMIT {{ context.params.limit | default(20) }}