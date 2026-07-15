
// cursor to display smart metters
SET SERVEROUTPUT ON;

DECLARE
    CURSOR c_meters IS
        SELECT meter_id, serial_number, meter_status
        FROM smart_meters;

    v_meter_id smart_meters.meter_id%TYPE;
    v_serial smart_meters.serial_number%TYPE;
    v_status smart_meters.meter_status%TYPE;

BEGIN
    OPEN c_meters;

    LOOP
        FETCH c_meters INTO v_meter_id, v_serial, v_status;
        EXIT WHEN c_meters%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            'Meter ID: ' || v_meter_id ||
            ', Serial Number: ' || v_serial ||
            ', Status: ' || v_status
        );
    END LOOP;

    CLOSE c_meters;
END;
/


//Cursor to Display Consumption and Billing Information

SET SERVEROUTPUT ON;

DECLARE
    CURSOR c_meters IS
        SELECT meter_id
        FROM smart_meters;

    v_meter_id smart_meters.meter_id%TYPE;
    v_total_kwh NUMBER;
    v_total_bill NUMBER;

BEGIN
    OPEN c_meters;

    LOOP
        FETCH c_meters INTO v_meter_id;
        EXIT WHEN c_meters%NOTFOUND;

        SELECT NVL(SUM(kwh_consumed),0)
        INTO v_total_kwh
        FROM consumption_logs
        WHERE meter_id = v_meter_id;

        SELECT NVL(SUM(total_amount),0)
        INTO v_total_bill
        FROM billing_records
        WHERE meter_id = v_meter_id;

        DBMS_OUTPUT.PUT_LINE(
            'Meter ID: ' || v_meter_id ||
            ' | Total kWh: ' || v_total_kwh ||
            ' | Total Bill: ' || v_total_bill
        );

    END LOOP;

    CLOSE c_meters;
END;
/


//BULK COLLECT Example
SET SERVEROUTPUT ON;

DECLARE

    TYPE t_cust_id IS TABLE OF customers.cust_id%TYPE;

    v_cust_id t_cust_id;

BEGIN

    SELECT cust_id
    BULK COLLECT INTO v_cust_id
    FROM customers;

    FOR i IN v_cust_id.FIRST .. v_cust_id.LAST LOOP

        DBMS_OUTPUT.PUT_LINE(
            'Cust_id : ' || v_cust_id(i)
        );

    END LOOP;

END;
/


 //monthly_energy_summary

CREATE TABLE monthly_energy_summary (
    summary_id NUMBER PRIMARY KEY,
    meter_id NUMBER NOT NULL,
    summary_month NUMBER(2) NOT NULL,
    summary_year NUMBER(4) NOT NULL,
    total_kwh NUMBER(10,2),
    total_bill NUMBER(12,2),
    total_readings NUMBER,
    generated_on DATE DEFAULT SYSDATE,

    CONSTRAINT fk_summary_meter
        FOREIGN KEY (meter_id)
        REFERENCES smart_meters(meter_id)
);





