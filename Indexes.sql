--Operations schema indexes on orders and prescriptions
CREATE INDEX idx_orders_customer_id ON
operations.orders(customer_id);
CREATE INDEX idx_orders_employee_id ON 
operations.orders(employee_id);
CREATE INDEX idx_orders_order_date ON 
operations.orders(order_date);

CREATE INDEX idx_prescriptions_order_id ON 
operations.prescriptions(order_id);
CREATE INDEX idx_prescriptions_drug_id ON 
operations.prescriptions(drug_id);
CREATE INDEX idx_prescriptions_date_prescribed ON 
operations.prescriptions(date_prescribed);


-- Inventory schema indexes
CREATE INDEX idx_stock_drug_id ON 
inventory.stock(drug_id);
CREATE INDEX idx_suppliers_drug_id ON 
inventory.suppliers(drug_id);

-- Research schema indexes
CREATE INDEX idx_clinical_trials_drug_id ON 
research.clinical_trials(drug_id);
CREATE INDEX idx_trial_participants_trial_id ON 
research.trial_participants(trial_id);
CREATE INDEX idx_approvals_drug_id ON 
research.approvals(drug_id);

