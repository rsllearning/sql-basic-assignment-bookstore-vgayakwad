DROP DATABASE IF EXISTS onlineStore;
CREATE DATABASE onlineStore;

Use onlineStore;

-- #############################################################################
-- Create Tables
-- #############################################################################

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(100),
    email VARCHAR(150) UNIQUE
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    order_date DATE NOT NULL,

    FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id),

    FOREIGN KEY (product_id)
        REFERENCES Products(product_id)
);

-- #############################################################################
-- Populate the data
-- #############################################################################

INSERT INTO Customers
    (customer_id, customer_name, city, email)
VALUES
    (1, 'Rahul Sharma', 'Mumbai', 'rahul@example.com'),
    (2, 'Priya Patel', 'Pune', 'priya@example.com'),
    (3, 'Amit Verma', 'Delhi', 'amit@example.com'),
    (4, 'Sneha Kulkarni', 'Nagpur', 'sneha@example.com'),
    (5, 'Rohan Mehta', 'Ahmedabad', 'rohan@example.com'),
    (6, 'Neha Singh', 'Bengaluru', 'neha@example.com'),
    (7, 'Arjun Desai', 'Hyderabad', 'arjun@example.com'),
    (8, 'Kavita Joshi', 'Nashik', 'kavita@example.com'),
    (9, 'Vikram Rao', 'Chennai', 'vikram@example.com'),
    (10, 'Ananya Gupta', 'Kolkata', 'ananya@example.com');


INSERT INTO Products
    (product_id, product_name, category, price)
VALUES
    (101, 'Laptop', 'Electronics', 55000.00),
    (102, 'Smartphone', 'Electronics', 25000.00),
    (103, 'Headphones', 'Accessories', 2000.00),
    (104, 'Office Chair', 'Furniture', 7500.00),
    (105, 'Desk', 'Furniture', 12000.00),
    (106, 'Keyboard', 'Accessories', 1500.00),
    (107, 'Monitor', 'Electronics', 14000.00),
    (108, 'Backpack', 'Bags', 1800.00),
    (109, 'Water Bottle', 'Home', 500.00),
    (110, 'Notebook', 'Stationery', 100.00);

INSERT INTO Orders
    (order_id, customer_id, product_id, quantity, order_date)
VALUES
    (1001, 1, 101, 1, '2026-01-05'),
    (1002, 2, 103, 2, '2026-01-06'),
    (1003, 3, 102, 1, '2026-01-07'),
    (1004, 4, 110, 10, '2026-01-08'),
    (1005, 5, 104, 1, '2026-01-09'),
    (1006, 6, 106, 2, '2026-01-10'),
    (1007, 7, 107, 1, '2026-01-11'),
    (1008, 8, 108, 1, '2026-01-12'),
    (1009, 9, 109, 3, '2026-01-13'),
    (1010, 5, 105, 1, '2026-01-14'),
    (1011, 1, 102, 1, '2026-01-15'),
    (1012, 2, 110, 5, '2026-01-16'),
    (1013, 3, 106, 1, '2026-01-17'),
    (1014, 4, 103, 1, '2026-01-18'),
    (1015, 5, 101, 1, '2026-01-19'),
    (1016, 6, 109, 2, '2026-01-20'),
    (1017, 7, 104, 1, '2026-01-21'),
    (1018, 8, 107, 2, '2026-01-22'),
    (1019, 9, 108, 2, '2026-01-23'),
    (1020, 4, 105, 1, '2026-01-24');


-- Section 1: Advanced Joins
    -- Task 1: Display each customer along with the products they ordered.
    SELECT c.customer_name, p.product_name from Customers c 
        JOIN Orders o ON c.customer_id = o.customer_id
        JOIN Products p ON p.product_id = o.product_id;

    -- Task 2: Display all possible combinations of customers and products using a CROSS JOIN.
    SELECT c.customer_name, p.product_name from Customers c CROSS JOIN Products p;

    -- Task 3: Display all customers and their orders, including customers who have not placed any orders.
    SELECT c.customer_name, o.order_id, o.product_id, 0.quantity,o.order_date 
        FROM Customers c 
        LEFT JOIN Orders o 
        ON o.customer_id = c.customer_id;

-- Section 2: Subqueries
    -- Task 4: Find products priced above the average product price.
    
    -- Task 5: Display customers whose total purchase amount is greater than the average customer purchase amount.
    -- Task 6: Find the highest-priced product in each category using a correlated subquery.