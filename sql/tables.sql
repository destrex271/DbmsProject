CREATE TABLE plat_users(
  id INT NOT NULL AUTO_INCREMENT,
  username VARCHAR(100) NOT NULL,
  --- Other Detials of User
  first_name VARCHAR(25) NOT NULL,
  middle_name VARCHAR(25) DEFAULT '',
  last_name VARCHAR(25) NOT NULL,
  --- Numerical details
  age INT,
  address VARCHAR(1000) NOT NULL,
  pincode INT NOT NULL,
  -- Constraints
  CHECK(age > 18),
);
