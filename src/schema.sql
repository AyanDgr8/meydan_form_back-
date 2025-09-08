-- src/disposition_schema.sql


-- New Disposition Schema for Customer Service Form
-- This schema supports cascading dropdowns: Call Type → Disposition-1 → Disposition-2

CREATE DATABASE IF NOT EXISTS meydanform;
USE meydanform;

-- Updated forms table to support new disposition structure
CREATE TABLE IF NOT EXISTS forms_new (
  id INT AUTO_INCREMENT PRIMARY KEY,
  company VARCHAR(200) NOT NULL,
  name VARCHAR(100) NOT NULL,
  contact_number VARCHAR(20) NOT NULL,
  email VARCHAR(100) NOT NULL,
  call_type VARCHAR(50) NOT NULL,
  disposition_1 VARCHAR(100) NOT NULL,
  disposition_2 VARCHAR(100) NOT NULL,
  query TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  -- Call center fields (optional)
  queue_id VARCHAR(100) NULL,
  queue_name VARCHAR(100) NULL,
  agent_id VARCHAR(100) NULL,
  agent_ext VARCHAR(100) NULL,
  caller_id_name VARCHAR(100) NULL,
  caller_id_number VARCHAR(100) NULL,
  
  INDEX idx_call_type (call_type),
  INDEX idx_disposition_1 (disposition_1),
  INDEX idx_disposition_2 (disposition_2),
  INDEX idx_created_at (created_at)
);

-- Table to store disposition hierarchy and email mappings
CREATE TABLE IF NOT EXISTS disposition_config (
  id INT AUTO_INCREMENT PRIMARY KEY,
  call_type VARCHAR(50) NOT NULL,
  disposition_1 VARCHAR(100) NOT NULL,
  disposition_2 VARCHAR(100) NOT NULL,
  email_address VARCHAR(255) NOT NULL,
  is_custom_input BOOLEAN DEFAULT FALSE, -- TRUE for "Others" options
  
  UNIQUE KEY unique_disposition (call_type, disposition_1, disposition_2),
  INDEX idx_call_type (call_type),
  INDEX idx_disposition_1 (disposition_1)
);

-- Insert all disposition configurations with email mappings
INSERT INTO disposition_config (call_type, disposition_1, disposition_2, email_address, is_custom_input) VALUES

-- COMPLAINTS → CallBack Not Rcvd
('Complaints', 'CallBack Not Rcvd', 'CP_Support', 'cp.support@meydanfz.ae', FALSE),
('Complaints', 'CallBack Not Rcvd', 'M+', 'mas@meydanfz.ae', FALSE),
('Complaints', 'CallBack Not Rcvd', 'M+ Sales', 'msale@meydanfz.ae', FALSE),
('Complaints', 'CallBack Not Rcvd', 'MComplaince', 'mcomplaince@meydanfz.ae', FALSE),
('Complaints', 'CallBack Not Rcvd', 'Application', 'application@meydanfz.ae', FALSE),
('Complaints', 'CallBack Not Rcvd', 'Existing B2C Support', 'cx@meydanfz.ae', FALSE),
('Complaints', 'CallBack Not Rcvd', 'Reinquiry B2C', 'b2csupport@meydanfz.ae', FALSE),
('Complaints', 'CallBack Not Rcvd', 'Guide', 'guide@meydanfz.ae', FALSE),

-- COMPLAINTS → Dispute
('Complaints', 'Dispute', 'BRM Dispute', 'cp.support@meydanfz.ae', FALSE),
('Complaints', 'Dispute', 'Channel Partner', 'cp.support@meydanfz.ae', FALSE),
('Complaints', 'Dispute', 'Commercial dispute_B2B', 'cp.support@meydanfz.ae', FALSE),
('Complaints', 'Dispute', 'Commercial dispute_B2C', 'cx@meydanfz.ae', FALSE),
('Complaints', 'Dispute', 'Employee / Employer_B2B ', 'cp.support@meydanfz.ae', FALSE),
('Complaints', 'Dispute', 'Employee / Employer _B2C', 'cx@meydanfz.ae', FALSE),

