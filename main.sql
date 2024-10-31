-- Create customers table
CREATE TABLE CUSTOMERS (
  Customer_ID INT PRIMARY KEY,
  Customer_Name VARCHAR(255),
  Contact VARCHAR(255),
  Address VARCHAR(255),
  Order_ID INT,
  FOREIGN KEY (Order_ID) REFERENCES ORDERS(Order_ID)
);

--Insert values into customers table

INSERT INTO CUSTOMERS VALUES 
(0001,'Ann','098-111-2222','7321 Oakridge Drive, Springfield, VA 22152',1000),
(0002,'Bob', '098-222-3333','9872 Willow Creek Lane, Seattle, WA 98105',1001),
(0003,'Carl','098-333-4444','154 Elm Street, Boston, MA 02114',1002),
(0004,'Dave','099-855-5666','921 S. Creek Road, Houston, TX 77001',1003),
(0005,'Edith','098-999-8888','567 Maple Road, Chicago, IL 60611',1004),
(0006,'Fred','099-911-1333','982 Oak Avenue, San Francisco, CA 94105',1005),
(0007,'Gina','098-222-4444','123 Main Street, New York, NY 10001',1006),
(0008,'Harry','098-333-4444','890 Cedar Street, Los Angeles, CA 90046',1007),
(0009,'Irene','098-444-5555','456 Pine Street, San Diego, CA 92105',1008),
(0010,'Jack','098-555-6666','789 Oak Street, San Jose, CA 95118',1009);

-- Create orders table

CREATE TABLE ORDERS (
  Order_ID INT PRIMARY KEY,
  Customer_ID INT,
  Order_date DATE,
  Menu_ID INT,
  Staff_ID INT,
  FOREIGN KEY (Staff_ID) REFERENCES STAFF(Staff_ID),
  FOREIGN KEY (MENU_ID) REFERENCES MENU(MENU_ID),
  FOREIGN KEY (Customer_ID) REFERENCES CUSTOMERS(Customer_ID)
);

--Insert values into orders table
INSERT INTO ORDERS VALUES
(1000,0001,'2022-01-01',1,01),
(1001,0002,'2022-01-01',2,04),
(1002,0003,'2022-01-01',2,06),
(1003,0004,'2022-01-02',3,04),
(1004,0005,'2022-01-02',4,04),
(1005,0006,'2022-01-03',5,06),
(1006,0007,'2022-01-03',1,06),
(1007,0008,'2022-01-03',2,06),
(1008,0009,'2022-01-03',4,04),
(1009,0010,'2022-01-03',3,04);

-- Create menu table

CREATE TABLE MENU(
  Menu_ID INT PRIMARY KEY,
  Menu_Name VARCHAR(255),
  Price INT
);

--Insert values into meanu table
INSERT INTO MENU VALUES
(1,'Pizza',25),
(2,'Spaghetti',19),
(3,'Burger',15),
(4,'Coke',5),
(5,'Fries',10);

-- Create staff table
Create TABLE STAFF (
  Staff_ID INT PRIMARY KEY,
  Staff_Name VARCHAR(255),
  Position VARCHAR(255),
  Salary INT
);

--Insert values into staff table
INSERT INTO STAFF VALUES
(01,'Jane','Manager',50000),
(02,'John','Chef',15000),
(03,'Mary','Waiter',10000),
(04,'Tom','Cashier',10000),
(05,'Jack','Waiter',10000),
(06,'Sarah','Cashier',10000);

.mode table
.header on

--SELECT Every values in customers table

SELECT * FROM CUSTOMERS;

--Where caluse 

SELECT *
FROM ORDERS
WHERE Order_date between '2022-01-02' AND '2022-01-03';

--Aggregate function and group by
--Total sale between 2022-01-01 and 2022-01-03
SELECT Order_date,SUM(Price) AS Total_sale
FROM ORDERS
JOIN MENU
ON ORDERS.MENU_ID = MENU.MENU_ID
WHERE Order_date between '2022-01-01' AND '2022-01-03'
GROUP BY Order_date;

--Subquery
--Total sale and number of menu that customer order by staff's name tom
SELECT Menu_Name, COUNT(Menu_Name) AS Number_of_order,SUM(Price) AS Total_price
  FROM
  (SELECT *
  FROM ORDERS O
  JOIN MENU M
  ON O.Menu_ID = M.Menu_ID
  WHERE O.Staff_id = 04)
GROUP BY Menu_Name;

--with clause 
-- Top three menu that make the highest price
WITH Total_sale AS (
  SELECT Menu_Name, SUM(PRICE) AS Total_price
  FROM ORDERS O
  JOIN MENU M
  ON O.Menu_ID = M.Menu_ID
  GROUP BY Menu_Name
)
SELECT * 
FROM Total_sale
ORDER BY Total_price DESC
LIMIT 3;