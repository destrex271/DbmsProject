CREATE TABLE Cart
(
    cart_id INT PRIMARY KEY
);

-- CRUD OPs done for Customer Table
CREATE TABLE Customer
(
    customer_id  INT PRIMARY KEY,
    c_pass       VARCHAR(20),
    name         VARCHAR(20),
    address      VARCHAR(20),
    phone_number VARCHAR(20),
    pincode      INT,
    cart_id      INT,
    FOREIGN KEY (cart_id) REFERENCES Cart (cart_id) ON DELETE SET NULL
);

--
CREATE TABLE Seller
(
    seller_id INT PRIMARY KEY,
    s_pass    VARCHAR(256),
    name      VARCHAR(25),
    address   VARCHAR(300)
);

CREATE TABLE SellerPhoneNumber
(
    phone_number VARCHAR(10),
    seller_id    INT,
    FOREIGN KEY (seller_id) REFERENCES Seller (seller_id) ON DELETE CASCADE
);

-- CRUD OPs done for Product Table
CREATE TABLE Product
(
    product_id INT PRIMARY KEY,
    prd_name   VARCHAR(100),
    prd_type   VARCHAR(10),
    color      VARCHAR(10),
    agegroup   VARCHAR(20),
    prd_size   VARCHAR(25),
    gender     VARCHAR(25),
    commission FLOAT,
    cost       FLOAT,
    quantity   FLOAT,
    seller_id  INT,
    FOREIGN KEY (seller_id) REFERENCES Seller (seller_id) ON DELETE CASCADE
);

CREATE TABLE Cart_item
(
    cart_id         INT,
    product_id      INT,
    quantity_wished FLOAT,
    date_added      DATE,
    purchased       NUMBER(1, 0),
    FOREIGN KEY (cart_id) REFERENCES Cart (cart_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Product (product_id) ON DELETE CASCADE
);

CREATE TABLE Payment
(
    payment_id   INT PRIMARY KEY,
    payment_date DATE,
    payment_type VARCHAR(25),
    total_amount FLOAT,
    customer_id  INT,
    cart_id      INT,
    FOREIGN KEY (customer_id) REFERENCES Customer (customer_id) ON DELETE CASCADE,
    FOREIGN KEY (cart_id) REFERENCES Cart (cart_id) ON DELETE CASCADE
);
