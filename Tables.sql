
// table 1

CREATE TABLE Grid_zones (
    zone_id NUMBER PRIMARY KEY,
    zone_name VARCHAR2(100) NOT NULL UNIQUE,
    region VARCHAR2(50) NOT NULL
);

// 2. smart-meters

CREATE TABLE smart_meters (
    meter_id NUMBER PRIMARY KEY,
    serial_number VARCHAR2(50) NOT NULL UNIQUE,
    meter_status VARCHAR2(20)
        DEFAULT 'ACTIVE'
        CHECK (meter_status IN ('ACTIVE', 'SUSPENDED', 'MAINTENANCE')),
    cust_id NUMBER,
    zone_id NUMBER,

    CONSTRAINT fk_meter_customers
        FOREIGN KEY (cust_id)
        REFERENCES customers(customer_id)
        ON DELETE SET NULL,

    CONSTRAINT fk_meter_zone
        FOREIGN KEY (zone_id)
        REFERENCES Grid_zones(zone_id)
);

CREATE SEQUENCE seq_smart_meters
START WITH 1
INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_smart_meters
BEFORE INSERT ON smart_meters
FOR EACH ROW
BEGIN
    IF :NEW.meter_id IS NULL THEN
        SELECT seq_smart_meters.NEXTVAL
        INTO :NEW.meter_id
        FROM dual;
    END IF;
END;
/

// 3. customers


//select * from customers;
//select * from grid_zones;
select * from smart_meters;


CREATE TABLE audit_log(

audit_id NUMBER PRIMARY KEY,

table_name VARCHAR2(50),

operation VARCHAR2(20),

username VARCHAR2(30),

action_date DATE

);


CREATE TABLE public_holidays(

holiday_date DATE PRIMARY KEY,

holiday_name VARCHAR2(100)

);