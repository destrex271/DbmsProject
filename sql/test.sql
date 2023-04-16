DELIMITER /

CREATE OR REPLACE PROCEDURE get_customer_count(a OUT INT) AS
  BEGIN
    SELECT COUNT(*) INTO a FROM Customer;
    SELECT 'COUNT SELECTED';
  END get_customer_count;
/

CREATE OR REPLACE init_data() AS
BEGIN

END init_data;

CREATE OR REPLACE PROCEDURE create_customer AS
  BEGIN
    DECLARE
      custm_count INT;
    BEGIN
      get_customer_count(custm_count);
      SELECT custm_count;
    END;
  END create_customer;
/


CREATE OR REPLACE PROCEDURE clean_all_tables AS
  BEGIN
    DROP TABLE Payment;
    DROP TABLE Cart_item;
    DROP TABLE Product;
    DROP TABLE SellerPhoneNumber;
    DROP TABLE Seller;
    DROP TABLE Customer;
    DROP TABLE Cart;
  END clean_all_tables;
/

BEGIN
  create_customer();
END;
/

DELIMITER ;
