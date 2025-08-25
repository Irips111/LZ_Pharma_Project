-- Create users
CREATE USER dataengineer WITH PASSWORD 'NaMeBeDataEngineer';
CREATE USER analyst WITH PASSWORD 'NaMeBeAnalyst';
CREATE USER admin WITH PASSWORD 'NaMeBeAdmin';
CREATE USER researcher WITH PASSWORD 'NaMeBeResearcher';

-- To check if users have been created
SELECT * FROM pg_catalog.pg_roles;

-- For Data Engineer
-- Grant insert/update/select on operational schemas
GRANT USAGE ON SCHEMA operations TO dataengineer;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA operations TO dataengineer;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA operations TO dataengineer;

-- for inventory
GRANT USAGE ON SCHEMA inventory TO dataengineer;
GRANT SELECT, INSERT, DELETE, UPDATE ON ALL TABLES IN SCHEMA inventory TO dataengineer;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA inventory TO dataengineer;

-- For research? Grant select access only to the data engineer on all tables in the research schema.
SELECT * FROM inventory.drugs;

-- For Analyst
-- Read-only access to analytics
GRANT USAGE ON SCHEMA analytics TO analyst;
GRANT SELECT ON ALL TABLES IN SCHEMA analytics TO analyst;

-- Grant Optionally read-only on operational data
GRANT USAGE ON SCHEMA operations TO analyst;
GRANT SELECT ON ALL TABLES IN SCHEMA operations TO analyst;
-- REVOKE ACCESS TO CUSTOMER TABLES FROM ANALYST;
-- REVOKE SELECT ON operations.customers FROM analyst;

-- Grant Optionally read-only on inventory data
GRANT USAGE ON SCHEMA inventory TO analyst;
GRANT SELECT ON ALL TABLES IN SCHEMA inventory TO analyst;


-- For Admin
-- Grant all privileges on operational schemas
GRANT ALL PRIVILEGES ON SCHEMA operations TO admin;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA operations TO admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA operations TO admin;

-- For Researcher
-- Read-only access to research data
GRANT USAGE ON SCHEMA research TO researcher;
GRANT SELECT, UPDATE ON ALL TABLES IN SCHEMA research TO researcher;