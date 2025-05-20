create database practiceDB;

use practiceDB;

create table authors(
author_id int auto_increment primary key,
`name` varchar(100),
country varchar(50)
);

create table books(
book_id int auto_increment primary key,
title varchar(150),
publication_year int,
author_id int,
foreign key (author_id) references authors(author_id)
);

drop table books;
drop table authors;

insert into authors (name,country) values ('Pham Ngoc Khanh', 'Viet Nam');
insert into authors (name,country)  values ('Pham Ngoc Khanh 2', 'Japan');
insert into authors (name,country)  values ('Pham Ngoc Khanh 3', 'New zealand');
insert into authors (name,country)  values ('Pham Ngoc Khanh 4', 'Quang Binh');


insert into books (title, publication_year, author_id) values ('Mot con vit',2023, 1);
insert into books (title, publication_year, author_id) values ('Mot con vit 2',2022, 2);
insert into books (title, publication_year, author_id) values ('Mot con vit 3',2021, 1);
insert into books (title, publication_year, author_id) values ('Mot con vit 4',2020, 3);
insert into books (title, publication_year, author_id) values ('Mot con vit 5',2019, 3);
insert into books (title, publication_year, author_id) values ('Mot con vit 5',2011, 3);

select * from books; 
select * from authors; 

select * from books where publication_year > 2015;

select b.title as TenSach, a.name as TacGia
from books b join authors a where b.author_id = a.author_id;

select distinct a.name as TacGia
from authors a join books b
where a.author_id = b.author_id;

select * from books where publication_year > 2020;


-- Tìm tên tác giả đã xuất bản sách sớm nhất (năm nhỏ nhất).
select a.name as TacGia, b.publication_year as NamSanXuat
from authors a join books b
on a.author_id = b.author_id 
where b.publication_year = 
( select min(publication_year) from books ); 


select a.name as TacGia, b.publication_year as NamSanXuat
from authors a join books b
on a.author_id = b.author_id 
order by b.publication_year asc
limit 1;

-- Đếm số lượng sách mà mỗi tác giả đã viết.

select a.name as TacGia, count(b.book_id) as SoLuongSach
from authors a join books b
on a.author_id = b.author_id
group by a.author_id, a.name;


-- Hiển thị tất cả tác giả, kể cả những người chưa xuất bản sách nào.

SELECT a.name AS TacGia, b.title AS TenSach
FROM authors a
LEFT JOIN  books b ON a.author_id = b.author_id;

 -- Hiển thị tên sách và quốc gia của tác giả.
 
 SELECT b.title as TenSach, a.country as QuocGia
 FROM authors a join books b
 on a.author_id = b.author_id;
 
 -- Cập nhật quốc gia của tác giả có tên là 'Pham Ngoc Khanh 3' thành 'Hue'.
 
update authors set country = 'Hue' where author_id = 3;
delete from books where  publication_year < 2020 limit 10;

-- Hiển thị tất cả tác giả và số lượng sách họ đã viết (bao gồm cả tác giả chưa có sách).

select a.name as TacGia, COUNT(b.book_id) as SoLuongSach
from authors a left join books b
on a.author_id = b.author_id
group by a.name, a.author_id;

-- Hiển thị danh sách sách và tên tác giả, chỉ lấy những sách được xuất bản trong khoảng 2019 đến 2023.

select a.name as TacGia, b.publication_year as NamSanXuat
from authors a join books b
on a.author_id = b.author_id
where b.publication_year >2019 && b.publication_year<2023;

-- Hiển thị tên sách và tên tác giả, nhưng chỉ lấy những tác giả có quốc gia là 'Quang Binh'.

select a.name as TacGia, b.title as QuocGia
from authors a join books b
on a.author_id = b.author_id
where a.country = 'Hue';

-- Hiển thị danh sách tác giả không có sách nào được xuất bản.

select a.author_id, a.name as TacGia
from authors a left join books b
on a.author_id = b.author_id
where b.book_id is null;