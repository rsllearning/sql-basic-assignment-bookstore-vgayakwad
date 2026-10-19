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
    price DECIMAL(10, 2) NOT NULL,
    created_date DATE
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
    (product_id, product_name, category, price, created_date)
VALUES
    (101, 'Laptop', 'Electronics', 55000.00, NOW()),
    (102, 'Smartphone', 'Electronics', 25000.00, NOW()),
    (103, 'Headphones', 'Accessories', 2000.00, NOW()),
    (104, 'Office Chair', 'Furniture', 7500.00, NOW()),
    (105, 'Desk', 'Furniture', 12000.00, '2024-01-18'),
    (106, 'Keyboard', 'Accessories', 1500.00, NOW()),
    (107, 'Monitor', 'Electronics', 14000.00, '2024-05-18'),
    (108, 'Backpack', 'Bags', 1800.00, NOW()),
    (109, 'Water Bottle', 'Home', 500.00, NOW()),
    (110, 'Notebook', 'Stationery', 100.00, NOW());

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
    SELECT * from Products where (SELECT AVG(p.price) from Products p) <price;
    -- Task 5: Display customers whose total purchase amount is greater than the average customer purchase amount.
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(p.price * o.quantity) AS total_purchase
    FROM Customers c
    JOIN Orders o
        ON c.customer_id = o.customer_id
    JOIN Products p
        ON o.product_id = p.product_id
    GROUP BY c.customer_id, c.customer_name
    HAVING SUM(p.price * o.quantity) > (
        SELECT AVG(customer_total)
        FROM (
            SELECT SUM(p2.price * o2.quantity) AS customer_total
            FROM Orders o2
            JOIN Products p2
                ON o2.product_id = p2.product_id
            GROUP BY o2.customer_id
        ) AS customer_totals
    );
    -- Task 6: Find the highest-priced product in each category using a correlated subquery.
    SELECT
    p.product_id,
    p.product_name,
    p.category,
    p.price
    FROM Products p
    WHERE p.price = (
        SELECT MAX(p2.price)
        FROM Products p2
        WHERE p2.category = p.category
    );

-- Section 3: Set Operations
    -- Task 7: Combine products from two different categories using UNION.
    SELECT * from Products WHERE category = "Electronics" UNION SELECT * FROM Products WHERE category = "Furniture";
    -- Task 8: Write MySQL alternatives for INTERSECT and EXCEPT using INNER JOIN and LEFT JOIN.
    SELECT DISTINCT c.customer_id from Customers c INNER JOIN Orders o where o.customer_id = c.customer_id;
    SELECT c.customer_id from Customers c LEFT JOIN Orders o ON o.customer_id = c.customer_id WHERE o.customer_id IS NULL;

-- Section 4: Window Functions
    -- Task 9: Rank products by price within each category.
    SELECT
    product_id,
    product_name,
    category,
    price,
    RANK() OVER (
        PARTITION BY category
        ORDER BY price DESC
    ) AS price_rank
    FROM Products;
    -- Task 10: Display the previous product price (LAG) and a running total of product prices using window functions.
    SELECT * , SUM(price) OVER (PARTITION BY category ORDER BY price DESC) AS running_sum, LAG(price) OVER (partition by category)  FROM Products;

-- Section 5: Common Table Expressions (CTEs)
    -- Task 11: Create a CTE to display customers whose total purchase amount is above the average.
    WITH CustomerTotals AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(p.price * o.quantity) AS total_purchase
    FROM Customers c
    JOIN Orders o
        ON c.customer_id = o.customer_id
    JOIN Products p
        ON o.product_id = p.product_id
    GROUP BY c.customer_id, c.customer_name
    )
    SELECT
        customer_id,
        customer_name,
        total_purchase
    FROM CustomerTotals
    WHERE total_purchase > (
        SELECT AVG(total_purchase)
        FROM CustomerTotals
    );
    -- Task 12: Create a recursive CTE to generate a sequence of numbers from 1 to 10.
    WITH RECURSIVE table_1 AS (SELECT 1 as num UNION ALL SELECT num+1 from table_1 where num < 10) SELECT * from table_1;

-- Section 6: Views
     -- Task 13: Create a view that displays products priced above ₹1,000 and retrieve data from the view.
     CREATE VIEW product_view AS (SELECT * from Products where price > 1000); SELECT * from product_view;

-- Section 7: Indexes and Query Performance
    -- Task 14: Create an index on the category column of the Products table.
    CREATE INDEX category_index ON Products(category);
    SHOW INDEX from Products;
    -- Task 15: Use EXPLAIN to analyze a query that filters products by category.
    EXPLAIN SELECT * FROM Products WHERE product_id = 102;

-- Section 9: Transactions
    -- Task 18: Write a transaction that updates a product's price and demonstrate the use of COMMIT and ROLLBACK.
    DELIMITER //
    CREATE PROCEDURE IncreasePrice(
        IN id INT,
        IN addPrice INT
    )
    BEGIN
        START TRANSACTION;

        UPDATE Products
        SET price = price + addPrice
        WHERE product_id = id;

        IF addPrice < 0 THEN
            ROLLBACK;
        ELSE
            COMMIT;
        END IF;
    END //

    DELIMITER ;
    SELECT * from Products where product_id=102;
    CALL IncreasePrice(102, -100);
    SELECT * from Products where product_id=102;
    CALL IncreasePrice(102, 100);
    SELECT * from Products where product_id=102;


-- Section 10: SQL Triggers
    -- Task 19: Create a trigger that automatically records new orders in an Order_Audit table whenever a new order is inserted.
    CREATE TABLE Order_Audit (id INT PRIMARY KEY, state  VARCHAR(50));

    DELIMITER //

    CREATE TRIGGER addAudit
    AFTER INSERT ON Orders
    FOR EACH ROW
    BEGIN
        INSERT INTO ORDER_AUDIT (id, state)
        VALUES (
            NEW.order_id,
            CONCAT('New order added with id ', NEW.order_id)
        );
    END //

    DELIMITER ;

    SELECT * FROM Order_Audit;

    INSERT INTO Orders(order_id, customer_id, product_id, quantity, order_date) values (1021, 10, 104, 2, '2026-10-19');

    SELECT * FROM Order_Audit;

    INSERT INTO Orders(order_id, customer_id, product_id, quantity, order_date) values (1022, 10, 104, 2, '2026-10-19');
    
    SELECT * FROM Order_Audit;


-- Section 11: Performance Tuning
    -- Task 20: Optimize the queries by applying SQL performance tuning best practices:
        -- eg:
        -- SELECT DISTINCT *
        -- FROM Products
        -- WHERE YEAR(created_date) = 2024
        -- AND category = 'Electronics';
        -- Apply the following improvements:
        -- 1. Avoid SELECT *.
        -- 2. Remove unnecessary DISTINCT.
        -- 3. Avoid functions on indexed columns.
        -- 4. Use an index-friendly query.
    -- Optimized Query:
    SELECT product_id, product_name, category, price, created_date FROM Products 
        WHERE created_date >= '2024-01-01'
        AND created_date < '2025-01-01'
        AND category = 'Electronics';