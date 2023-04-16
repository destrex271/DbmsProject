CREATE TABLE Cart(
  cart_id INT AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE Customer(
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  c_pass VARCHAR(256),
  name VARCHAR(100),
  address VARCHAR(300),
  phone_number VARCHAR(10),
  pincode INT(6),
  cart_id INT,
  FOREIGN KEY(cart_id) REFERENCES Cart(cart_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Seller(
  seller_id INT AUTO_INCREMENT PRIMARY KEY,
  s_pass VARCHAR(256),
  name VARCHAR(25),
  address VARCHAR(300)
);

CREATE TABLE SellerPhoneNumber(
  phone_number VARCHAR(10),
  seller_id INT,
  FOREIGN KEY(seller_id) REFERENCES Seller(seller_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Product(
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  prd_type VARCHAR(10),
  color VARCHAR(10),
  agegroup VARCHAR(20),
  prd_size VARCHAR(25),
  gender VARCHAR(25),
  commission FLOAT,
  cost FLOAT,
  quantity FLOAT,
  seller_id INT,
  FOREIGN KEY (seller_id) REFERENCES Seller(seller_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Cart_item(
  cart_id INT,
  product_id INT,
  quantity_wished FLOAT,
  date_added DATETIME,
  purchased BOOLEAN,
  FOREIGN KEY (cart_id) REFERENCES Cart(cart_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (product_id) REFERENCES Product(product_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Payment(
  payment_id INT AUTO_INCREMENT PRIMARY KEY,
  payment_date DATETIME,
  payment_type VARCHAR(25),
  total_amount FLOAT,
  customer_id INT,
  cart_id INT,
  FOREIGN KEY(customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(cart_id) REFERENCES Cart(cart_id) ON DELETE CASCADE ON UPDATE CASCADE
);
