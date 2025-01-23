Set serveroutput on; 
Drop Table Recommendations;
Drop Table Reviews;
Drop Table Invoices;
Drop Table Creditcards;
Drop Table Orders;
Drop Table Products;
Drop Table Productcategories;
Drop Table Customers;

DROP SEQUENCE customer_seq;
DROP SEQUENCE category_seq;
DROP SEQUENCE product_seq;
DROP SEQUENCE order_seq;
DROP SEQUENCE creditcard_seq;
DROP SEQUENCE invoice_seq;
DROP SEQUENCE review_seq;
DROP SEQUENCE recommendation_seq;


CREATE SEQUENCE customer_seq START WITH 101 INCREMENT BY 1;

CREATE SEQUENCE category_seq START WITH 201 INCREMENT BY 1;

CREATE SEQUENCE product_seq START WITH 301 INCREMENT BY 1;

CREATE SEQUENCE order_seq START WITH 401 INCREMENT BY 1;

CREATE SEQUENCE creditcard_seq START WITH 5017987534219076 INCREMENT BY 79;

CREATE SEQUENCE invoice_seq START WITH 601 INCREMENT BY 1;

CREATE SEQUENCE review_seq START WITH 701 INCREMENT BY 1;

CREATE SEQUENCE recommendation_seq START WITH 801 INCREMENT BY 1;

-- Customers table
CREATE TABLE Customers (
    Customerid INT,
    Cus_Fname VARCHAR(255),
    Cus_Lname VARCHAR(255),
    Cus_Email VARCHAR(255) UNIQUE,
    City VARCHAR(100),
    State VARCHAR(50),
    Zip VARCHAR(20),
    PRIMARY KEY (Customerid)
);

-- Product Categories table
CREATE TABLE Productcategories (
    Categoryid INT,
    Categoryname VARCHAR(100),
    Description VARCHAR(255),
    PRIMARY KEY (Categoryid)
);

-- Products table
CREATE TABLE Products (
    Productid INT ,
    Productname VARCHAR(255),
    Availablequantity INT,
    Unitprice FLOAT,
    Categoryid INT,
    PRIMARY KEY (Productid),
    FOREIGN KEY (Categoryid) REFERENCES Productcategories(Categoryid)
);

-- Orders table
CREATE TABLE Orders (
    Orderid INT ,
    Customerid INT,
    Productid INT,
    Quantity INT,
    Orderdate DATE,
    PRIMARY KEY (Orderid),
    FOREIGN KEY (Customerid) REFERENCES Customers(Customerid),
    FOREIGN KEY (Productid) REFERENCES Products(Productid)
);

-- Credit Cards table
CREATE TABLE Creditcards (
    Customerid INT,
    Creditcardnumber VARCHAR(20),
    Creditcardtype VARCHAR(20),
    Expirationyear INT,
    Expirationmonth INT,
    PRIMARY KEY (Creditcardnumber),
    FOREIGN KEY (Customerid) REFERENCES Customers(Customerid)
);

-- Invoices table
CREATE TABLE Invoices (
    Invoiceid INT ,
    Orderid INT,
    Customerid INT,
    Creditcardnumber VARCHAR(20),
    Amount FLOAT,
    PRIMARY KEY (Invoiceid),
    FOREIGN KEY (Orderid) REFERENCES Orders(Orderid),
    FOREIGN KEY (Customerid) REFERENCES Customers(Customerid),
    FOREIGN KEY (Creditcardnumber) REFERENCES Creditcards(Creditcardnumber)
);

-- Reviews table
CREATE TABLE Reviews (
    Reviewid INT ,
    Productid INT,
    Revieweremail VARCHAR(255),
    Starsgiven INT,
    Reviewtext VARCHAR(300),
    PRIMARY KEY (Reviewid),
    FOREIGN KEY (Productid) REFERENCES Products(Productid)
);

-- Recommendations table
-- Recommendations table
CREATE TABLE Recommendations (
    Recommendationid INT,
    Customerid INT,
    Recommendedproductid INT,
    Recommendationdate DATE,
    PRIMARY KEY (Recommendationid),
    FOREIGN KEY (Customerid) REFERENCES Customers(Customerid),
    FOREIGN KEY (Recommendedproductid) REFERENCES Products(Productid)
);

