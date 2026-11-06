-- E-commerce Database Project
-- Companion implementation based on the COMP122 group project document.
-- Sample records are fictional and use reserved example.com email addresses.
-- Password values are dummy placeholders only; this project does not implement authentication.
-- Oracle SQL | Run in a clean schema.

CREATE TABLE USERS (
    user_id NUMBER,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) NOT NULL,
    password VARCHAR2(100) NOT NULL,
    phone VARCHAR2(20),
    address VARCHAR2(150),
    status VARCHAR2(20) NOT NULL,
    CONSTRAINT pk_users PRIMARY KEY (user_id),
    CONSTRAINT uq_users_email UNIQUE (email),
    CONSTRAINT chk_users_status CHECK (status IN ('Active', 'Inactive'))
);

CREATE TABLE CATEGORIES (
    category_id NUMBER,
    category_name VARCHAR2(100) NOT NULL,
    CONSTRAINT pk_categories PRIMARY KEY (category_id),
    CONSTRAINT uq_categories_name UNIQUE (category_name)
);

CREATE TABLE VENDORS (
    vendor_id NUMBER,
    vendor_name VARCHAR2(100) NOT NULL,
    contact_name VARCHAR2(100) NOT NULL,
    phone VARCHAR2(20),
    email VARCHAR2(100) NOT NULL,
    address VARCHAR2(150),
    status VARCHAR2(20) NOT NULL,
    CONSTRAINT pk_vendors PRIMARY KEY (vendor_id),
    CONSTRAINT uq_vendors_email UNIQUE (email),
    CONSTRAINT chk_vendors_status CHECK (status IN ('Active', 'Inactive'))
);

CREATE TABLE PRODUCTS (
    product_id NUMBER,
    product_name VARCHAR2(100) NOT NULL,
    price NUMBER(10,2) NOT NULL,
    category_id NUMBER NOT NULL,
    vendor_id NUMBER NOT NULL,
    CONSTRAINT pk_products PRIMARY KEY (product_id),
    CONSTRAINT chk_products_price CHECK (price > 0),
    CONSTRAINT fk_products_category FOREIGN KEY (category_id) REFERENCES CATEGORIES(category_id),
    CONSTRAINT fk_products_vendor FOREIGN KEY (vendor_id) REFERENCES VENDORS(vendor_id)
);

