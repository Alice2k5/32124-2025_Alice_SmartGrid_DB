// customers procedures


CREATE OR REPLACE PROCEDURE add_customer(
    p_full_name    IN customers.full_name%TYPE,
    p_phone_number IN customers.phone_number%TYPE,
    p_email        IN customers.email%TYPE,
    p_address      IN customers.address%TYPE
)
AS
BEGIN
    INSERT INTO customers
    (
        customer_id,
        full_name,
        phone_number,
        email,
        address
    )
    VALUES
    (
        seq_customers.NEXTVAL,
        p_full_name,
        p_phone_number,
        p_email,
        p_address
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Customer registered successfully.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/




CREATE OR REPLACE PROCEDURE add_smart_meter(
    p_serial_number IN smart_meters.serial_number%TYPE,
    p_customer_id   IN smart_meters.cust_id%TYPE,
    p_zone_id       IN smart_meters.zone_id%TYPE
)
AS
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

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Smart meter registered successfully.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/


BEGIN
    add_smart_meter(
        'SM-REG-2026-050',
        1,
        1
    );
END;
/


//record energy consumption

CREATE OR REPLACE PROCEDURE add_consumption(
    p_meter_id IN NUMBER,
    p_kwh      IN NUMBER
)
AS
BEGIN

    INSERT INTO consumption_logs
    (
        log_id,
        meter_id,
        reading_timestamp,
        kwh_consumed
    )
    VALUES
    (
        seq_consumption_logs.NEXTVAL,
        p_meter_id,
        SYSDATE,
        p_kwh
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Consumption recorded.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/


// generate_bill

CREATE OR REPLACE PROCEDURE generate_bill(
    p_meter_id     IN NUMBER,
    p_total_kwh    IN NUMBER,
    p_total_amount IN NUMBER,
    p_due_date     IN DATE
)
AS
BEGIN

    INSERT INTO billing_records
    (
        bill_id,
        meter_id,
        bill_date,
        total_kwh,
        total_amount,
        due_date,
        payment_status
    )
    VALUES
    (
        seq_billing_records.NEXTVAL,
        p_meter_id,
        SYSDATE,
        p_total_kwh,
        p_total_amount,
        p_due_date,
        'UNPAID'
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Bill generated successfully.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/






