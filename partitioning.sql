-- Create parent table
-- Now changed to DEFAULTS which only copies the columns and default values but not the Primary Keys, Foreign Keys, indexes and unique constraints.
CREATE TABLE operations.orders_partitioned (
    LIKE operations.orders INCLUDING DEFAULTS
) PARTITION BY RANGE (order_date);

-- alter the partitioned table to be accept both order_id and order_date as the Primary Keys; making this a COMPOSITE Primary Key, see glossary (coming soon) for more information.
ALTER TABLE operations.orders_partitioned
ADD PRIMARY KEY (order_id, order_date);

-- Recreate the foreign KEYS
ALTER TABLE operations.orders_partitioned
ADD CONSTRAINT fk_orders_customer
    FOREIGN KEY (customer_id)
    REFERENCES operations.customers(customer_id);

ALTER TABLE operations.orders_partitioned
ADD CONSTRAINT fk_orders_employee
    FOREIGN KEY (employee_id)
    REFERENCES operations.employees(employee_id);

-- Create partitions per year
CREATE TABLE operations.orders_2020 PARTITION OF operations.orders_partitioned
FOR VALUES FROM ('2020-01-01') TO ('2021-01-01');

CREATE TABLE operations.orders_2021 PARTITION OF operations.orders_partitioned
FOR VALUES FROM ('2021-01-01') TO ('2022-01-01');

CREATE TABLE operations.orders_2022 PARTITION OF operations.orders_partitioned
FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

CREATE TABLE operations.orders_2023 PARTITION OF operations.orders_partitioned
FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');


CREATE TABLE operations.orders_2024 PARTITION OF operations.orders_partitioned
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE operations.orders_2025 PARTITION OF operations.orders_partitioned
FOR VALUES FROM ('2025-01-01') to ('2026-01-01');

-- Insert into the orders_partitioned after partitioning from the orders table
INSERT INTO operations.orders_partitioned
SELECT * FROM operations.orders;

-- Rename tables orders_partitioned table to orders and vice versa
ALTER TABLE operations.orders RENAME TO orders_old;
ALTER TABLE operations.orders_partitioned RENAME TO orders;




-- Create parent table
CREATE TABLE operations.prescriptions_partitioned (
    LIKE operations.prescriptions INCLUDING DEFAULTS
) PARTITION BY RANGE (date_prescribed);

-- add composite primary key including prescriptions_id and prescriptions_date 
ALTER TABLE operations.prescriptions_partitioned
ADD PRIMARY KEY (prescriptions_id, date_prescribed );

-- Recreate the foreign KEYS
ALTER TABLE operations.prescriptions_partitioned
ADD CONSTRAINT fk_prescriptions_order
    FOREIGN KEY (order_id)
    REFERENCES operations.orders(order_id);

ALTER TABLE operations.prescriptions_partitioned
ADD CONSTRAINT fk_prescriptions_drug
    FOREIGN KEY (drug_id)
    REFERENCES inventory.drugs(drug_id);

ALTER TABLE operations.prescriptions_partitioned
ADD CONSTRAINT fk_prescriptions_patient
    FOREIGN KEY (patient_id)
    REFERENCES operations.patients(patient_id);
	

-- Create partitions per year
CREATE TABLE operations.prescriptions_2020 PARTITION OF operations.prescriptions_partitioned
FOR VALUES FROM ('2020-01-01') TO ('2021-01-01');

CREATE TABLE operations.prescriptions_2021 PARTITION OF operations.prescriptions_partitioned
FOR VALUES FROM ('2021-01-01') TO ('2022-01-01');

CREATE TABLE operations.prescriptions_2022 PARTITION OF operations.prescriptions_partitioned
FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

CREATE TABLE operations.prescriptions_2023 PARTITION OF operations.prescriptions_partitioned
FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE operations.prescriptions_2024 PARTITION OF operations.prescriptions_partitioned
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE operations.prescriptions_2025  PARTITION OF operations.prescriptions_partitioned
FOR VALUES FROM('2025-01-01') to ('2026-01-01');

-- migrate exisiting data from original prescriptions table
INSERT INTO operations.prescriptions_partitioned
SELECT * FROM operations.prescriptions;

-- Rename original tables and set new partitioned table as primary
ALTER TABLE operations.prescriptions RENAME TO prescriptions_old;
ALTER TABLE operations.prescriptions_partitioned RENAME TO prescriptions;


