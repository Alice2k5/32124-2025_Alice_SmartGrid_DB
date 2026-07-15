/*
// Calculate Total Energy Consumed

CREATE OR REPLACE FUNCTION calculate_total_kwh(
    p_meter_id IN NUMBER
)
RETURN NUMBER
IS
    v_total_kwh NUMBER;
BEGIN
    SELECT NVL(SUM(kwh_consumed),0)
    INTO v_total_kwh
    FROM consumption_logs
    WHERE meter_id = p_meter_id;

    RETURN v_total_kwh;

EXCEPTION
    WHEN OTHERS THEN
        RETURN 0;
END;
/


SELECT calculate_total_kwh(1) AS Total_KWH
FROM dual;


//f2 Calculate Total Bill
CREATE OR REPLACE FUNCTION calculate_total_bill(
    p_meter_id IN NUMBER
)
RETURN NUMBER
IS
    v_total_bill NUMBER;
BEGIN
    SELECT NVL(SUM(total_amount),0)
    INTO v_total_bill
    FROM billing_records
    WHERE meter_id = p_meter_id;

    RETURN v_total_bill;

EXCEPTION
    WHEN OTHERS THEN
        RETURN 0;
END;
/

SELECT calculate_total_bill(1) AS Total_Bill
FROM dual;




// get customer names
CREATE OR REPLACE FUNCTION get_customer_name(
    p_meter_id IN NUMBER
)
RETURN VARCHAR2
IS
    v_name customers.full_name%TYPE;
BEGIN

    SELECT c.full_name
    INTO v_name
    FROM customers 
    JOIN smart_meters 
      ON c.cust_id = s.cust_id
    WHERE s.meter_id = p_meter_id;

    RETURN v_name;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Customer Not Found';

    WHEN OTHERS THEN
        RETURN 'Error';
END;
/


//SELECT get_customer_name(1)FROM dual;

//4. count_bill
CREATE OR REPLACE FUNCTION count_customer_bills(
    p_meter_id IN NUMBER
)
RETURN NUMBER
IS
    v_count NUMBER;
BEGIN

    SELECT COUNT(*)
    INTO v_count
    FROM billing_records
    WHERE meter_id = p_meter_id;

    RETURN v_count;

END;
/


//SELECT count_customer_bills(1)FROM dual;

*/




