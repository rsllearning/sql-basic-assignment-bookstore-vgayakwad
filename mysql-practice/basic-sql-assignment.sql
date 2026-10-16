DROP DATABASE IF EXISTS bookLibrary;
CREATE DATABASE bookLibrary;

USE bookLibrary;

CREATE TABLE authors (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL,
    country VARCHAR(50)
);

CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(100),
    author_id INT,
    category VARCHAR(50),
    price DECIMAL(10,2),
    published_year INT
);

INSERT INTO authors (author_id, author_name, country)
VALUES
    (1, 'J.K. Rowling', 'United Kingdom'),
    (2, 'George Orwell', 'United Kingdom'),
    (3, 'Paulo Coelho', 'Brazil'),
    (4, 'R.K. Narayan', 'India'),
    (5, 'Agatha Christie', 'United Kingdom');

INSERT INTO books
    (book_id, title, author_id, category, price, published_year)
VALUES
    (101, 'Harry Potter and the Philosopher''s Stone', 1, 'Fantasy', 800.00, 1997),
    (102, 'Harry Potter and the Chamber of Secrets', 1, 'Fantasy', 600.00, 1998),
    (103, 'Since 1984', 2, 'Dystopian Fiction', 500.00, 1949),
    (104, 'Animal Farm', 2, 'Political Fiction', 299.00, 1945),
    (105, 'The Alchemist', 3, 'Adventure', 350.00, 2021),
    (106, 'Brida', 3, 'Fantasy', 650.00, 1990),
    (107, 'Same Malgudi Days', 4, 'Short Stories', 280.00, 1943),
    (108, 'The Guide', 4, 'Fiction', 375.00, 1958),
    (109, 'Murder on the Orient Express', 5, 'Mystery', 450.00, 1934),
    (110, 'Server', 5, 'Programming', 900, 2024);

-- Section 1: Basic Queries
    -- Task 1: Display all books
    SELECT * from books;
    -- Task 2: Display only book title and price
    SELECT title, price from books;
    -- Task 3: Display the book title as Book Name and price as Book Price using column aliases.
    SELECT title as "Book Name", price as "Book Price" from books;
    -- Task 4: Display all unique book categories. 
    SELECT DISTINCT category FROM books;

-- Section 2: Filtering Data
    -- Task 5: Display books priced above ₹700.
    SELECT * from books where price > 700;
    -- Task 6: Display books priced between ₹500 and ₹800.
    SELECT * from books where price between 500 AND 800;
    -- Task 7: Display books that belong to the Programming category.
    SELECT * from books where category="Programming";
    -- Task 8: Display books whose titles start with the letter S.
    Select * from books where title LIKE "S%";
    -- Task 9: Display books published after 2020.
    Select * from books where published_year > 2020;

-- Section 3: Sorting and Limiting Results
    -- Task 10: Display books sorted by price in descending order.
    SELECT * from books ORDER BY price DESC;
    -- Task 11: Display the top 3 most expensive books.
    SELECT * from books ORDER BY price DESC LIMIT 3;

-- Section 4: Aggregate Functions
   -- Task 12: Find:
      -- Total number of books
      SELECT COUNT(*) as "Total Books" from books;
      -- Total price of all books
      SELECT SUM(price) as "Total Price of all books" from books;
      -- Average book price
      SELECT AVG(price) as "Avarage Price of all books" from books;
      -- Highest book price
      SELECT MAX(price) as "Maximum Book price" from books;
      -- Lowest book price
      SELECT MIN(price) as "Minimum Price of all books" from books;

-- Section 5: GROUP BY and HAVING
    -- Task 13: Display the average book price for each category.
    SELECT category, AVG(price) as "Avarage book Price" from books GROUP BY category;
    -- Task 14: Display only those categories whose average book price is greater than ₹650.
    SELECT category, AVG(price) as avgPrice  from books GROUP BY category HAVING avgPrice > 650;

-- Section 6: Joins
    -- Task 15: Display each book along with its author's name using an INNER JOIN.
    SELECT b.title, a.author_name from books b INNER JOIN authors a  where b.author_id=a.author_id;
    -- Task 16: Display all authors along with the books they have written using a LEFT JOIN.
    SELECT a.author_id, a.author_name, b.book_id, b.title FROM authors a LEFT JOIN books b ON a.author_id = b.author_id;
    -- Task 17: Display all books along with their author details using a RIGHT JOIN.
    SELECT a.author_id, a.author_name, b.book_id, b.title FROM authors a LEFT JOIN books b ON a.author_id = b.author_id;

-- Section 7: Data Manipulation
    -- Task 18: Insert a new book into the Books table.
    INSERT INTO books (book_id,title, author_id, category, price, published_year) VALUES(111, "THE PROGRAMMER", 11
0, "Coding", 10000, 2026);
    -- Task 19: Update the price of the book you inserted.
    UPDATE books SET PRICE=11000 where book_id=111;
    -- Task 20: Delete the book record that you inserted.
    DELETE from books where book_id=111;

-- Task 21: Create a new table named Publishers with the following columns:
-- publisher_id publisher_name country established_year
-- Apply the following constraints: PRIMARY KEY NOT NULL UNIQUE DEFAULT
   CREATE TABLE Publishers (publisher_id INT PRIMARY KEY, publisher_name VARCHAR(100) NOT NULL, country VARCHAR(50) DEFAULT "India", established_year INT );
   INSERT INTO Publishers (publisher_id, publisher_name, established_year) value (100, "Vivek Gayakwad", 2026);
   SELECT * FROM Publishers;