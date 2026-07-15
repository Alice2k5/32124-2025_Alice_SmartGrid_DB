
//First create the package specification.
CREATE OR REPLACE PACKAGE energy_management_pkg AS

    PROCEDURE add_customer(
        p_full_name VARCHAR2,
        p_phone_number VARCHAR2,
        p_email VARCHAR2,
        p_address VARCHAR2
    );

    PROCEDURE add_smart_meter(
        p_serial_number VARCHAR2,
        p_customer_id NUMBER,
        p_zone_id NUMBER
    );

    FUNCTION calculate_total_kwh(
        p_meter_id NUMBER
    ) RETURN NUMBER;

    FUNCTION calculate_total_bill(
        p_meter_id NUMBER
    ) RETURN NUMBER;

END energy_management_pkg;
/


//Now the Package Body.

CREATE OR REPLACE PACKAGE BODY energy_management_pkg AS

----------------------------------------------------
PROCEDURE add_customer(
    p_full_name VARCHAR2,
    p_phone_number VARCHAR2,
    p_email VARCHAR2,
    p_address VARCHAR2
)
IS
BEGIN

INSERT INTO customers
VALUES
(
    seq_customers.NEXTVAL,
    p_full_name,
    p_phone_number,
    p_email,
    p_address
);

END;

----------------------------------------------------
PROCEDURE add_smart_meter(
    p_serial_number VARCHAR2,
    p_customer_id NUMBER,
    p_zone_id NUMBER
)
IS
BEGIN

INSERT INTO smart_meters
(
meter_id,
serial_number,
meter_status,
cust_id,
zone_id
)

VALUES
(
seq_smart_meters.NEXTVAL,
p_serial_number,
'ACTIVE',
p_customer_id,
p_zone_id
);

END;

----------------------------------------------------
FUNCTION calculate_total_kwh(
p_meter_id NUMBER
)

RETURN NUMBER

IS

v_total NUMBER;

BEGIN

SELECT NVL(SUM(kwh_consumed),0)

INTO v_total

FROM consumption_logs

WHERE meter_id=p_meter_id;

RETURN v_total;

END;

----------------------------------------------------
FUNCTION calculate_total_bill(
p_meter_id NUMBER
)

RETURN NUMBER

IS

v_bill NUMBER;

BEGIN

SELECT NVL(SUM(total_amount),0)

INTO v_bill

FROM billing_records

WHERE meter_id=p_meter_id;

RETURN v_bill;

END;

END energy_management_pkg;
/





