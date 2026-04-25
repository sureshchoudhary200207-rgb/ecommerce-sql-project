CREATE DATABASE IF NOT EXISTS ecommerce_db;

CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL,
    parent_category VARCHAR(100)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(150) NOT NULL,
    category_id INT,
    brand VARCHAR(100),
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    created_at DATE,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(15),
    city VARCHAR(100),
    state VARCHAR(100),
    registered_on DATE,
    gender ENUM('Male', 'Female', 'Other')
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE NOT NULL,
    delivery_date DATE,
    status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled', 'Returned'),
    total_amount DECIMAL(10, 2),
    shipping_city VARCHAR(100),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    discount_percent DECIMAL(5, 2) DEFAULT 0,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    payment_date DATE,
    payment_method ENUM('Credit Card', 'Debit Card', 'UPI', 'Net Banking', 'Cash on Delivery'),
    amount_paid DECIMAL(10, 2),
    payment_status ENUM('Success', 'Failed', 'Refunded'),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    customer_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text VARCHAR(500),
    review_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO categories (category_name, parent_category) VALUES
('Electronics', NULL),
('Mobile Phones', 'Electronics'),
('Laptops', 'Electronics'),
('Fashion', NULL),
('Men Clothing', 'Fashion'),
('Women Clothing', 'Fashion'),
('Footwear', 'Fashion'),
('Home & Kitchen', NULL);

INSERT INTO products (product_name, category_id, brand, price, stock_quantity, created_at) VALUES
('iPhone 14', 2, 'Apple', 79999.00, 50, '2023-01-10'),
('Samsung Galaxy S23', 2, 'Samsung', 54999.00, 80, '2023-01-15'),
('Dell Inspiron 15', 3, 'Dell', 62999.00, 30, '2023-02-01'),
('HP Pavilion x360', 3, 'HP', 57499.00, 25, '2023-02-10'),
('Men Casual Shirt', 5, 'Arrow', 999.00, 200, '2023-03-05'),
('Women Kurti', 6, 'Biba', 1299.00, 150, '2023-03-10'),
('Nike Running Shoes', 7, 'Nike', 4999.00, 100, '2023-03-20'),
('Adidas Sneakers', 7, 'Adidas', 3999.00, 90, '2023-03-25'),
('Mixer Grinder', 8, 'Philips', 3499.00, 60, '2023-04-01'),
('Air Fryer', 8, 'Instant Pot', 5999.00, 40, '2023-04-15');

INSERT INTO customers (full_name, email, phone, city, state, registered_on, gender) VALUES
('Rahul Mehta', 'rahul@gmail.com', '9876543210', 'Mumbai', 'Maharashtra', '2023-01-20', 'Male'),
('Priya Sharma', 'priya@gmail.com', '9812345678', 'Pune', 'Maharashtra', '2023-02-05', 'Female'),
('Arjun Singh', 'arjun@gmail.com', '9898765432', 'Delhi', 'Delhi', '2023-02-18', 'Male'),
('Sneha Rao', 'sneha@gmail.com', '9765432109', 'Bangalore', 'Karnataka', '2023-03-01', 'Female'),
('Manish Joshi', 'manish@gmail.com', '9754321098', 'Hyderabad', 'Telangana', '2023-03-15', 'Male'),
('Kavita Nair', 'kavita@gmail.com', '9743210987', 'Chennai', 'Tamil Nadu', '2023-04-02', 'Female'),
('Deepak Verma', 'deepak@gmail.com', '9732109876', 'Jaipur', 'Rajasthan', '2023-04-20', 'Male'),
('Anita Kulkarni', 'anita@gmail.com', '9721098765', 'Pune', 'Maharashtra', '2023-05-01', 'Female');

INSERT INTO orders (customer_id, order_date, delivery_date, status, total_amount, shipping_city) VALUES
(1, '2023-06-01', '2023-06-05', 'Delivered', 79999.00, 'Mumbai'),
(2, '2023-06-03', '2023-06-07', 'Delivered', 5998.00, 'Pune'),
(3, '2023-06-05', '2023-06-10', 'Delivered', 62999.00, 'Delhi'),
(4, '2023-06-08', NULL, 'Cancelled', 4999.00, 'Bangalore'),
(5, '2023-06-10', '2023-06-15', 'Delivered', 54999.00, 'Hyderabad'),
(6, '2023-06-12', '2023-06-18', 'Delivered', 9498.00, 'Chennai'),
(7, '2023-06-15', NULL, 'Shipped', 3499.00, 'Jaipur'),
(8, '2023-06-18', '2023-06-22', 'Delivered', 1299.00, 'Pune'),
(1, '2023-07-01', '2023-07-05', 'Delivered', 4999.00, 'Mumbai'),
(2, '2023-07-10', NULL, 'Returned', 57499.00, 'Pune');

INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percent) VALUES
(1, 1, 1, 79999.00, 0),
(2, 6, 2, 1299.00, 0),
(2, 8, 1, 3999.00, 0),
(3, 3, 1, 62999.00, 0),
(4, 7, 1, 4999.00, 0),
(5, 2, 1, 54999.00, 5),
(6, 7, 1, 4999.00, 10),
(6, 8, 1, 3999.00, 10),
(7, 9, 1, 3499.00, 0),
(8, 6, 1, 1299.00, 0),
(9, 7, 1, 4999.00, 0),
(10, 4, 1, 57499.00, 0);

INSERT INTO payments (order_id, payment_date, payment_method, amount_paid, payment_status) VALUES
(1, '2023-06-01', 'Credit Card', 79999.00, 'Success'),
(2, '2023-06-03', 'UPI', 5998.00, 'Success'),
(3, '2023-06-05', 'Net Banking', 62999.00, 'Success'),
(4, '2023-06-08', 'Debit Card', 4999.00, 'Refunded'),
(5, '2023-06-10', 'Credit Card', 54999.00, 'Success'),
(6, '2023-06-12', 'UPI', 9498.00, 'Success'),
(7, '2023-06-15', 'Cash on Delivery', 3499.00, 'Success'),
(8, '2023-06-18', 'UPI', 1299.00, 'Success'),
(9, '2023-07-01', 'Credit Card', 4999.00, 'Success'),
(10, '2023-07-10', 'Debit Card', 57499.00, 'Refunded');

INSERT INTO reviews (product_id, customer_id, rating, review_text, review_date) VALUES
(1, 1, 5, 'Amazing phone, worth every rupee!', '2023-06-10'),
(3, 3, 4, 'Good laptop, fast performance', '2023-06-15'),
(2, 5, 4, 'Great value for money', '2023-06-20'),
(7, 6, 3, 'Decent shoes but sizing runs small', '2023-06-25'),
(6, 2, 5, 'Beautiful kurti, great fabric', '2023-06-28'),
(8, 6, 4, 'Comfortable and stylish', '2023-06-30'),
(9, 7, 5, 'Works perfectly, very quiet', '2023-07-05'),
(4, 2, 2, 'Build quality could be better', '2023-07-15');

SELECT 
    c.category_name,
    SUM(oi.quantity * oi.unit_price) AS Total_Revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status != 'Cancelled'
GROUP BY c.category_name
ORDER BY Total_Revenue DESC;

SELECT 
    p.product_name,
    p.brand,
    SUM(oi.quantity) AS Units_Sold,
    SUM(oi.quantity * oi.unit_price) AS Revenue_Generated
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status NOT IN ('Cancelled', 'Returned')
GROUP BY p.product_name, p.brand
ORDER BY Units_Sold DESC
LIMIT 5;

SELECT 
    c.full_name AS Customer,
    c.city,
    COUNT(o.order_id) AS Total_Orders,
    SUM(o.total_amount) AS Total_Spent,
    ROUND(AVG(o.total_amount), 2) AS Avg_Order_Value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status NOT IN ('Cancelled', 'Returned')
GROUP BY c.full_name, c.city
ORDER BY Total_Spent DESC;

SELECT 
    YEAR(o.order_date) AS Year,
    MONTHNAME(o.order_date) AS Month,
    COUNT(o.order_id) AS Total_Orders,
    SUM(o.total_amount) AS Monthly_Revenue
FROM orders o
WHERE o.status NOT IN ('Cancelled', 'Returned')
GROUP BY YEAR(o.order_date), MONTH(o.order_date), MONTHNAME(o.order_date)
ORDER BY YEAR(o.order_date), MONTH(o.order_date);

SELECT 
    payment_method,
    COUNT(*) AS Total_Transactions,
    SUM(amount_paid) AS Total_Amount,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM payments), 2) AS Usage_Percent
FROM payments
WHERE payment_status = 'Success'
GROUP BY payment_method
ORDER BY Total_Transactions DESC;

SELECT 
    p.product_name,
    p.brand,
    COUNT(r.review_id) AS Total_Reviews,
    ROUND(AVG(r.rating), 1) AS Avg_Rating
FROM products p
LEFT JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.product_name, p.brand
ORDER BY Avg_Rating DESC;

SELECT 
    shipping_city AS City,
    COUNT(*) AS Total_Orders,
    SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END) AS Cancelled,
    SUM(CASE WHEN status = 'Returned' THEN 1 ELSE 0 END) AS Returned,
    ROUND((SUM(CASE WHEN status IN ('Cancelled','Returned') THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) AS Loss_Rate_Percent
FROM orders
GROUP BY shipping_city
ORDER BY Loss_Rate_Percent DESC;

SELECT 
    p.product_name,
    p.brand,
    p.stock_quantity,
    p.price
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;