-- COMPLAINTS → Reason for Rejection
('Complaints', 'Reason for Rejection', 'Company setup', 'b2csupport@meydanfz.ae', FALSE),
('Complaints', 'Reason for Rejection', 'VISAs rejection_B2C', 'cx@meydanfz.ae', FALSE),
('Complaints', 'Reason for Rejection', 'VISAs rejection_B2B', 'cp.support@meydanfz.ae', FALSE),

-- COMPLAINTS → Others
('Complaints', 'Others', 'Others', '', TRUE),

-- COMPLAINTS → Migration
('Complaints', 'Migration', 'B2B to B2C', 'cp.support@meydanfz.ae', FALSE),
('Complaints', 'Migration', 'B2B to B2B', 'cp.support@meydanfz.ae', FALSE),
('Complaints', 'Migration', 'B2C to B2B', 'cx@meydanfz.ae', FALSE),

-- ********************

-- QUERY → Accounts
('Query', 'Accounts', 'Already Paid', 'application@meydanfz.ae', FALSE),
('Query', 'Accounts', 'Overstay fine', 'application@meydanfz.ae', FALSE),
('Query', 'Accounts', 'Payment link', 'application@meydanfz.ae', FALSE),
('Query', 'Accounts', 'Pmnt. Conf Pending', 'application@meydanfz.ae', FALSE),

-- QUERY → Address issue
('Query', 'Address issue', 'Meydan ofc. address', 'cx@meydanfz.ae', FALSE),
('Query', 'Address issue', 'PO Box Address', 'cx@meydanfz.ae', FALSE),

-- QUERY → Application
('Query', 'Application', 'Changes Required', 'application@meydanfz.ae', FALSE),
('Query', 'Application', 'Expedite application', 'application@meydanfz.ae', FALSE),
('Query', 'Application', 'Ref/Cred Note fr App_B2C', 'cx@meydanfz.ae', FALSE),
('Query', 'Application', 'Ref/Cred Note fr App_B2B', 'cp.support@meydanfz.ae', FALSE),
('Query', 'Application', 'Status of aplication', 'application@meydanfz.ae', FALSE),

-- QUERY → M+ 
('Query', 'M+', 'Bank account_B2B', 'cp.support@meydanfz.ae', FALSE),
('Query', 'M+', 'Bank account_B2C', 'mas@meydanfz.ae', FALSE),
('Query', 'M+', 'Custom Code_B2B', 'cp.support@meydanfz.ae', FALSE),
('Query', 'M+', 'Custom Code_B2C', 'mas@meydanfz.ae', FALSE),
('Query', 'M+', 'Liquidation report_B2B', 'cp.support@meydanfz.ae', FALSE),
('Query', 'M+', 'Liquidation report_B2C', 'mas@meydanfz.ae', FALSE),
('Query', 'M+', 'Fin Audit report_B2B', 'cp.support@meydanfz.ae', FALSE),
('Query', 'M+', 'Fin Audit report_B2C', 'mas@meydanfz.ae', FALSE),
('Query', 'M+', 'Pre sale enquiry_B2C', 'msale@meydanfz.ae', FALSE),

-- QUERY → Office related
('Query', 'Office related', 'Appointment booking', 'cx@meydanfz.ae', FALSE),
('Query', 'Office related', 'Collection of EID_B2B', 'cp.support@meydanfz.ae', FALSE),
('Query', 'Office related', 'Collection of EID_B2C', 'cx@meydanfz.ae', FALSE),
('Query', 'Office related', 'Forgot belongings_B2B', 'cp.support@meydanfz.ae', FALSE),
('Query', 'Office related', 'Forgot belongings_B2C', 'cx@meydanfz.ae', FALSE),
('Query', 'Office related', 'Office space timing_B2B', 'cp.support@meydanfz.ae', FALSE),
('Query', 'Office related', 'Office space timing_B2C', 'cx@meydanfz.ae', FALSE),

