create database Online_Booking_store;

use Online_Booking_store;

# Primary key
ALTER TABLE Books
ADD PRIMARY KEY (Book_ID);

ALTER TABLE Customers
ADD PRIMARY KEY (Customer_ID);

ALTER TABLE Orders
ADD PRIMARY KEY (Order_ID);

# Foregin key
ALTER TABLE Orders
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (Customer_ID)
REFERENCES Customers(Customer_ID);

ALTER TABLE Orders
ADD CONSTRAINT fk_orders_book
FOREIGN KEY (Book_ID)
REFERENCES Books(Book_ID);

# (1)Find sales by customer.
SELECT 
    Customer_ID,
    SUM(Total_Amount) AS Total_Sales
FROM Orders
GROUP BY Customer_ID
ORDER BY Total_Sales DESC;

# (2) Display order details with customer names.
SELECT
    O.Order_ID,
    C.Name,
    O.Order_Date,
    O.Quantity,
    O.Total_Amount
FROM Orders O
JOIN Customers C
    ON O.Customer_ID = C.Customer_ID;
    
#(3) Find all books that cost more than ₹500, sorted from highest to lowest price.
SELECT * 
FROM Books
WHERE Price > 1000
ORDER BY Price desc;

#(4)  Find all customers whose names start with the letter 'A'
SELECT * 
FROM Customers
WHERE Name LIKE 'A%';

#(5)List all orders that were placed in the last 30 days
SELECT * 
FROM Orders
WHERE Order_Date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

#(7)what is the total number of books available in the entire store catalog?
SELECT COUNT(Book_ID) AS Total_Books_Catalog 
FROM Books;

#(8)Show the total number of book quantities sold for each unique book ID.
SELECT Book_ID, SUM(Quantity) AS Total_Copies_Sold
FROM Orders
GROUP BY Book_ID;

#(9)Display the order details along with the specific Book Titles that were bought.
SELECT O.Order_ID, B.Title, O.Quantity, O.Total_Amount
FROM Orders O
JOIN Books B ON O.Book_ID = B.Book_ID;

#(10)Create a complete receipt report showing Order ID, Customer Name, and Book Title for every sale
SELECT O.Order_ID, C.Name AS Customer_Name, B.Title AS Book_Title, O.Total_Amount
FROM Orders O
JOIN Customers C ON O.Customer_ID = C.Customer_ID
JOIN Books B ON O.Book_ID = B.Book_ID;

#(11)Find customers who have spent a grand total of more than ₹2,00 across all their orders.
SELECT Customer_ID, SUM(Total_Amount) AS Total_Spent
FROM Orders
GROUP BY Customer_ID
HAVING Total_Spent > 200;