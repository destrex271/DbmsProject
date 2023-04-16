SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE create_customer(cstm IN OUT CUSTOMER%ROWTYPE) AS
    cur_count INT NOT NULL DEFAULT 0;
    v_cart_id CART.CART_ID%TYPE;
    cart_count INT NOT NULL DEFAULT 0;
    CURSOR get_cart_count IS SELECT COUNT(*) FROM CART;
    CURSOR get_count IS SELECT COUNT(*) FROM CUSTOMER;
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
    cstm.C_PASS := 'password123';
    cstm.ADDRESS := '123 Main St';
    cstm.NAME := 'John Doe';
    cstm.PHONE_NUMBER := '123-456-7890';
    cstm.CART_ID := cart_count;
    cstm.PINCODE := '12345';
    INSERT INTO CUSTOMER (CUSTOMER_ID, C_PASS, ADDRESS, NAME, PHONE_NUMBER, CART_ID, PINCODE)
    VALUES(cstm.CUSTOMER_ID, cstm.C_PASS, cstm.ADDRESS, cstm.NAME, cstm.PHONE_NUMBER, cstm.CART_ID, cstm.PINCODE);
END;
/

DECLARE
    cstm CUSTOMER%ROWTYPE;
BEGIN
    create_customer(cstm);
END;
/