INSERT INTO Customers 
VALUES (customer_seq.NEXTVAL, 'Harshith', 'Martha', 'hmartha1@umbc.edu', 'Baltimore', 'Maryland', '21229');
INSERT INTO Customers 
VALUES (customer_seq.NEXTVAL, 'Rudraja', 'vansutre', 'rudrajav1@umbc.edu', 'Baltimore', 'Maryland', '21229');
INSERT INTO Customers 
VALUES (customer_seq.NEXTVAL, 'Jaswanth Ram', 'Nagabharava', 'jnagabh1@gmail.com', 'Baltimore', 'Maryland', '21229');
INSERT INTO Customers 
VALUES (customer_seq.NEXTVAL, 'Harsha', 'Kumbam', 'skumbam@umbc.edu', 'Baltimore', 'Maryland', '21229');
INSERT INTO Customers 
VALUES (customer_seq.NEXTVAL, 'Preet', 'Patel', 'preetp2@umbc.edu', 'Baltimore', 'Maryland', '21229');
select * from Customers ;

-- Insert values into Productcategories
INSERT INTO Productcategories (Categoryid, Categoryname, Description)
VALUES (category_seq.NEXTVAL, 'Electronics', 'Electronic devices and accessories');

INSERT INTO Productcategories (Categoryid, Categoryname, Description)
VALUES (category_seq.NEXTVAL, 'Clothing', 'Apparel and fashion accessories');

INSERT INTO Productcategories (Categoryid, Categoryname, Description)
VALUES (category_seq.NEXTVAL, 'Sports and Outdoors', 'Sporting goods and outdoor equipment');

INSERT INTO Productcategories (Categoryid, Categoryname, Description)
VALUES (category_seq.NEXTVAL, 'Books and Literature', 'Books and literary materials');

INSERT INTO Productcategories (Categoryid, Categoryname, Description)
VALUES (category_seq.NEXTVAL, 'Home and Furniture', 'Furniture and home decor');
SELECT * FROM Productcategories;

--Insert values into Products

INSERT INTO Products (Productid, Productname, Availablequantity, Unitprice, Categoryid)
VALUES (product_seq.NEXTVAL, 'Laptop', 50, 999.99, (SELECT Categoryid FROM Productcategories WHERE Categoryname = 'Electronics'));

INSERT INTO Products (Productid, Productname, Availablequantity, Unitprice, Categoryid)
VALUES (product_seq.NEXTVAL, 'Smartphone', 100, 499.99, (SELECT Categoryid FROM Productcategories WHERE Categoryname = 'Electronics'));

INSERT INTO Products (Productid, Productname, Availablequantity, Unitprice, Categoryid)
VALUES (product_seq.NEXTVAL, 'T-shirt', 200, 19.99, (SELECT Categoryid FROM Productcategories WHERE Categoryname = 'Clothing'));

INSERT INTO Products (Productid, Productname, Availablequantity, Unitprice, Categoryid)
VALUES (product_seq.NEXTVAL, 'Running Shoes', 75, 79.99, (SELECT Categoryid FROM Productcategories WHERE Categoryname = 'Sports and Outdoors'));

INSERT INTO Products (Productid, Productname, Availablequantity, Unitprice, Categoryid)
VALUES (product_seq.NEXTVAL, 'Coffee Table', 30, 149.99, (SELECT Categoryid FROM Productcategories WHERE Categoryname = 'Home and Furniture'));
SELECT * FROM Products;

-- Insert values into Orders
-- Assuming you have products with Productid values generated by the product_seq sequence
INSERT INTO Orders (Orderid, Customerid, Productid, Quantity, Orderdate)
VALUES (order_seq.NEXTVAL, 101, 301, 2, TO_DATE('2023-01-10', 'YYYY-MM-DD'));

INSERT INTO Orders (Orderid, Customerid, Productid, Quantity, Orderdate)
VALUES (order_seq.NEXTVAL, 102, 302, 3, TO_DATE('2023-01-15', 'YYYY-MM-DD'));

INSERT INTO Orders (Orderid, Customerid, Productid, Quantity, Orderdate)
VALUES (order_seq.NEXTVAL, 103, 303, 1, TO_DATE('2023-01-20', 'YYYY-MM-DD'));

INSERT INTO Orders (Orderid, Customerid, Productid, Quantity, Orderdate)
VALUES (order_seq.NEXTVAL, 104, 304, 2, TO_DATE('2023-01-25', 'YYYY-MM-DD'));

