CREATE DATABASE `c0225g1` ;

use c0225g1;

create table Class(
id int primary key,
`name` varchar(30)
);

create table teacher(
id int primary key,
`name` varchar(30),
age int,
country varchar(30)
);

insert into teacher(id,name,age,country) values (1,'Pham Ngoc Khanh',23,'VietNam');
update teacher set name = 'Monkey D Luffy' where id=1;
delete from teacher where id =1;
truncate table teacher;