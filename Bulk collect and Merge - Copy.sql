SET SERVEROUTPUT ON;

DECLARE

TYPE t_meter IS TABLE OF smart_meters.meter_id%TYPE;

v_meter_id t_meter;

v_month NUMBER:=7;
v_year NUMBER:=2026;

BEGIN

SELECT meter_id
BULK COLLECT INTO v_meter_id
FROM smart_meters;

FOR i IN v_meter_id.FIRST..v_meter_id.LAST LOOP

MERGE INTO monthly_energy_summary ms

USING dual

ON
(
ms.meter_id=v_meter_id(i)
AND
ms.summary_month=v_month
AND
ms.summary_year=v_year
)

WHEN MATCHED THEN

UPDATE SET

total_kwh=
(
SELECT NVL(SUM(kwh_consumed),0)

FROM consumption_logs

WHERE meter_id=v_meter_id(i)
),

total_bill=
(
SELECT NVL(SUM(total_amount),0)

FROM billing_records

WHERE meter_id=v_meter_id(i)
),

total_readings=
(
SELECT COUNT(*)

FROM consumption_logs

WHERE meter_id=v_meter_id(i)
);

WHEN NOT MATCHED THEN

INSERT
(
summary_id,
meter_id,
summary_month,
summary_year,
total_kwh,
total_bill,
total_readings
)

VALUES
(
seq_monthly_summary.NEXTVAL,

v_meter_id(i),

v_month,

v_year,

(SELECT NVL(SUM(kwh_consumed),0)
FROM consumption_logs
WHERE meter_id=v_meter_id(i)),

(SELECT NVL(SUM(total_amount),0)
FROM billing_records
WHERE meter_id=v_meter_id(i)),

(SELECT COUNT(*)
FROM consumption_logs
WHERE meter_id=v_meter_id(i))
);

END LOOP;

COMMIT;

END;
/