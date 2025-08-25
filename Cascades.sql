-- Operations.orders dependencies
ALTER TABLE operations.orders
ADD CONSTRAINT fk_orders_customer_delete
FOREIGN KEY (customer_id) REFERENCES operations.customers(customer_id)
ON DELETE CASCADE;

ALTER TABLE operations.orders
ADD CONSTRAINT fk_orders_employee
FOREIGN KEY (employee_id) REFERENCES operations.employees(employee_id)
ON DELETE SET NULL;

-- Operations.prescriptions dependencies
ALTER TABLE operations.prescriptions
ADD CONSTRAINT fk_prescriptions_order
FOREIGN KEY (order_id) REFERENCES operations.orders(order_id)
ON DELETE CASCADE;

ALTER TABLE operations.prescriptions
ADD CONSTRAINT fk_prescriptions_drug
FOREIGN KEY (drug_id) REFERENCES inventory.drugs(drug_id)
ON DELETE RESTRICT;

-- Inventory.stock dependency
ALTER TABLE inventory.stock
ADD CONSTRAINT fk_stock_drug
FOREIGN KEY (drug_id) REFERENCES inventory.drugs(drug_id)
ON DELETE CASCADE;

-- Inventory.suppliers dependency
ALTER TABLE inventory.suppliers
ADD CONSTRAINT fk_suppliers_drug
FOREIGN KEY (drug_id) REFERENCES inventory.drugs(drug_id)
ON DELETE CASCADE;