INSERT INTO Orders (Orderid, Customerid, Productid, Quantity, Orderdate)
VALUES (order_seq.NEXTVAL, 105, 305, 1, TO_DATE('2023-01-30', 'YYYY-MM-DD'));

-- Display the Orders table
SELECT * FROM Orders;

-- Insert values into Creditcards using the creditcard_seq sequence
-- Assuming you have customers with Customerid values generated by the customer_seq sequence
INSERT INTO Creditcards (Customerid, Creditcardnumber, Creditcardtype, Expirationyear, Expirationmonth)
VALUES (101, creditcard_seq.NEXTVAL, 'Visa', 2024, 12);

INSERT INTO Creditcards (Customerid, Creditcardnumber, Creditcardtype, Expirationyear, Expirationmonth)
VALUES (102, creditcard_seq.NEXTVAL, 'MasterCard', 2023, 8);

INSERT INTO Creditcards (Customerid, Creditcardnumber, Creditcardtype, Expirationyear, Expirationmonth)
VALUES (103, creditcard_seq.NEXTVAL, 'Discover', 2025, 5);

INSERT INTO Creditcards (Customerid, Creditcardnumber, Creditcardtype, Expirationyear, Expirationmonth)
VALUES (104, creditcard_seq.NEXTVAL, 'American Express', 2024, 11);

INSERT INTO Creditcards (Customerid, Creditcardnumber, Creditcardtype, Expirationyear, Expirationmonth)
VALUES (105, creditcard_seq.NEXTVAL, 'Visa', 2023, 7);

-- Display the Creditcards table
SELECT * FROM Creditcards;

-- Insert values into Invoices using existing Creditcardnumbers
-- Assuming you have orders with Orderid values generated by the order_seq sequence
INSERT INTO Invoices (Invoiceid, Orderid, Customerid, Creditcardnumber, Amount)
VALUES (1, 401, 101, (SELECT Creditcardnumber FROM Creditcards WHERE Customerid = 101), 150.75);

INSERT INTO Invoices (Invoiceid, Orderid, Customerid, Creditcardnumber, Amount)
VALUES (2, 402, 102, (SELECT Creditcardnumber FROM Creditcards WHERE Customerid = 102), 95.50);

INSERT INTO Invoices (Invoiceid, Orderid, Customerid, Creditcardnumber, Amount)
VALUES (3, 403, 103, (SELECT Creditcardnumber FROM Creditcards WHERE Customerid = 103), 200.25);

INSERT INTO Invoices (Invoiceid, Orderid, Customerid, Creditcardnumber, Amount)
VALUES (4, 404, 104, (SELECT Creditcardnumber FROM Creditcards WHERE Customerid = 104), 120.00);

INSERT INTO Invoices (Invoiceid, Orderid, Customerid, Creditcardnumber, Amount)
VALUES (5, 405, 105, (SELECT Creditcardnumber FROM Creditcards WHERE Customerid = 105), 80.50);

-- Display the Invoices table
SELECT * FROM Invoices;

--Insert values into Reviews table

INSERT INTO Reviews (Reviewid, Productid, Revieweremail, Starsgiven, Reviewtext)
VALUES (review_seq.nextval,301, 'reviewer1@gmail.com',4,'Good');
INSERT INTO Reviews (Reviewid, Productid, Revieweremail, Starsgiven, Reviewtext)
VALUES (review_seq.nextval,303, 'reviewer2@gmail.com',3,'Average');
INSERT INTO Reviews (Reviewid, Productid, Revieweremail, Starsgiven, Reviewtext)
VALUES (review_seq.nextval,302, 'reviewer3@gmail.com',5,'Excellent');
INSERT INTO Reviews (Reviewid, Productid, Revieweremail, Starsgiven, Reviewtext)
VALUES (review_seq.nextval,305, 'reviewer4@gmail.com',2,'Needs Improvement');
INSERT INTO Reviews (Reviewid, Productid, Revieweremail, Starsgiven, Reviewtext)
VALUES (review_seq.nextval,304, 'reviewer5@gmail.com',1,'Issues with product');
select * from Reviews;

