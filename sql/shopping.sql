CREATE OR REPLACE PROCEDURE add_to_cart(
    prd_id NUMBER,
    usr_id NUMBER,
    qty NUMBER,
    dt DATE
) AS
    crt_id INT;
    CURSOR get_cart_id IS SELECT CART.CART_ID FROM CART JOIN CUSTOMER ON CUSTOMER_ID = usr_id;
BEGIN
    OPEN get_cart_id;
    FETCH get_cart_id INTO crt_id;
    CLOSE get_cart_id;
    INSERT INTO CART_ITEM VALUES(crt_id, prd_id, qty, dt, 0);
END;

CREATE OR REPLACE PROCEDURE add_payment(
    crt_id INT,
    cstm_id INT,
    price NUMBER,
    qt_pur NUMBER
) AS
    ptc INT;
    CURSOR get_pymt_count IS SELECT COUNT(*) FROM PAYMENT;
BEGIN
    OPEN get_pymt_count;
    FETCH get_pymt_count INTO ptc;
    CLOSE get_pymt_count;
    INSERT INTO PAYMENT VALUES(ptc+1, sysdate, 'transaction', price * qt_pur, cstm_id, crt_id);
END;

CREATE OR REPLACE PROCEDURE buy_item(
    crt_item_id INT,
    prd_id INT,
    cst_id INT
) AS
    CURSOR get_total_qty IS SELECT QUANTITY FROM PRODUCT WHERE PRODUCT_ID = prd_id;
    CURSOR get_wished_qty IS SELECT QUANTITY_WISHED FROM CART_ITEM WHERE CART_ID = crt_item_id AND PRODUCT_ID = prd_id;
    CURSOR get_price IS SELECT COST FROM PRODUCT WHERE PRODUCT_ID = prd_id;
    totalq INT;
    wishedq INT;
    price NUMBER;
BEGIN
    OPEN get_wished_qty;
    FETCH get_wished_qty INTO wishedq;
    CLOSE get_wished_qty;
    OPEN get_total_qty;
    FETCH get_total_qty INTO totalq;
    CLOSE get_total_qty;
    OPEN get_price;
    FETCH get_price INTO price;
    CLOSE get_price;
    UPDATE CART_ITEM SET PURCHASED = 1 WHERE CART_ID = crt_item_id AND PRODUCT_ID = prd_id;
    UPDATE PRODUCT SET QUANTITY = totalq - wishedq WHERE PRODUCT_ID = prd_id;
    ADD_PAYMENT(crt_item_id, cst_id, price, wishedq);
END;

CREATE OR REPLACE PROCEDURE clear_cart(
    crt_id INT
) AS
BEGIN
    DELETE CART_ITEM WHERE CART_ID = crt_id;
END;