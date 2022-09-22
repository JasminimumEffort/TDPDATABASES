CREATE DATABASE team1_vegan;
USE team1_vegan;

#CREATING CUSTOMER TABLE
CREATE TABLE customers(
cust_id INT UNIQUE NOT NULL AUTO_INCREMENT,
cust_name VARCHAR(100) NOT NULL,
cust_email VARCHAR(100) UNIQUE,
cust_num CHAR(11) UNIQUE NOT NULL,
address_l1 VARCHAR(200) NOT NULL,
address_l2 VARCHAR(200),
town_city VARCHAR(100),
postcode VARCHAR(10) NOT NULL,
del_info VARCHAR(300) DEFAULT "N/A",
subscribe BOOLEAN DEFAULT FALSE,
mark_email BOOLEAN DEFAULT FALSE,
mark_text BOOLEAN DEFAULT FALSE,
mark_post BOOLEAN DEFAULT FALSE,
PRIMARY KEY(cust_id));

#CREATING MENU TABLE
CREATE TABLE menu(
item_id INT UNIQUE NOT NULL,
item_name VARCHAR(200) NOT NULL,
item_des VARCHAR(500),
allergens VARCHAR(500) DEFAULT "None" NOT NULL,
price DECIMAL(6,2) NOT NULL,
calories INT NOT NULL,
available BOOLEAN DEFAULT TRUE,
PRIMARY KEY(item_id));


SHOW TABLES;
DESCRIBE customers;
ALTER TABLE customers MODIFY cust_name VARCHAR(101) NOT NULL;
ALTER TABLE menu MODIFY item_id INT UNIQUE NOT NULL AUTO_INCREMENT;

INSERT INTO menu(item_name, item_des, allergens, price, calories) VALUES("Power Bowl","yum","Soya","9.95","451");
DELETE FROM menu where item_id = "1";
DESCRIBE menu;
SELECT * FROM menu;

#CREATING MENU RECORDS
INSERT INTO menu(item_name, allergens, price, calories) VALUES("Power Bowl","Soya","9.95","451");
INSERT INTO menu(item_name, price, calories) VALUES("Chill-out Bowl","9.95","652");
INSERT INTO menu(item_name, allergens, price, calories) VALUES("Tofu Scramble","Soya, Gluten and Wheat - GF Option","7.95","251");
INSERT INTO menu(item_name, allergens, price, calories) VALUES("Mushroom Fricasse","Gluten and Wheat - GF Option","6.95","351");
INSERT INTO menu(item_name, allergens, price, calories) VALUES("Berry Pancakes","Soya, Nuts, Gluten and Wheat - GF Option","7.95","451");
SELECT * FROM menu;

DESCRIBE customers;

#CREATING CUSTOMER RECORDS
INSERT INTO customers(cust_name, cust_num, address_l1, postcode) VALUES("Poppy", "07347284791", "Her memory foam bed by the door", "BD4 0RP");
INSERT INTO customers(cust_name, cust_num, address_l1, postcode) VALUES("Jordan", "07343984791", "Living it up in London", "NE23 1JJ");
INSERT INTO customers(cust_name, cust_num, address_l1, postcode) VALUES("Brandon", "07338572791", "Abandoned in Nationwide House", "SN3 1TX");
INSERT INTO customers(cust_name, cust_num, address_l1, postcode) VALUES("Steve", "07310824791", "A very posh village in Kent", "TN27 124");
INSERT INTO customers(cust_name, cust_num, address_l1, postcode) VALUES("James", "07936284791", "At his desk, facing away from the monitor", "SN4 1JS");
INSERT INTO customers(cust_name, cust_num, address_l1, postcode) VALUES("Harry", "07347000791", "Somewhere in a village that is not Swindon", "SN6 142");

#VIEWING TABLES
SELECT * FROM customers;
SELECT * FROM menu;

#UPDATING TABLES
UPDATE customers SET cust_name="Harvey" WHERE cust_id=6;
UPDATE menu SET calories="299" WHERE item_id=5;

#DELETING FROM RECORDS
DELETE FROM customers WHERE cust_id ="6";

#CREATING MORE RECORDS
INSERT INTO customers(cust_name, cust_num, address_l1, postcode) VALUES("Harvey", "07347000791", "Not somewhere in a village that is not Swindon", "SN6 142");
INSERT INTO menu(item_name, allergens, price, calories) VALUES("Soup of the Day","Gluten and Wheat - GF Option","4.95","312");