CREATE TABLE ORDERS (
    order_id NUMBER,
    user_id NUMBER NOT NULL,
    order_date DATE NOT NULL,
    total_amount NUMBER(10,2) NOT NULL,
    shipping_status VARCHAR2(30) NOT NULL,
    CONSTRAINT pk_orders PRIMARY KEY (order_id),
    CONSTRAINT chk_orders_total CHECK (total_amount >= 0),
    CONSTRAINT chk_orders_shipping_status CHECK (shipping_status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled')),
    CONSTRAINT fk_orders_user FOREIGN KEY (user_id) REFERENCES USERS(user_id)
);

CREATE TABLE ORDER_ITEMS (
    order_item_id NUMBER,
    order_id NUMBER NOT NULL,
    product_id NUMBER NOT NULL,
    quantity NUMBER NOT NULL,
    CONSTRAINT pk_order_items PRIMARY KEY (order_item_id),
    CONSTRAINT chk_order_items_quantity CHECK (quantity > 0),
    CONSTRAINT fk_order_items_order FOREIGN KEY (order_id) REFERENCES ORDERS(order_id),
    CONSTRAINT fk_order_items_product FOREIGN KEY (product_id) REFERENCES PRODUCTS(product_id)
);

CREATE TABLE WISHLIST (
    wishlist_id NUMBER,
    user_id NUMBER NOT NULL,
    product_id NUMBER NOT NULL,
    CONSTRAINT pk_wishlist PRIMARY KEY (wishlist_id),
    CONSTRAINT fk_wishlist_user FOREIGN KEY (user_id) REFERENCES USERS(user_id),
    CONSTRAINT fk_wishlist_product FOREIGN KEY (product_id) REFERENCES PRODUCTS(product_id)
);

CREATE TABLE RETURNS (
    return_id NUMBER,
    order_item_id NUMBER NOT NULL,
    refund_amount NUMBER(10,2) NOT NULL,
    return_status VARCHAR2(30) NOT NULL,
    CONSTRAINT pk_returns PRIMARY KEY (return_id),
    CONSTRAINT chk_returns_refund CHECK (refund_amount >= 0),
    CONSTRAINT chk_returns_status CHECK (return_status IN ('Requested', 'Approved', 'Rejected', 'Refunded')),
    CONSTRAINT fk_returns_order_item FOREIGN KEY (order_item_id) REFERENCES ORDER_ITEMS(order_item_id)
);

-- Ten fictional users. Passwords are placeholders and must never be used for login.
INSERT ALL
  INTO USERS VALUES (1,'Alex','Sample','user01@example.com','DEMO_ONLY_NOT_A_PASSWORD','5550102001','100 Example Street','Active')
  INTO USERS VALUES (2,'Taylor','Demo','user02@example.com','DEMO_ONLY_NOT_A_PASSWORD','5550102002','200 Sample Avenue','Active')
  INTO USERS VALUES (3,'Jordan','Fiction','user03@example.com','DEMO_ONLY_NOT_A_PASSWORD','5550102003','300 Demo Road','Inactive')
  INTO USERS VALUES (4,'Casey','Placeholder','user04@example.com','DEMO_ONLY_NOT_A_PASSWORD','5550102004','400 Fiction Lane','Active')
  INTO USERS VALUES (5,'Riley','Example','user05@example.com','DEMO_ONLY_NOT_A_PASSWORD','5550102005','500 Sample Street','Active')
  INTO USERS VALUES (6,'Morgan','Demo','user06@example.com','DEMO_ONLY_NOT_A_PASSWORD','5550102006','600 Example Avenue','Inactive')
  INTO USERS VALUES (7,'Avery','Sample','user07@example.com','DEMO_ONLY_NOT_A_PASSWORD','5550102007','700 Demo Boulevard','Active')
  INTO USERS VALUES (8,'Quinn','Fiction','user08@example.com','DEMO_ONLY_NOT_A_PASSWORD','5550102008','800 Placeholder Road','Active')
  INTO USERS VALUES (9,'Jamie','Example','user09@example.com','DEMO_ONLY_NOT_A_PASSWORD','5550102009','900 Sample Lane','Active')
  INTO USERS VALUES (10,'Drew','Placeholder','user10@example.com','DEMO_ONLY_NOT_A_PASSWORD','5550102010','110 Example Street','Inactive')
SELECT 1 FROM DUAL;

INSERT ALL
  INTO CATEGORIES VALUES (1,'Hair') INTO CATEGORIES VALUES (2,'Skin Care')
  INTO CATEGORIES VALUES (3,'Makeup') INTO CATEGORIES VALUES (4,'Accessories')
  INTO CATEGORIES VALUES (5,'Electronics') INTO CATEGORIES VALUES (6,'Clothing')
  INTO CATEGORIES VALUES (7,'Shoes') INTO CATEGORIES VALUES (8,'Bags')
  INTO CATEGORIES VALUES (9,'Wigs') INTO CATEGORIES VALUES (10,'Tools')
SELECT 1 FROM DUAL;

INSERT ALL
  INTO VENDORS VALUES (1,'BeautyCo','Contact One','5550103001','vendor01@example.com','100 Example Street','Active')
  INTO VENDORS VALUES (2,'Glow Ltd','Contact Two','5550103002','vendor02@example.com','200 Sample Avenue','Active')
  INTO VENDORS VALUES (3,'HairHub','Contact Three','5550103003','vendor03@example.com','300 Demo Road','Active')
  INTO VENDORS VALUES (4,'Style Inc','Contact Four','5550103004','vendor04@example.com','400 Fiction Lane','Active')
  INTO VENDORS VALUES (5,'Trend Co','Contact Five','5550103005','vendor05@example.com','500 Sample Street','Active')
  INTO VENDORS VALUES (6,'FashionX','Contact Six','5550103006','vendor06@example.com','600 Example Avenue','Active')
  INTO VENDORS VALUES (7,'LuxStore','Contact Seven','5550103007','vendor07@example.com','700 Demo Boulevard','Active')
  INTO VENDORS VALUES (8,'UrbanWear','Contact Eight','5550103008','vendor08@example.com','800 Placeholder Road','Active')
  INTO VENDORS VALUES (9,'TechWorld','Contact Nine','5550103009','vendor09@example.com','900 Sample Lane','Active')
  INTO VENDORS VALUES (10,'EliteShop','Contact Ten','5550103010','vendor10@example.com','110 Example Street','Active')
SELECT 1 FROM DUAL;

INSERT ALL
  INTO PRODUCTS VALUES (1,'Wig',100,9,1) INTO PRODUCTS VALUES (2,'Cream',20,2,2)
  INTO PRODUCTS VALUES (3,'Lipstick',15,3,3) INTO PRODUCTS VALUES (4,'Bag',50,8,4)
  INTO PRODUCTS VALUES (5,'Phone',500,5,9) INTO PRODUCTS VALUES (6,'Dress',80,6,5)
  INTO PRODUCTS VALUES (7,'Shoes',60,7,6) INTO PRODUCTS VALUES (8,'Mirror',25,10,7)
  INTO PRODUCTS VALUES (9,'Hair Oil',30,1,3) INTO PRODUCTS VALUES (10,'Clip',10,4,8)
SELECT 1 FROM DUAL;

INSERT ALL
  INTO ORDERS VALUES (1,1,DATE '2026-01-10',120,'Pending')
  INTO ORDERS VALUES (2,2,DATE '2026-01-12',50,'Shipped')
  INTO ORDERS VALUES (3,3,DATE '2026-02-03',70,'Delivered')
  INTO ORDERS VALUES (4,4,DATE '2026-02-18',30,'Pending')
  INTO ORDERS VALUES (5,5,DATE '2026-03-05',90,'Delivered')
  INTO ORDERS VALUES (6,6,DATE '2026-03-20',200,'Cancelled')
  INTO ORDERS VALUES (7,7,DATE '2026-04-02',150,'Shipped')
  INTO ORDERS VALUES (8,8,DATE '2026-04-14',60,'Pending')
  INTO ORDERS VALUES (9,9,DATE '2026-05-01',40,'Delivered')
  INTO ORDERS VALUES (10,10,DATE '2026-05-11',110,'Pending')
SELECT 1 FROM DUAL;

INSERT ALL
  INTO ORDER_ITEMS VALUES (1,1,1,2) INTO ORDER_ITEMS VALUES (2,2,2,1)
  INTO ORDER_ITEMS VALUES (3,3,3,3) INTO ORDER_ITEMS VALUES (4,4,4,1)
  INTO ORDER_ITEMS VALUES (5,5,5,1) INTO ORDER_ITEMS VALUES (6,6,6,2)
  INTO ORDER_ITEMS VALUES (7,7,7,1) INTO ORDER_ITEMS VALUES (8,8,8,2)
  INTO ORDER_ITEMS VALUES (9,9,9,1) INTO ORDER_ITEMS VALUES (10,10,10,3)
SELECT 1 FROM DUAL;

INSERT ALL
  INTO WISHLIST VALUES (1,1,1) INTO WISHLIST VALUES (2,2,2)
  INTO WISHLIST VALUES (3,3,3) INTO WISHLIST VALUES (4,4,4)
  INTO WISHLIST VALUES (5,5,5) INTO WISHLIST VALUES (6,6,6)
  INTO WISHLIST VALUES (7,7,7) INTO WISHLIST VALUES (8,8,8)
  INTO WISHLIST VALUES (9,9,9) INTO WISHLIST VALUES (10,10,10)
SELECT 1 FROM DUAL;

INSERT ALL
  INTO RETURNS VALUES (1,1,50,'Approved') INTO RETURNS VALUES (2,2,20,'Requested')
  INTO RETURNS VALUES (3,3,30,'Refunded') INTO RETURNS VALUES (4,4,10,'Rejected')
  INTO RETURNS VALUES (5,5,60,'Approved') INTO RETURNS VALUES (6,6,40,'Requested')
  INTO RETURNS VALUES (7,7,25,'Refunded') INTO RETURNS VALUES (8,8,15,'Approved')
  INTO RETURNS VALUES (9,9,35,'Rejected') INTO RETURNS VALUES (10,10,45,'Approved')
SELECT 1 FROM DUAL;

-- Basic table checks
SELECT * FROM USERS;
SELECT * FROM CATEGORIES;
SELECT * FROM VENDORS;
SELECT * FROM PRODUCTS;
SELECT * FROM ORDERS;
SELECT * FROM ORDER_ITEMS;
SELECT * FROM WISHLIST;
SELECT * FROM RETURNS;

-- Search products by category
SELECT p.product_id, p.product_name, p.price, c.category_name
FROM PRODUCTS p
JOIN CATEGORIES c ON p.category_id = c.category_id
WHERE c.category_name = 'Hair';

-- Shopping cart / order line detail
SELECT o.order_id, p.product_name, oi.quantity, p.price,
       (oi.quantity * p.price) AS subtotal
FROM ORDERS o
JOIN ORDER_ITEMS oi ON o.order_id = oi.order_id
JOIN PRODUCTS p ON oi.product_id = p.product_id
WHERE o.order_id = 1;

-- Register a fictional demo user, mark inactive, and verify.
INSERT INTO USERS VALUES (11,'Sam','Demo','user11@example.com','DEMO_ONLY_NOT_A_PASSWORD','5550102011','120 Placeholder Street','Active');
UPDATE USERS SET status = 'Inactive' WHERE user_id = 11;
SELECT * FROM USERS WHERE user_id = 11;

-- Shipping status lookup
SELECT order_id, shipping_status FROM ORDERS WHERE order_id = 1;

-- Vendors and the products they supply
SELECT v.vendor_id, v.vendor_name, p.product_name
FROM VENDORS v
JOIN PRODUCTS p ON v.vendor_id = p.vendor_id
ORDER BY v.vendor_id;

-- Monthly sales summary
SELECT TO_CHAR(order_date, 'YYYY-MM') AS sales_month,
       SUM(total_amount) AS total_sales
FROM ORDERS
GROUP BY TO_CHAR(order_date, 'YYYY-MM')
ORDER BY sales_month;

-- Most popular product(s), including ties
SELECT p.product_name, SUM(oi.quantity) AS total_quantity
FROM ORDER_ITEMS oi
JOIN PRODUCTS p ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(oi.quantity) = (
    SELECT MAX(total_qty)
    FROM (SELECT SUM(quantity) AS total_qty FROM ORDER_ITEMS GROUP BY product_id)
);

-- Categorize customers by recorded order totals
SELECT u.user_id, u.first_name, u.last_name,
       SUM(o.total_amount) AS total_spent,
       CASE WHEN SUM(o.total_amount) >= 200 THEN 'Premium'
            WHEN SUM(o.total_amount) >= 100 THEN 'Regular'
            ELSE 'Occasional' END AS customer_category
FROM USERS u
JOIN ORDERS o ON u.user_id = o.user_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_spent DESC;

-- List a user's wishlist
SELECT u.first_name, u.last_name, p.product_name
FROM WISHLIST w
JOIN USERS u ON w.user_id = u.user_id
JOIN PRODUCTS p ON w.product_id = p.product_id
WHERE u.user_id = 1;

-- Return and refund status report
SELECT r.return_id, p.product_name, r.refund_amount, r.return_status
FROM RETURNS r
JOIN ORDER_ITEMS oi ON r.order_item_id = oi.order_item_id
JOIN PRODUCTS p ON oi.product_id = p.product_id
ORDER BY r.return_id;

COMMIT;
