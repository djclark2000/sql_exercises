USE bestbuy;
/* joins: select all the computers from the products table:

using the products table and the categories table, return the product name and the category name */
SELECT products.Name AS 'Products', categories.Name AS 'Category'
FROM products 
INNER JOIN categories
ON categories.CategoryID = products.CategoryID
WHERE categories.Name = 'Computers';

/* joins: find all product names, product prices, and products ratings that have a rating of 5 */
SELECT products.Name, products.Price, reviews.Rating
FROM products
INNER JOIN reviews
ON products.ProductID = reviews.ProductID
WHERE reviews.Rating = 5; 


/* joins: find the employee with the most total quantity sold.  use the sum() function and group by */
SELECT CONCAT(e.FirstName, " ", e.LastName) AS Employee, SUM(s.Quantity) AS Total
FROM employees as e
INNER JOIN sales as s
ON e.EmployeeID = s.EmployeeID
GROUP BY e.EmployeeID
ORDER BY Total DESC
LIMIT 2;


/* joins: find the name of the department, and the name of the category for Appliances and Games */
SELECT d.Name AS Department, c.Name AS Category 
FROM categories AS c
INNER JOIN departments AS d
ON d.DepartmentID = c.DepartmentID
WHERE c.Name = "Appliances" OR c.Name = "Games"; 


/* joins: find the product name, total # sold, and total price sold,

 for Eagles: Hotel California --You may need to use SUM() */
 SELECT products.Name, products.ProductID FROM products;
 
 SELECT p.Name AS Item, SUM(s.Quantity), SUM(s.Quantity * s.PricePerUnit) AS Total
 FROM products AS p
 INNER JOIN sales AS s
 ON p.ProductID = s.ProductID
 GROUP BY s.ProductID
 HAVING p.Name LIKE '%Eagles: Hotel California%'; 
 

/* joins: find Product name, reviewer name, rating, and comment on the Visio TV. (only return for the lowest rating!) */

SELECT p.Name, r.Reviewer, r.Rating, r.Comment 
FROM products AS p
INNER JOIN reviews AS r
ON p.ProductID = r.ProductID
WHERE p.Name LIKE '%Visio%' AND r.Rating = 1; 

-- ------------------------------------------ Extra - May be difficult

/* Your goal is to write a query that serves as an employee sales report.

This query should return the employeeID, the employee's first and last name, the name of each product, how many of that product they sold */
SELECT e.EmployeeID, CONCAT(e.FirstName, " ", e.LastName) AS Employee, 
	p.Name AS Product, s.Quantity, s.Quantity * s.PricePerUnit AS 'Total Sold'
FROM employees AS e
INNER JOIN sales AS s
ON e.EmployeeID = s.EmployeeID
INNER JOIN products AS p
ON p.ProductID = s.ProductID
ORDER BY e.EmployeeID; 





-- Exercise Notes:
-- Look at the total quantity and cost of Products that have been sold
SELECT products.ProductID, products.Name, products.Price, sales.Quantity, sales.PricePerUnit * sales.Quantity AS Total 
FROM products
INNER JOIN sales
ON sales.ProductID = products.ProductID 
ORDER BY products.Name;


-- Look at Products that haven't been sold:
SELECT products.ProductID, products.Name, products.Price, sales.Quantity, sales.PricePerUnit * sales.Quantity AS Total 
FROM products
LEFT JOIN sales
ON sales.ProductID = products.ProductID 
WHERE sales.Quantity IS NULL
ORDER BY products.Name;

-- Look at product reviews:
SELECT p.ProductID, p.Name, r.Reviewer, r.Rating, r.Comment
FROM reviews AS r
INNER JOIN products AS p
ON p.ProductID = r.ProductID
ORDER BY r.Rating DESC; 

-- Look at employees and sales
SELECT e.EmployeeID, CONCAT(e.FirstName, " ", e.LastName) AS Name, p.Name AS Product, s.Quantity, s.PricePerUnit, s.Quantity * s.PricePerUnit AS Total 
FROM sales AS s
INNER JOIN employees as e
ON e.EmployeeID = s.EmployeeID
INNER JOIN products AS p
ON s.ProductID = p.ProductID
ORDER BY e.EmployeeID, p.ProductID; 
 
-- SELECT sales.EmployeeID, sales.SalesID FROM sales; 