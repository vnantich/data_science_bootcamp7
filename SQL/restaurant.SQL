-- restaurant database
--at least 5 tables
--write 3-5 queries
--1x WITH
--1x SUBQUERY
--1x aggregate function

.open restaurant.db
.mode column
.mode box
.header on

--CREATE TABLE & INSERT INTO
  --table 1
CREATE TABLE customers (
  customer_id INT UNIQUE,
  firstname TEXT,
  lastname TEXT,
  phone INT,
  email TEXT,
  membership_id INT
);

INSERT INTO customers VALUES
  (1, 'Neo', 'Lee', '0813788651', 'neo.lee@gmail.com', 3),
  (2, 'Jennie', 'Kim', '0934611887', 'jennie.kim@gmail.com', 1),
  (3, 'Jisoo', 'Black', '0947833619', 'jisoo.black@gmail.com', 2),
  (4, 'Lisa', 'Pink', '0838124331', 'lisa.pink@gmail.com', 3),
  (5, 'Ken', 'Smith', '0967451925', 'ken.smith@gmail.com', 2),
  (6, 'John', 'Wick', '0846812110', 'john.wick@gmail.com', 1),
  (7, 'Selena', 'Anne', '0867544978', 'selena.anne@gmail.com', 2),
  (8, 'Ken', 'Luis', '0951328451', 'ken.luis@outlook.com', 3);

  --table 2
CREATE TABLE memberships (
  membership_id INT UNIQUE,
  membership_level TEXT,
  membership_discount REAL
);

INSERT INTO memberships VALUES
  (1, 'Bronze', 2.5),
  (2, 'Silver', 5),
  (3, 'Gold', 10);

  --table 3
CREATE TABLE menu (
  menu_id INT UNIQUE,
  menu_name TEXT,
  category TEXT,
  price INT
);

INSERT INTO menu VALUES
  (1, 'Tempura Udon', 'Cold Udon', 260),
  (2, 'Salmon & Ikura Udon', 'Cold Udon', 320),
  (3, 'Wagyu Udon', 'Cold Udon', 245),
  (4, 'Mentaiko Cream Udon', 'Hot Udon', 300),
  (5, 'Wagyu Hot Udon', 'Hot Udon', 245),
  (6, 'Tofu Udon', 'Hot Udon', 180),
  (7, 'Tempura Hot Udon', 'Hot Udon', 260),
  (8, 'Wagyu Yaki Udon', 'Yaki Udon', 260),
  (9, 'Chicken Yaki Udon', 'Yaki Udon', 220),
  (10, 'Matcha Ice Cream', 'Dessert', 55),
  (11, 'Hokkaido Milk Ice Cream', 'Dessert', 55);

  --table 4
CREATE TABLE payment_methods (
  payment_method_id INT UNIQUE,
  payment_method_types TEXT,
  payment_method_commission REAL
);

INSERT INTO payment_methods VALUES
  (1, 'Cash', 0),
  (2, 'QR', 0),
  (3, 'Credit Card', 2.5);

  --table 5
CREATE TABLE orders (
  order_id INT,
  order_date DATE,
  menu_id INT,
  quantity INT
);

INSERT INTO orders VALUES 
  (1, '2023-09-25', 4, 1),
  (1, '2023-09-25', 11, 1),
  (2, '2023-09-25', 5, 2),
  (2, '2023-09-25', 1, 1),
  (2, '2023-09-25', 4, 1),
  (3, '2023-09-25', 2, 1),
  (4, '2023-09-25', 2, 1),
  (5, '2023-09-25', 7, 1),
  (6, '2023-09-25', 3, 1),
  (7, '2023-09-25', 6, 2),
  (8, '2023-09-25', 8, 1),
  (8, '2023-09-25', 9, 1),
  (9, '2023-09-25', 4, 2),
  (10, '2023-09-25', 4, 2);

--table 6
CREATE TABLE invoices (
    invoice_id INT UNIQUE,
    order_id INT,
    customer_id INT,
    payment_method_id INT
);

INSERT INTO invoices VALUES 
  (1, 1, 1, 3),
  (2, 2, 6, 1),
  (3, 4, NULL, 2),
  (4, 3, 3, 2),
  (5, 5, NULL, 2),
  (6, 6, NULL, 2),
  (7, 8, 4, 1),
  (8, 7, 2, 2),
  (9, 9, 7, 2),
  (10, 10, 5, 2);

SELECT * FROM customers;
SELECT * FROM memberships;
SELECT * FROM menu;
SELECT * FROM payment_methods;
SELECT * FROM orders;
SELECT * FROM invoices;

--WRITE 3-5 QUERIES, 1 WITH CLAUSE, 1 SUBQUERY, 1 AGGREATE FUNCTION
  
.print "Question_1 : How many customers are there in each membership level?"

SELECT 
	m.membership_level, 
	COUNT(c.customer_id) AS total_customers
FROM memberships AS m
LEFT JOIN customers AS c 
ON m.membership_id = c.membership_id
GROUP BY m.membership_level;

.print "Question_2 : What is the highest price on the menu?"

SELECT 
  menu_name, 
  category, 
  price
FROM menu
WHERE price = (SELECT MAX(price) FROM menu);

.print "Question_3 : Which menu is the best seller?"

SELECT 
  menu.menu_id, 
  menu.menu_name, 
  SUM(orders.quantity) AS total_quantity
FROM orders
JOIN menu ON orders.menu_id = menu.menu_id
GROUP BY menu.menu_id, menu.menu_name
ORDER BY total_quantity DESC
LIMIT 1;

.print "Question_4 : By subtracting the member discount, how can I determine the total revenue from each invoice?"

WITH Invoice_Total_Revenue AS (
  SELECT i.invoice_id, i.order_id, i.customer_id,
         SUM(o.quantity * m.price) AS total_revenue
  FROM invoices AS i
  JOIN orders AS o ON i.order_id = o.order_id
  JOIN menu m ON o.menu_id = m.menu_id
  GROUP BY i.invoice_id, i.order_id, i.customer_id
),
Customer_Membership_Discount AS (
  SELECT i.invoice_id, i.customer_id, m.membership_discount
  FROM invoices AS i
  JOIN customers AS c 
  ON i.customer_id = c.customer_id
  JOIN memberships AS m 
  ON c.membership_id = m.membership_id
)
SELECT 
	itr.invoice_id, 
  itr.order_id, 
  itr.customer_id, 
  (itr.total_revenue * (1 - COALESCE(cmd.membership_discount, 0) / 100)) AS total_revenue_after_discount
FROM Invoice_Total_Revenue AS itr
LEFT JOIN Customer_Membership_Discount AS cmd 
ON itr.invoice_id = cmd.invoice_id;
