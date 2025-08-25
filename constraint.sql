-- Inventory constraints
ALTER TABLE inventory.drugs
ADD CONSTRAINT chk_price_positive CHECK (price > 0);

ALTER TABLE inventory.stock
ADD CONSTRAINT chk_quantity_nonnegative CHECK (quantity >= 0);

-- Operations constraints
ALTER TABLE operations.orders
ADD CONSTRAINT chk_total_amount_nonnegative CHECK (total_amount >= 0);

-- Research constraints
ALTER TABLE research.trial_participants
ADD CONSTRAINT chk_age_valid CHECK (age BETWEEN 0 AND 120);
