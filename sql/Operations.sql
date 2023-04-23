-- CREATE CUSTOMERS
DECLARE
    cst_count INT;
    passwd VARCHAR(20);
    addr VARCHAR(100);
    phnum VARCHAR(10);
    pinc INT;
    nme VARCHAR(20);
BEGIN
    passwd := 'patswd442345';
    addr := 'dfhdfus  sdsddfts ydstfysd';
    nme := 'Raman Sharma';
    phnum := '9118296795';
    pinc := 248001;
    CREATE_CUSTOMER(
        passwd, addr,
        nme, phnum,
        pinc
    );
END;
/
-- CREATE SELLER
DECLARE
    passwd VARCHAR(256);
    name VARCHAR(25);
    address VARCHAR(300);
    ph_num VARCHAR(10);
    sllr SELLER%rowtype;
BEGIN
    passwd := '@k689756jbdufbsdubfudsf';
    name := 'seller123';
    address := 'asdthhdghghydsifbdsifybidsfb dkfhdf';
    ph_num := '8168996795';
    CREATE_SELLER(
        passwd, name,
        address, ph_num,
        sllr
    );
END;
/
DECLARE
    prd_name VARCHAR(100);
    prd_type VARCHAR(300);
    clr VARCHAR(10);
    agegrp VARCHAR(100);
    prd_size VARCHAR(25);
    gender VARCHAR(25);
    commission FLOAT;
    cost FLOAT;
    qty FLOAT;
    slr_id INT;
BEGIN
    prd_name := 'Cosmic Byte - Mechanical Keyboard';
    prd_type := 'Computer Accessory';
    clr := 'Red';
    agegrp := 'For all ages';
    prd_size := '25 x 25; 2kg';
    gender := 'All';
    commission := 13;
    cost := 9000;
    qty := 100000000;
    slr_id := 2;
    ADD_PRODUCT(
        prd_name, prd_type,
        clr, agegrp, prd_size,
        gender, commission, cost,
        qty, slr_id
    );
END;
/
DECLARE
    usr_id INT;
    prd_id INT;
    qt_wished FLOAT;
BEGIN
    usr_id := 2;
    prd_id := 6;
    qt_wished := 2;
    ADD_TO_CART(prd_id, usr_id, qt_wished, sysdate);
END;
/
DECLARE
    crt_it_id INT;
    prd_id INT;
    usr_id INT;
BEGIN
    crt_it_id := 1;
    prd_id := 6;
    usr_id := 2;
    BUY_ITEM(crt_it_id, prd_id, usr_id);
END;