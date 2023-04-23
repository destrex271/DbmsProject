CREATE OR REPLACE PROCEDURE add_product(
    prd_name IN VARCHAR2,
    prd_type IN VARCHAR2,
    color IN VARCHAR2,
    agegroup IN VARCHAR2,
    prd_size IN VARCHAR2,
    gender IN VARCHAR2,
    commission IN NUMBER,
    cost IN NUMBER,
    quantity IN NUMBER,
    seller_id IN NUMBER) IS
    prdct PRODUCT%rowtype;
    prd_cnt NUMBER;
BEGIN
    SELECT COUNT(*) INTO prd_cnt FROM PRODUCT;

    IF prd_cnt = 0 THEN
        prdct.PRODUCT_ID := 1;
    ELSE
        SELECT MAX(PRODUCT_ID) + 1 INTO prdct.PRODUCT_ID FROM PRODUCT;
    END IF;

    prdct.PRD_NAME := prd_name;
    prdct.PRD_TYPE := prd_type;
    prdct.COLOR := color;
    prdct.AGEGROUP := agegroup;
    prdct.PRD_SIZE := prd_size;
    prdct.GENDER := gender;
    prdct.COMMISSION := commission;
    prdct.COST := cost;
    prdct.QUANTITY := quantity;
    prdct.SELLER_ID := seller_id;

    INSERT INTO PRODUCT (PRODUCT_ID, PRD_NAME, PRD_TYPE, COLOR, AGEGROUP, PRD_SIZE, GENDER, COMMISSION, COST, QUANTITY, SELLER_ID)
    VALUES (prdct.PRODUCT_ID, prdct.PRD_NAME, prdct.PRD_TYPE, prdct.COLOR, prdct.AGEGROUP, prdct.PRD_SIZE,
            prdct.GENDER, prdct.COMMISSION, prdct.COST, prdct.QUANTITY, prdct.SELLER_ID);
END;
/
CREATE OR REPLACE PROCEDURE update_product(
    prd_id IN INT,
    pprd_name IN VARCHAR2,
    pprd_type IN VARCHAR2,
    pcolor IN VARCHAR2,
    pagegroup IN VARCHAR2,
    pprd_size IN VARCHAR2,
    pgender IN VARCHAR2,
    pcommission IN NUMBER,
    pcost IN NUMBER,
    pquantity IN NUMBER,
    pseller_id IN NUMBER
) AS
    prdt PRODUCT%rowtype;
    CURSOR get_product(id INT) IS SELECT * FROM PRODUCT WHERE PRODUCT_ID = id;
BEGIN
    OPEN get_product(prd_id);
    FETCH get_product INTO prdt;
    IF get_product%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('Product Not Found!');
    ELSE
        UPDATE PRODUCT SET PRD_NAME = pprd_name WHERE PRODUCT_ID = prd_id;
        UPDATE PRODUCT SET PRD_TYPE = pprd_type WHERE PRODUCT_ID = prd_id;
        UPDATE PRODUCT SET COLOR = pcolor WHERE PRODUCT_ID = prd_id;
        UPDATE PRODUCT SET AGEGROUP = pagegroup WHERE PRODUCT_ID = prd_id;
        UPDATE PRODUCT SET PRD_SIZE = pprd_size WHERE PRODUCT_ID = prd_id;
        UPDATE PRODUCT SET GENDER = pgender WHERE PRODUCT_ID = prd_id;
        UPDATE PRODUCT SET COMMISSION = pcommission WHERE PRODUCT_ID = prd_id;
        UPDATE PRODUCT SET COST = pcost WHERE PRODUCT_ID = prd_id;
        UPDATE PRODUCT SET QUANTITY = pquantity WHERE PRODUCT_ID = prd_id;
        UPDATE PRODUCT SET SELLER_ID = pseller_id WHERE PRODUCT_ID = prd_id;
    END IF;
    CLOSE get_product;
END;
/
CREATE OR REPLACE PROCEDURE delete_product(prd_id IN INT) IS
BEGIN
    DELETE FROM PRODUCT WHERE PRODUCT_ID = prd_id;
END;
/
CREATE OR REPLACE PROCEDURE get_product_by_id(
    prd_id IN INT,
    prd OUT PRODUCT%rowtype
) AS
    CURSOR get_pr(itd INT) IS SELECT * FROM PRODUCT WHERE PRODUCT_ID = itd;
BEGIN
    OPEN get_pr(prd_id);
    FETCH get_pr INTO prd;
    CLOSE get_pr;
END;
/
CREATE OR REPLACE PROCEDURE get_total_products(ct OUT NUMBER) AS
BEGIN
    SELECT COUNT(*) INTO ct FROM PRODUCT;
END;