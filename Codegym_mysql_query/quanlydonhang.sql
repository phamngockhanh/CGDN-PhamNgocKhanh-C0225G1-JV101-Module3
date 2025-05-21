create database if not exists quanlybanhang;

use quanlybanhang;

create table customer(
	c_id int primary key auto_increment,
    c_name varchar(50),
    c_age int
);

create table `order`(
	o_id int primary key auto_increment,
    o_date date,
    o_total_price float,
    c_id int,
    foreign key (c_id) references customer(c_id)
);

create table product(
	p_id int primary key auto_increment,
    p_name varchar(50),
    p_price float
);

create table order_detail(
	o_id int,
    p_id int,
    primary key (o_id,p_id),
    od_quantity int,
	foreign key (o_id) references `order`(o_id),
	foreign key (p_id) references product(p_id)
);


-- Thêm dữ liệu vào bảng Customer
INSERT INTO customer (c_id, c_name, c_age) VALUES
(1, 'Minh Quan', 10),
(2, 'Ngoc Oanh', 20),
(3, 'Hong Ha', 50);

-- Thêm dữ liệu vào bảng Order
INSERT INTO `order` (o_id, o_date, o_total_price, c_id) VALUES
(1, '2006-03-21', NULL, 1),
(2, '2006-03-23', NULL, 2),
(3, '2006-03-16', NULL, 1);

-- Thêm dữ liệu vào bảng Product
INSERT INTO product (p_id, p_name, p_price) VALUES
(1, 'May Giat', 3),
(2, 'Tu Lanh', 5),
(3, 'Dieu Hoa', 7),
(4, 'Quat', 1),
(5, 'Bep Dien', 2);

-- Thêm dữ liệu vào bảng OrderDetail
INSERT INTO order_detail (o_id, p_id, od_quantity) VALUES
(1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 1),
(3, 1, 8),
(2, 5, 4),
(2, 3, 3);

-- Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order
select o.o_id as OrderId, o.o_date as OrderDate, o.o_total_price as OrderTotalPrice
from `order` o;




-- Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
select c.c_name as TenKH , group_concat(p.p_name) as TenSP
from customer c join `order` o on c.c_id = o.c_id join order_detail od on o.o_id=od.o_id join product p on od.p_id = p.p_id
group by c.c_id;

-- Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
select c.c_name as TenKH
from customer c left join `order` o on c.c_id = o.c_id
where o.c_id is null;


-- Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn 
-- (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. Giá bán của từng loại được tính = odQTY*pPrice)
select o.o_id as OrderId, o.o_date as OrderDate, SUM(od.od_quantity*p.p_price) as OrderTotalPrice
from `order` o join order_detail od on o.o_id = od.o_id join product p on od.p_id = p.p_id
group by o.o_id;