-- QUERY → VISA
('Query', 'VISA', 'Dependent VISA_B2B', 'cp.support@meydanfz.ae', FALSE),
('Query', 'VISA', 'Dependent VISA_B2C_Pre', 'msale@meydanfz.ae', FALSE),
('Query', 'VISA', 'Dependent VISA_B2C_Post', 'mas@meydanfz.ae', FALSE),
('Query', 'VISA', 'Emp & investor VISA_B2B', 'cp.support@meydanfz.ae', FALSE),
('Query', 'VISA', 'Emp & investor VISA_B2C', 'cx@meydanfz.ae', FALSE),
('Query', 'VISA', 'Plan & Justification_B2B', 'cp.support@meydanfz.ae', FALSE),
('Query', 'VISA', 'Plan & Justification_B2C', 'cx@meydanfz.ae', FALSE),
('Query', 'VISA', 'VISA Alloctn - EJARI_B2B', 'cp.support@meydanfz.ae', FALSE),
('Query', 'VISA', 'VISA Alloctn - EJARI_B2C', 'cx@meydanfz.ae', FALSE),
('Query', 'VISA', 'Work permit_B2B', 'cp.support@meydanfz.ae', FALSE),
('Query', 'VISA', 'Work permit_B2C', 'cx@meydanfz.ae', FALSE),

-- QUERY → Business Setup
('Query', 'Business Setup', 'Business Setup', 'setup@meydanfz.ae', FALSE),
('Query', 'Business Setup', 'Reinquiry_B2C', 'b2csupport@meydanfz.ae', FALSE),

-- *****************

-- REQUEST → Channel Partner Lead 
('Request', 'Channel Partner Lead', 'Channel Partner Lead_B2B', 'cp.support@meydanfz.ae', FALSE),
('Request', 'Channel Partner Lead', 'Channel Partner Lead_B2C', 'cx@meydanfz.ae', FALSE),

-- REQUEST → Company cancellation
('Request', 'Company cancellation', 'Suspended company_B2B', 'cp.support@meydanfz.ae', FALSE),
('Request', 'Company cancellation', 'Suspended company_B2C', 'cx@meydanfz.ae', FALSE),

-- REQUEST → Labour Card 
('Request', 'Labour Card', 'Labour Card_B2B', 'cp.support@meydanfz.ae', FALSE),
('Request', 'Labour Card', 'Labour Card_B2C', 'cx@meydanfz.ae', FALSE),

-- REQUEST → Makhani number 
('Request', 'Makhani number', 'Makhani number_B2B', 'cp.support@meydanfz.ae', FALSE),
('Request', 'Makhani number', 'Makhani number_B2C', 'cx@meydanfz.ae', FALSE),

-- REQUEST → Migration
('Request', 'Migration', 'B2B to B2B', 'cp.support@meydanfz.ae', FALSE),
('Request', 'Migration', 'B2B to B2C', 'cp.support@meydanfz.ae', FALSE),
('Request', 'Migration', 'B2C to B2B', 'cx@meydanfz.ae', FALSE),

-- REQUEST → Name Check
('Request', 'Name Check', 'Name Check_B2B', 'cp.support@meydanfz.ae', FALSE),
('Request', 'Name Check', 'Name Check_B2C', 'cx@meydanfz.ae', FALSE),

-- REQUEST → Payment
('Request', 'Payment', 'Payment Invoices_B2B', 'cp.support@meydanfz.ae', FALSE),
('Request', 'Payment', 'Payment Invoices_B2C', 'cx@meydanfz.ae', FALSE),
('Request', 'Payment', 'Payment Link _B2B', 'cp.support@meydanfz.ae', FALSE),
('Request', 'Payment', 'Payment Link_B2C', 'cx@meydanfz.ae', FALSE),

-- REQUEST → PO BOX number
('Request', 'PO BOX number', 'PO BOX number_B2B', 'cp.support@meydanfz.ae', FALSE),
('Request', 'PO BOX number', 'PO BOX number_B2C', 'cx@meydanfz.ae', FALSE),

-- REQUEST → Guide
('Request', 'Guide', 'Application submission', 'guide@meydanfz.ae', FALSE),

-- REQUEST → Other
('Request', 'Other', 'Other', '', TRUE),

-- APPRECIATION 
('Appreciation', 'CX', 'Agent Name', 'cx@meydanfz.ae', FALSE),

-- General Enquiry 
('General Enquiry', 'Others', 'Others', '', TRUE);


-- View to get disposition hierarchy for frontend
CREATE VIEW disposition_hierarchy AS
SELECT DISTINCT 
  call_type,
  disposition_1,
  disposition_2,
  email_address,
  is_custom_input
FROM disposition_config
ORDER BY call_type, disposition_1, disposition_2;
