
//1. the grid_zone trigger

CREATE OR REPLACE TRIGGER trg_grid_zones
BEFORE INSERT ON Grid_zones
FOR EACH ROW
BEGIN
    IF :NEW.zone_id IS NULL THEN
        SELECT seq_grid_zones.NEXTVAL
        INTO :NEW.zone_id
        FROM dual;
    END IF;
END;
/


// the monthly trigger

CREATE OR REPLACE TRIGGER trg_monthly_summary
BEFORE INSERT ON monthly_energy_summary
FOR EACH ROW
BEGIN
    IF :NEW.summary_id IS NULL THEN
        SELECT seq_monthly_summary.NEXTVAL
        INTO :NEW.summary_id
        FROM dual;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_audit_bill

AFTER INSERT OR UPDATE OR DELETE

ON billing_records

FOR EACH ROW

BEGIN

INSERT INTO audit_log

VALUES
(
seq_audit.NEXTVAL,

'BILLING_RECORDS',

CASE

WHEN INSERTING THEN 'INSERT'

WHEN UPDATING THEN 'UPDATE'

WHEN DELETING THEN 'DELETE'

END,

USER,

SYSDATE

);

END;
/