--Insert Values into Recommendations
INSERT INTO Recommendations (Recommendationid, Customerid, Recommendedproductid, Recommendationdate)
values (recommendation_seq.nextval,(SELECT Customerid FROM Customers WHERE Cus_Email = 'hmartha1@umbc.edu'), (SELECT Productid FROM Products WHERE Productname = 'Smartphone'), sysdate);
INSERT INTO Recommendations (Recommendationid, Customerid, Recommendedproductid, Recommendationdate)
values (recommendation_seq.nextval,(SELECT Customerid FROM Customers WHERE Cus_Email = 'skumbam@umbc.edu'), (SELECT Productid FROM Products WHERE Productname = 'Laptop'), sysdate);
INSERT INTO Recommendations (Recommendationid, Customerid, Recommendedproductid, Recommendationdate)
values (recommendation_seq.nextval,(SELECT Customerid FROM Customers WHERE Cus_Email = 'rudrajav1@umbc.edu'), (SELECT Productid FROM Products WHERE Productname = 'T-shirt'), sysdate);
INSERT INTO Recommendations (Recommendationid, Customerid, Recommendedproductid, Recommendationdate)
values (recommendation_seq.nextval,(SELECT Customerid FROM Customers WHERE Cus_Email = 'preetp2@umbc.edu'), (SELECT Productid FROM Products WHERE Productname = 'Coffee Table'), sysdate);
INSERT INTO Recommendations (Recommendationid, Customerid, Recommendedproductid, Recommendationdate)
values (recommendation_seq.nextval,(SELECT Customerid FROM Customers WHERE Cus_Email = 'jnagabh1@gmail.com'), (SELECT Productid FROM Products WHERE Productname = 'Running Shoes'), sysdate);
select * from Recommendations;

-- Member 1 

CREATE OR REPLACE PROCEDURE Add_Customer(
    p_Fname VARCHAR2,
    p_Lname VARCHAR2,
    p_Email VARCHAR2,
    p_City VARCHAR2,
    p_State VARCHAR2,
    p_Zip VARCHAR2
) AS
BEGIN
    INSERT INTO Customers (Customerid, Cus_Fname, Cus_Lname, Cus_Email, City, State, Zip)
    VALUES (customer_seq.NEXTVAL, p_Fname, p_Lname, p_Email, p_City, p_State, p_Zip);
    
    COMMIT; -- Commit the transaction
    DBMS_OUTPUT.PUT_LINE('Customer added successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error adding customer: ' || SQLERRM);
        ROLLBACK; -- Rollback the transaction in case of an error
END Add_Customer;
/

BEGIN
    Add_Customer('Ram', 'Martha', 'ram_martha@gmail.com', 'Baltimore', 'Maryland', '21229');
END;
/

select * from customers; 

