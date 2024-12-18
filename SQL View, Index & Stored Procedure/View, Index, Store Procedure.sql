-- Bước 1: Tạo cơ sở dữ liệu demo
CREATE DATABASE demo;
USE demo;

-- Bước 2: Tạo bảng Products
CREATE TABLE Products (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    productCode VARCHAR(50) UNIQUE,
    productName VARCHAR(100),
    productPrice DECIMAL(10,2),
    productAmount INT,
    productDescription TEXT,
    productStatus VARCHAR(20)
);

-- Chèn một số dữ liệu mẫu cho bảng Products
INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
VALUES ('P001', 'Product A', 100.00, 10, 'Description A', 'Available'),
		('P002', 'Product B', 200.00, 20, 'Description B', 'Out of Stock'),
         ('P003', 'Product C', 150.00, 15, 'Description C', 'Available');

-- Bước 3: Tạo Index
-- Tạo Unique Index sử dụng cột productCode
CREATE UNIQUE INDEX idx_productCode ON Products (productCode);

-- Tạo Composite Index sử dụng 2 cột productName và productPrice
CREATE INDEX idx_productName_price ON Products (productName, productPrice);

-- Sử dụng EXPLAIN để xem hiệu quả truy vấn
EXPLAIN SELECT * FROM Products WHERE productCode = 'P001';
EXPLAIN SELECT * FROM Products WHERE productName = 'Product A' AND productPrice = 100.00;

-- Bước 4: Tạo View
-- Tạo View
CREATE VIEW view_Products AS
SELECT productCode, productName, productPrice, productStatus FROM Products;

-- Sửa đổi View
CREATE OR REPLACE VIEW view_Products AS
SELECT productCode, productName, productPrice, productStatus FROM Products WHERE productStatus = 'Available';

-- Xoá View
DROP VIEW IF EXISTS view_Products;

-- Bước 5: Tạo Stored Procedure
-- 1. Lấy tất cả thông tin sản phẩm
DELIMITER //
  CREATE PROCEDURE getAllProducts()
  BEGIN
      SELECT * FROM Products;
  END //
DELIMITER ;

-- 2. Thêm một sản phẩm mới  
DELIMITER //
CREATE PROCEDURE addProduct (
    IN pCode VARCHAR(50),
    IN pName VARCHAR(100),
    IN pPrice DECIMAL(10,2),
    IN pAmount INT,
    IN pDescription TEXT,
    IN pStatus VARCHAR(20)
)
BEGIN
    INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
    VALUES (pCode, pName, pPrice, pAmount, pDescription, pStatus);
END //
DELIMITER ;

-- 3. Sửa thông tin sản phẩm theo Id
DELIMITER //
  CREATE PROCEDURE updateProduct (
      IN pId INT,
      IN pName VARCHAR(100),
      IN pPrice DECIMAL(10,2),
      IN pAmount INT,
      IN pDescription TEXT,
      IN pStatus VARCHAR(20)
  )
  BEGIN
      UPDATE Products
      SET productName = pName,
          productPrice = pPrice,
          productAmount = pAmount,
          productDescription = pDescription,
          productStatus = pStatus
      WHERE Id = pId;
  END //
DELIMITER ;

-- 4. Xoá sản phẩm theo Id
DELIMITER //
CREATE PROCEDURE deleteProduct (
    IN pId INT
)
BEGIN
    DELETE FROM Products WHERE Id = pId;
END //
DELIMITER ;
