create database DemoDB;

use DemoDB;

create table products(
		id int primary key auto_increment,
        pro_code varchar(50),
        pro_name varchar(50),
        pro_price double,
        pro_amount int,
        pro_des varchar(100),
        pro_status boolean
);

INSERT INTO Products (pro_code, pro_name, pro_price, pro_amount, pro_des, pro_status)
VALUES 
('P001', 'Laptop Dell XPS 13', 25000000, 10, 'Laptop mỏng nhẹ, hiệu suất cao', 1),
('P002', 'Chuột Logitech M330', 450000, 50, 'Chuột không dây yên tĩnh', 1),
('P003', 'Bàn phím cơ AKKO 3068', 1200000, 20, 'Bàn phím cơ mini layout 65%', 1),
('P004', 'Màn hình LG 24 inch', 3500000, 15, 'Màn hình IPS Full HD', 1),
('P005', 'Tai nghe Sony WH-1000XM4', 7000000, 8, 'Tai nghe chống ồn cao cấp', 0);


DELIMITER $$

CREATE PROCEDURE InsertDummyProducts()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 1000 DO
        INSERT INTO Products (pro_code, pro_name, pro_price, pro_amount, pro_des, pro_status)
        VALUES (
            CONCAT('P', LPAD(i + 5, 4, '0')),
            CONCAT('Sản phẩm demo ', i),
            FLOOR(100000 + RAND() * 10000000), -- giá ngẫu nhiên từ 100K đến 10 triệu
            FLOOR(1 + RAND() * 100),            -- số lượng từ 1 đến 100
            CONCAT('Mô tả sản phẩm số ', i),
            IF(RAND() > 0.5, 1, 0)              -- trạng thái 0 hoặc 1 ngẫu nhiên
        );
        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

-- Gọi procedure để chèn dữ liệu
CALL InsertDummyProducts();
-- Tạo Unique Index trên bảng Products (sử dụng cột productCode để tạo chỉ mục)
create index i_pro_code on products(pro_des);
create index i_pro_status on products(pro_status);
create index i_pro_name_pro_price on products(pro_name,pro_price);
select * from products;
-- Tạo Composite Index trên bảng Products (sử dụng 2 cột productName và productPrice)
drop index i_pro_name_pro_price on products;
drop index i_pro_code on products;
drop index i_pro_status on products;
-- Sử dụng câu lệnh EXPLAIN để biết được câu lệnh SQL của bạn thực thi như nào
explain select * from products where pro_status=1;
-- So sánh câu truy vấn trước và sau khi tạo index


-- Bước 4: 
-- Tạo view lấy về các thông tin: productCode, productName, productPrice, productStatus từ bảng products.

Create view w_infor as (select pro_code, pro_name, pro_price, pro_status from products);

select * from w_infor;

-- Tiến hành sửa đổi view

CREATE OR REPLACE VIEW w_infor AS
SELECT 
    pro_code AS productCode, 
    pro_name AS productName, 
    pro_price AS productPrice, 
    pro_status AS productStatus
FROM products;


-- Xoá view
DROP VIEW w_infor;


-- Bước 5:

-- Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product

delimiter //
create procedure get_all_product()
begin
select * from products;
end //
delimiter ;

call get_all_product();


-- Tạo store procedure thêm một sản phẩm mới

delimiter //
create procedure add_new_product(in p_code varchar(50),
									in p_name varchar(50),
                                    in p_price double,
                                    in p_amount int,
                                    in p_des varchar(100),
                                    in p_status boolean)
begin
		insert into products(pro_code, pro_name, pro_price, pro_amount, pro_des, pro_status) values(p_code,p_name,p_price,p_amount,p_des,p_status);
end //

delimiter ;
DROP PROCEDURE add_new_product;
call add_new_product('P002', 'Sản phẩm B', 200000, 10, 'Mô tả sản phẩm B', 1);


-- Tạo store procedure sửa thông tin sản phẩm theo id

DELIMITER //

CREATE PROCEDURE update_product_by_id(
    IN p_id INT,
    IN p_code VARCHAR(50),
    IN p_name VARCHAR(50),
    IN p_price DOUBLE,
    IN p_amount INT,
    IN p_des VARCHAR(100),
    IN p_status boolean
)
BEGIN
    UPDATE products
    SET
        pro_code = p_code,
        pro_name = p_name,
        pro_price = p_price,
        pro_amount = p_amount,
        pro_des = p_des,
        pro_status = p_status
    WHERE id = p_id;
END //

DELIMITER ;

DROP PROCEDURE update_product_by_id;
CALL update_product_by_id(
    1,
    'P001-EDIT',
    'Tên sản phẩm mới',
    199000,
    15,
    'Mô tả cập nhật',
    1
);

select * from products;

-- Tạo store procedure xoá sản phẩm theo id

DELIMITER //

CREATE PROCEDURE delete_product_by_id(
  in pro_id int
)
BEGIN
    delete from products where id = pro_id;
END //

DELIMITER ;

call delete_product_by_id(2);