CREATE OR REPLACE PROCEDURE Show_all_customers_in_state(
    p_State VARCHAR2
) AS
BEGIN
    FOR customer_rec IN (
        SELECT
            c.Cus_Fname || ' ' || c.Cus_Lname AS Customer_Name,
            c.Cus_Email AS Email,
            c.City || ', ' || c.State || ' ' || c.Zip AS Address,
            cc.Creditcardnumber AS Credit_Card_Number,
            cc.Creditcardtype AS Credit_Card_Type
        FROM
            Customers c
            JOIN Creditcards cc ON c.Customerid = cc.Customerid
        WHERE
            c.State = p_State
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Customer Name: ' || customer_rec.Customer_Name);
        DBMS_OUTPUT.PUT_LINE('Email: ' || customer_rec.Email);
        DBMS_OUTPUT.PUT_LINE('Address: ' || customer_rec.Address);
        DBMS_OUTPUT.PUT_LINE('Credit Card Number: ' || customer_rec.Credit_Card_Number);
        DBMS_OUTPUT.PUT_LINE('Credit Card Type: ' || customer_rec.Credit_Card_Type);
        DBMS_OUTPUT.PUT_LINE('--------------------------');
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END Show_all_customers_in_state;

/
BEGIN
    Show_all_customers_in_state('Maryland');
END;
/

-- Helper function to get CustomerID based on email
CREATE OR REPLACE FUNCTION Get_CustomerID(p_Email VARCHAR2) RETURN INT AS
    v_CustomerID INT;
BEGIN
    SELECT Customerid INTO v_CustomerID
    FROM Customers
    WHERE Cus_Email = p_Email;
    
    RETURN v_CustomerID;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    WHEN OTHERS THEN
        RAISE;
END Get_CustomerID;
/

-- Procedure to add a new credit card
CREATE OR REPLACE PROCEDURE Add_CreditCard(
    p_Email VARCHAR2,
    p_CreditCardNumber VARCHAR2,
    p_CreditCardType VARCHAR2,
    p_ExpirationYear INT,
    p_ExpirationMonth INT
) AS
    v_CustomerID INT;
BEGIN
    -- Use the helper function to get CustomerID
    v_CustomerID := Get_CustomerID(p_Email);

    IF v_CustomerID IS NOT NULL THEN
        -- Insert new credit card
        INSERT INTO Creditcards (Customerid, Creditcardnumber, Creditcardtype, Expirationyear, Expirationmonth)
        VALUES (v_CustomerID, p_CreditCardNumber, p_CreditCardType, p_ExpirationYear, p_ExpirationMonth);

        COMMIT; -- Commit the transaction
        DBMS_OUTPUT.PUT_LINE('Credit card added successfully.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Customer with email ' || p_Email || ' not found.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error adding credit card: ' || SQLERRM);
        ROLLBACK; -- Rollback the transaction in case of an error
END Add_CreditCard;
/

BEGIN
    Add_CreditCard('hmartha1@umbc.edu', '1234567812345678', 'Visa', 2024, 12);
END;
/
select * from Creditcards; 

-- Procedure to generate the report of customers with expiring credit cards
CREATE OR REPLACE PROCEDURE Report_Cards_Expire IS
BEGIN
  -- Query to retrieve customer information for expiring credit cards
  FOR customer_rec IN (
    SELECT
      C.Cus_Lname AS Last_Name,
      C.Cus_Fname AS First_Name,
      CC.Creditcardnumber AS Credit_Card_Number,
      CC.Creditcardtype AS Credit_Card_Type,
      CC.Expirationyear AS Expiration_Year,
      CC.Expirationmonth AS Expiration_Month
    FROM
      Customers C
      JOIN Creditcards CC ON C.Customerid = CC.Customerid
    WHERE
      TO_DATE(CC.Expirationyear || LPAD(CC.Expirationmonth, 2, '0'), 'YYYYMM')
      BETWEEN ADD_MONTHS(SYSDATE, -2) AND SYSDATE
  ) LOOP
    -- Output the customer information
    DBMS_OUTPUT.PUT_LINE(
      'Last Name: ' || customer_rec.Last_Name ||
      ', First Name: ' || customer_rec.First_Name ||
      ', Credit Card #: ' || customer_rec.Credit_Card_Number ||
      ', Credit Card Type: ' || customer_rec.Credit_Card_Type ||
      ', Expiration Year: ' || customer_rec.Expiration_Year ||
      ', Expiration Month: ' || customer_rec.Expiration_Month
    );
  END LOOP;
END Report_Cards_Expire;
/

-- Execute the Report_Cards_Expire procedure
BEGIN
  Report_Cards_Expire;
END;
/

select * from productcategories; 

select * from products; 

-- Member 2 

-- Procedure to add a new category to the Category table
CREATE OR REPLACE PROCEDURE Add_Category(
    p_Categoryid NUMBER,
    p_Categoryname VARCHAR2,
    p_Description VARCHAR2
) IS
BEGIN
    INSERT INTO Productcategories (Categoryid, Categoryname, Description)
    VALUES (p_Categoryid, p_Categoryname, p_Description);

    COMMIT; -- Committing the transaction
    DBMS_OUTPUT.PUT_LINE('Category added successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK; -- Rolling back the transaction in case of an error
END Add_Category;
/

-- Example usage
BEGIN
    Add_Category(category_seq.NEXTVAL, 'Accessories', 'Fashion Accessories');
END;
/

select * from Productcategories; 

CREATE OR REPLACE FUNCTION Get_Category_ID(p_Categoryname VARCHAR2) RETURN NUMBER IS
    v_Categoryid NUMBER;
BEGIN
    -- Retrieve the Category ID based on the Category name
    SELECT Categoryid INTO v_Categoryid
    FROM Productcategories
    WHERE Categoryname = p_Categoryname;

    RETURN v_Categoryid;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Category not found.');
        RETURN NULL; -- You can choose an appropriate value for handling not found
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN NULL; -- You can choose an appropriate value for handling other errors
END Get_Category_ID;
/

CREATE OR REPLACE PROCEDURE Add_Product(
    p_Productid NUMBER,
    p_Productname VARCHAR2,
    p_Availablequantity NUMBER,
    p_Unitprice FLOAT,
    p_Categoryname VARCHAR2
) IS
    v_Categoryid NUMBER;
BEGIN
    -- Use the helper function to get the Category ID
    v_Categoryid := Get_Category_ID(p_Categoryname);

    IF v_Categoryid IS NOT NULL THEN
        -- Insert new product
        INSERT INTO Products (Productid, Productname, Availablequantity, Unitprice, Categoryid)
        VALUES (p_Productid, p_Productname, p_Availablequantity, p_Unitprice, v_Categoryid);

        COMMIT; -- Committing the transaction
        DBMS_OUTPUT.PUT_LINE('Product added successfully.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Error: Category not found.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK; -- Rolling back the transaction in case of an error
END Add_Product;
/

-- Example usage
BEGIN
    Add_Product(
        product_seq.NEXTVAL,
        'New Laptop',
        20,
        1299.99,
        'Electronics'
    );
END;
/

select * from products; 

delete from products where productid = '307'; 


CREATE OR REPLACE PROCEDURE Update_Inventory(
    p_ProductID NUMBER,
    p_Quantity NUMBER
) AS
    v_CurrentQuantity NUMBER;
BEGIN
    -- Get the current available quantity of the product
    SELECT Availablequantity INTO v_CurrentQuantity
    FROM Products
    WHERE Productid = p_ProductID;

    -- Check if there is enough quantity to fulfill the order
    IF v_CurrentQuantity >= p_Quantity THEN
        -- Update the inventory after the order
        UPDATE Products
        SET Availablequantity = v_CurrentQuantity - p_Quantity
        WHERE Productid = p_ProductID;

        COMMIT; -- Commit the transaction
        DBMS_OUTPUT.PUT_LINE('Inventory updated successfully.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Error: Insufficient quantity in inventory.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Product not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK; -- Rollback the transaction in case of an error
END Update_Inventory;
/

-- Example usage
BEGIN
    Update_Inventory(p_ProductID => 301, p_Quantity => 5);
END;

--Report Inventory
CREATE OR REPLACE PROCEDURE Report_Inventory IS
BEGIN
    FOR category_rec IN (
        SELECT
            pc.Categoryname AS Category_Name,
            SUM(p.Availablequantity) AS Available_Quantity
        FROM
            Productcategories pc
            LEFT JOIN Products p ON pc.Categoryid = p.Categoryid
        GROUP BY
            pc.Categoryname
        ORDER BY
            pc.Categoryname
    ) LOOP
        -- Output the category name and available quantity
        DBMS_OUTPUT.PUT_LINE('Category: ' || category_rec.Category_Name);
        DBMS_OUTPUT.PUT_LINE('Available Quantity: ' || category_rec.Available_Quantity);
        DBMS_OUTPUT.PUT_LINE('--------------------------');
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END Report_Inventory;
/

BEGIN
    Report_Inventory;
END;
/

--Member-3

/*-- Helper function to get ProductID based on product name
CREATE OR REPLACE FUNCTION Get_ProductID(p_Productname VARCHAR2) RETURN NUMBER AS
    v_ProductID NUMBER;
BEGIN
    -- Retrieve the ProductID based on the Product name
    SELECT Productid INTO v_ProductID
    FROM Products
    WHERE Productname = p_Productname;

    RETURN v_ProductID;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Product not found.');
        RETURN NULL; -- You can choose an appropriate value for handling not found
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN NULL; -- You can choose an appropriate value for handling other errors
END Get_ProductID;
/

-- Procedure to place an order
CREATE OR REPLACE PROCEDURE Place_Order(
    p_CustomerEmail VARCHAR2,
    p_ProductName VARCHAR2,
    p_Quantity NUMBER,
    p_CreditCardNumber VARCHAR2
) AS
    v_CustomerID INT;
    v_ProductID INT;
BEGIN
    -- Use helper function to get Customer ID
    v_CustomerID := Get_CustomerID(p_CustomerEmail);

    IF v_CustomerID IS NOT NULL THEN
        -- Use helper function to get Product ID
        v_ProductID := Get_ProductID(p_ProductName);

        IF v_ProductID IS NOT NULL THEN
            -- Call the Update_Inventory procedure from Member 2
            Update_Inventory(p_ProductID, p_Quantity);

            -- Call the Invoice_Customer procedure from Member 4
            Invoice_Customer(
                p_Orderdate => SYSDATE,
                p_CustomerEmail => p_CustomerEmail,
                p_CreditCardNumber => p_CreditCardNumber,
                p_Amount => (p_Quantity * (SELECT Unitprice FROM Products WHERE Productid = v_ProductID))
            );

            DBMS_OUTPUT.PUT_LINE('Order placed successfully.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error: Product not found.');
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Error: Customer not found.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK; -- Rolling back the transaction in case of an error
END Place_Order;
/




-- Example usage
BEGIN
    Place_Order(
        p_CustomerEmail => 'hmartha1@umbc.edu',
        p_ProductName => 'New Laptop',
        p_Quantity => 2,
        p_CreditCardNumber => '1234567812345678'
    );
END;
/
*/

--Show_orders
-- Show_Orders Procedure
CREATE OR REPLACE PROCEDURE Show_Orders IS
BEGIN
    FOR order_rec IN (
        SELECT
            c.Cus_Fname || ' ' || c.Cus_Lname AS Customer_Name,
            p.Productname AS Product_Name,
            o.Quantity AS Quantity_Ordered,
            (o.Quantity * p.Unitprice) AS Amount_Charged
        FROM
            Orders o
            JOIN Customers c ON o.Customerid = c.Customerid
            JOIN Products p ON o.Productid = p.Productid
    ) LOOP
        -- Output order details
        DBMS_OUTPUT.PUT_LINE('Customer Name: ' || order_rec.Customer_Name);
        DBMS_OUTPUT.PUT_LINE('Product Name: ' || order_rec.Product_Name);
        DBMS_OUTPUT.PUT_LINE('Quantity Ordered: ' || order_rec.Quantity_Ordered);
        DBMS_OUTPUT.PUT_LINE('Amount Charged: ' || order_rec.Amount_Charged);
        DBMS_OUTPUT.PUT_LINE('--------------------------');
    END LOOP;

    -- Additional line showing the grand total of the number of all orders
    DECLARE
        v_GrandTotal NUMBER;
    BEGIN
        SELECT SUM(o.Quantity * p.Unitprice)
        INTO v_GrandTotal
        FROM Orders o
        JOIN Products p ON o.Productid = p.Productid;

        DBMS_OUTPUT.PUT_LINE('Grand Total of All Orders: ' || v_GrandTotal);
    END;
END Show_Orders;
/

-- Example usage
BEGIN
    Show_Orders;
END;
/



--Member-4
-- Helper function to find the Order ID based on Order date
CREATE OR REPLACE FUNCTION Get_OrderID(p_Orderdate DATE) RETURN INT AS
    v_OrderID INT;
BEGIN
    SELECT Orderid INTO v_OrderID
    FROM Orders
    WHERE Orderdate = p_Orderdate;

    RETURN v_OrderID;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Order not found.');
        RETURN NULL; -- You can choose an appropriate value for handling not found
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN NULL; -- You can choose an appropriate value for handling other errors
END Get_OrderID;
/

-- Invoice_Customer Procedure
CREATE OR REPLACE PROCEDURE Invoice_Customer(
    p_Orderdate DATE,
    p_CustomerEmail VARCHAR2,
    p_CreditCardNumber VARCHAR2,
    p_Amount FLOAT
) AS
    v_OrderID INT;
    v_CustomerID INT;
BEGIN
    -- Use helper function to get Order ID
    v_OrderID := Get_OrderID(p_Orderdate);

    IF v_OrderID IS NOT NULL THEN
        -- Use helper function to get Customer ID
        v_CustomerID := Get_CustomerID(p_CustomerEmail);

        IF v_CustomerID IS NOT NULL THEN
            -- Insert new invoice
            INSERT INTO Invoices (Invoiceid, Orderid, Customerid, Creditcardnumber, Amount)
            VALUES (invoice_seq.NEXTVAL, v_OrderID, v_CustomerID, p_CreditCardNumber, p_Amount);

            COMMIT; -- Committing the transaction
            DBMS_OUTPUT.PUT_LINE('Invoice added successfully.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error: Customer not found.');
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Error: Order not found.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK; -- Rolling back the transaction in case of an error
END Invoice_Customer;
/

-- Example usage
BEGIN
    Invoice_Customer(
        p_Orderdate => TO_DATE('2023-01-10', 'YYYY-MM-DD'),
        p_CustomerEmail => 'hmartha1@umbc.edu',
        p_CreditCardNumber => '1234567812345678',
        p_Amount => 150.75
    );
END;
/
select * from Invoices;