#UPDATING MENU
UPDATE menu SET available=FALSE WHERE item_id=5;
UPDATE menu SET available=FALSE WHERE item_id=2;

#UPDATING MENU
UPDATE menu SET item_des="Cursed yellow Jasmine toxin" WHERE item_id=5;
UPDATE menu SET item_des="A lovely salad spoilt with cursed green beans" WHERE item_id=2;

#CREATING ORDERS TABLE
CREATE TABLE orders(
order_id INT UNIQUE NOT NULL AUTO_INCREMENT,
order_date DATETIME NOT NULL,
cust_id INT NOT NULL,
order_notes VARCHAR(500) DEFAULT "N/A",
order_total DECIMAL(6,2),
PRIMARY KEY(order_id),
FOREIGN KEY(cust_id) REFERENCES customers(cust_id));

#CREATING ORDER ITEMS TABLE 
CREATE TABLE order_items(
orderi_id INT UNIQUE NOT NULL AUTO_INCREMENT,
order_id INT NOT NULL,
item_id INT NOT NULL,
quantity INT,
PRIMARY KEY(orderi_id), 
FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (item_id) REFERENCES menu(item_id));

#EDITING THE COLUMNS
show tables;
describe order_items;
ALTER TABLE orders 
ADD del_in_col VARCHAR(10) NOT NULL DEFAULT "Eat in", 
ADD pay_type VARCHAR(10) NOT NULL DEFAULT "Card", 
ADD ord_status VARCHAR(30);

#VIEWING THE TABLES
describe orders;
describe order_items;
show tables;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM menu;

#INSERTING IN ORDERS
INSERT INTO orders(order_date, cust_id) VALUES(current_timestamp,3),(current_timestamp,5);
INSERT INTO orders(order_date, cust_id) VALUES(current_timestamp,2);
INSERT INTO orders(order_date, cust_id) VALUES(current_timestamp, 4),(current_timestamp,3);
INSERT INTO order_items(order_id, item_id, quantity) VALUES("1", "2", "2"),("1","5","3"),("2","3","1"),("1","7","4"),("3","6","1");
INSERT INTO order_items(order_id, item_id, quantity) VALUES("3", "7", "4"),("5", "6","6"),("4","7","1");


#THIS IS NOT WORKING BUT IT FEELS PRETTY CLOSE (IF WE FORGET QUANTITY
ALTER TABLE order_items ADD orderl_price DECIMAL(6,2) NOT NULL;
# UPDATE order_items 
#SET orderl_price = (SELECT price FROM menu 
#WHERE order_items.item_id = menu.item_id);

SELECT price FROM menu;
SELECT price, item_id FROM menu;
SELECT * FROM MENU WHERE price > 5.00;
SELECT * FROM menu WHERE allergens LIKE "%Soya%";
SELECT * FROM customers WHERE cust_id > 2;
SELECT * FROM order_items ORDER BY order_id DESC LIMIT 3;
SELECT * FROM menu WHERE price!= 9.95;
SELECT * FROM customers WHERE cust_name LIKE "%y";
SELECT DISTINCT order_id FROM order_items;
SELECT * FROM customers ORDER BY cust_name DESC LIMIT 2;

SELECT AVG(price) FROM menu;
SELECT AVG(cust_num) FROM customers;

SELECT cust_id FROM orders WHERE order_id < 3;
SELECT cust_name FROM customers 
WHERE cust_id = (SELECT cust_id FROM orders WHERE order_id = (SELECT order_id FROM orders WHERE order_id > 3));

SELECT * FROM customers JOIN orders ON customers.cust_id=orders.cust_id;

SELECT menu.item_id, order_items.item_id, order_items.quantity, menu.price FROM menu JOIN order_items on order_items.item_id = menu.item_id;

#ALTER TABLE order_items ADD orderl_price DECIMAL(6,2) NOT NULL;
#SET orderl_price = price FROM
#(SELECT menu.item_id, order_items.item_id, order_items.quantity, menu.price 
#FROM menu 
#JOIN order_items on order_items.item_id = menu.item_id) 
#WHERE item_id =(SELECT item_id FROM order_items);
