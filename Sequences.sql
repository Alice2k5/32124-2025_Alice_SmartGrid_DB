
// 1. the sequence for grid_zone
CREATE SEQUENCE seq_grid_zones
START WITH 1
INCREMENT BY 1;

// sequences for monthly_summary
CREATE SEQUENCE seq_monthly_summary
START WITH 1
INCREMENT BY 1;


SELECT sequence_name
FROM user_sequences
WHERE sequence_name = 'SEQ_customers';

CREATE SEQUENCE seq_audit;