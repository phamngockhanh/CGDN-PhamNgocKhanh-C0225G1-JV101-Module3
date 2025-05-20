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