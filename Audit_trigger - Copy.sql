//INSERT INTO public_holidays VALUES (DATE '2026-07-01','Independence Day');

CREATE OR REPLACE TRIGGER trg_security

BEFORE INSERT OR UPDATE OR DELETE

ON billing_records

DECLARE

v_day VARCHAR2(20);

v_count NUMBER;

BEGIN

v_day:=TRIM(TO_CHAR(SYSDATE,'DAY'));

SELECT COUNT(*)

INTO v_count

FROM public_holidays

WHERE holiday_date=TRUNC(SYSDATE);

IF

v_day IN ('MONDAY','TUESDAY','WEDNESDAY','THURSDAY','FRIDAY')

OR

v_count>0

THEN

RAISE_APPLICATION_ERROR
(-20001,
'Database modifications are not allowed today.');

END IF;

END;
/