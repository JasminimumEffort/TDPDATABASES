CREATE DATABASE fat_annies;
use fat_annies;

CREATE TABLE customers(
cust_id INT UNIQUE NOT NULL AUTO_INCREMENT,
cust_name VARCHAR(100) DEFAULT "unknown",
phone_number CHAR(11) NOT NULL, 
over_18 BOOLEAN,
points DECIMAL(6,2),
PRIMARY KEY(cust_id));

SHOW TABLES;
DESCRIBE customers;
DROP TABLE customers;
INSERT INTO customers(cust_name, phone_number,over_18, points) VALUES("Poppy", "07956348975","1","362.48");
SELECT * FROM customers;
INSERT INTO customers(cust_name, phone_number,over_18, points) VALUES("VEGAN", "07956222975", "0","367.48");

CREATE TABLE orders(
o_id INT UNIQUE NOT NULL AUTO_INCREMENT,
cust_id INT NOT NULL,
o_date DATE,
PRIMARY KEY(o_id),
FOREIGN KEY(cust_id) REFERENCES customers(cust_id));

ALTER TABLE customers ADD age INT NOT NULL; #update an existing table adding a new column

ALTER TABLE customers DROP COLUMN over_18; #removed a column

ALTER TABLE customers MODIFY cust_name VARCHAR(50) DEFAULT "N/A";