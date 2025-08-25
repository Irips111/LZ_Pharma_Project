CREATE SCHEMA IF NOT EXISTS analytics;

CREATE MATERIALIZED VIEW analytics.monthly_drug_sales AS
SELECT
    d.drug_id,
    d.name AS drug_name,
    DATE_TRUNC('month', o.order_date) AS month,
    SUM(o.total_amount) AS total_sales
FROM
    operations.orders o
JOIN
    operations.prescriptions p ON o.order_id = p.order_id
JOIN
    inventory.drugs d ON p.drug_id = d.drug_id
GROUP BY
    d.drug_id, d.name, DATE_TRUNC('month', o.order_date);
CREATE MATERIALIZED VIEW analytics.employee_prescription_counts AS
SELECT
    e.employee_id,
    e.name AS employee_name,
    COUNT(p.prescription_id) AS prescription_count
FROM
    operations.employees e
JOIN
    operations.orders o ON e.employee_id = o.employee_id
JOIN
    operations.prescriptions p ON o.order_id = p.order_id
GROUP BY
    e.employee_id, e.name;