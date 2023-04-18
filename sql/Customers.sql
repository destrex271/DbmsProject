SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE create_customer(
    pass IN VARCHAR, address IN VARCHAR, name IN VARCHAR,
    ph_num IN VARCHAR, pincode IN INT) AS
    cstm CUSTOMER%rowtype;
    cur_count  INT NOT NULL DEFAULT 0;
    cart_count INT NOT NULL DEFAULT 0;
    CURSOR get_cart_count IS SELECT COUNT(*)
                             FROM CART;
    CURSOR get_count IS SELECT COUNT(*)
                        FROM CUSTOMER;
BEGIN
    -- Create New Cart for new User
    OPEN get_cart_count;
    FETCH get_cart_count INTO cart_count;
    cart_count := cart_count + 1;
    CLOSE get_cart_count;
    INSERT INTO CART VALUES (cart_count);

    -- Get Current Number of Users
    OPEN get_count;
    FETCH get_count INTO cur_count;
    CLOSE get_count;

    IF cur_count = 0 THEN
        cstm.CUSTOMER_ID := cur_count;
    ELSE
        cstm.CUSTOMER_ID := cur_count + 1;
    END IF;
    cstm.C_PASS := pass;
    cstm.ADDRESS := address;
    cstm.NAME := name;
    cstm.PHONE_NUMBER := ph_num;
    cstm.CART_ID := cart_count;
    cstm.PINCODE := pincode;
    INSERT INTO CUSTOMER (CUSTOMER_ID, C_PASS, ADDRESS, NAME, PHONE_NUMBER, CART_ID, PINCODE)
    VALUES (cstm.CUSTOMER_ID, cstm.C_PASS, cstm.ADDRESS, cstm.NAME, cstm.PHONE_NUMBER, cstm.CART_ID, cstm.PINCODE);
END;

CREATE OR REPLACE PROCEDURE update_customer(
    cust_id IN INT, pass IN VARCHAR, caddress IN VARCHAR,
    cname IN VARCHAR, ph_num IN VARCHAR, cpincode IN INT
) AS
    cutsm CUSTOMER%rowtype;
    CURSOR get_customer(id INT) IS SELECT * FROM CUSTOMER WHERE CUSTOMER_ID = id;
BEGIN
    OPEN get_customer(cust_id);
    FETCH get_customer INTO cutsm;
    IF get_customer%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('Customer Not found');
    ELSE
        UPDATE CUSTOMER SET C_PASS = pass WHERE CUSTOMER_ID = cust_id;
        UPDATE CUSTOMER SET ADDRESS = caddress WHERE CUSTOMER_ID = cust_id;
        UPDATE CUSTOMER SET NAME = cname WHERE CUSTOMER_ID = cust_id;
        UPDATE CUSTOMER SET PHONE_NUMBER = ph_num WHERE CUSTOMER_ID = cust_id;
        UPDATE CUSTOMER SET PINCODE = cpincode WHERE CUSTOMER_ID = cust_id;
    END IF;
    CLOSE get_customer;
END;

CREATE OR REPLACE PROCEDURE delete_customer(cust_id IN INT) AS
    cnt INT NOT NULL DEFAULT 0;
    CURSOR customer_count IS SELECT COUNT(*) FROM CUSTOMER;
BEGIN
    OPEN customer_count;
    FETCH customer_count INTO cnt;
    CLOSE customer_count;
    IF cnt > 0 THEN
        DELETE FROM CUSTOMER WHERE CUSTOMER_ID = cust_id;
    END IF;
END;

CREATE OR REPLACE PROCEDURE get_total_customers(ct OUT NUMBER) AS
BEGIN
    SELECT COUNT(*) INTO ct FROM CUSTOMER;
END;