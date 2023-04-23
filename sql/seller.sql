CREATE OR REPLACE PROCEDURE create_seller(
    pass VARCHAR,
    name VARCHAR,
    address VARCHAR,
    ph_num VARCHAR,
    sllr OUT SELLER%rowtype
) AS
    cint INT NOT NULL DEFAULT 0;
    CURSOR get_count IS SELECT COUNT(*) FROM SELLER;
BEGIN
    OPEN get_count;
    FETCH get_count INTO cint;
    CLOSE get_count;
    IF cint = 0 THEN
        sllr.SELLER_ID := cint;
    ELSE
        sllr.SELLER_ID := cint + 1;
    END IF;
    sllr.ADDRESS := address;
    sllr.NAME := name;
    sllr.S_PASS := pass;
    INSERT INTO SELLER VALUES(sllr.SELLER_ID, sllr.S_PASS, sllr.NAME, sllr.ADDRESS);
    INSERT INTO SELLERPHONENUMBER VALUES(ph_num ,sllr.SELLER_ID);
END;

CREATE OR REPLACE PROCEDURE delete_seller(sid INT) AS
BEGIN
    DELETE FROM SELLER WHERE SELLER_ID=sid;
END;

CREATE OR REPLACE PROCEDURE update_seller(
    id INT,
    pass VARCHAR,
    name VARCHAR,
    address VARCHAR,
    ph_number VARCHAR,
    sllr OUT SELLER%rowtype
) AS
BEGIN
    sllr.SELLER_ID := id;
    sllr.ADDRESS := address;
    sllr.NAME := name;
    sllr.S_PASS := pass;
    UPDATE SELLER SET S_PASS = pass WHERE SELLER_ID = id;
    UPDATE SELLER SET ADDRESS = sllr.ADDRESS WHERE SELLER_ID = id;
    UPDATE SELLER SET NAME = sllr.NAME WHERE SELLER_ID = id;
    UPDATE SELLERPHONENUMBER SET PHONE_NUMBER = ph_number WHERE SELLER_ID = id;
END;

CREATE OR REPLACE PROCEDURE update_seller_by_id(
    id INT,
    sllr OUT SELLER%rowtype,
    sllr_ph OUT SELLERPHONENUMBER%rowtype
) AS
    CURSOR get_seller IS SELECT * FROM SELLER WHERE SELLER_ID = id;
    CURSOR get_seller_ph IS SELECT * FROM SELLERPHONENUMBER WHERE SELLER_ID = id;
BEGIN
    OPEN get_seller;
    FETCH get_seller INTO sllr;
    CLOSE get_seller;
    OPEN get_seller_ph;
    FETCH get_seller_ph INTO sllr_ph;
    CLOSE get_seller_ph;
END;

CREATE OR REPLACE PROCEDURE get_total_sellers(ct OUT NUMBER) AS
BEGIN
    SELECT COUNT(*) INTO ct FROM SELLER;
END;

