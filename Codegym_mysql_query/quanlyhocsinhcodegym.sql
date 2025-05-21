create database if not exists c0225g1;
use c0225g1;
create table jame(
username varchar(50) primary key,
`password`  varchar(50)
);
create table class(
id int primary key auto_increment,
name varchar(50)
);
create table room(
id int primary key auto_increment,
name varchar(50),
class_id int,
foreign key(class_id) references class(id)
);
create table student(
id int primary key auto_increment,
name varchar(50),
gender boolean,
birthday date,
email varchar(100),
point float,
username varchar(50) unique,
class_id int,
foreign key(username) references jame(username),
foreign key(class_id) references class(id)
);
create table instructor(
id int primary key auto_increment,
name varchar(50),
birthday date,
salary float
);
create table instructor_class(
 instructor_id int,
 class_id int,
 start_time date,
 end_time_time date,
 primary key (instructor_id,class_id),
 foreign key(instructor_id) references instructor(id),
 foreign key(class_id) references class(id)
);


-- 1. Thêm tài khoản vào bảng jame
insert into jame(username, password) values
('hai123', 'password1'),
('huynh456', 'password2');
insert into jame(username, password) values ('huynh4567', 'password3');
insert into jame(username, password) values ('conga123', 'password4');
insert into jame(username, password) values ('conga12344', 'password4');
insert into jame(username, password) values ('conga1234455', 'password4');
insert into jame(username, password) values ('conga1234466', 'password4');

-- 2. Thêm lớp học
insert into class(name) values
('Math 101'),
('Physics 202');

-- 3. Thêm phòng học (mỗi phòng gắn với 1 lớp)
insert into room(name, class_id) values
('Room A', 1),
('Room B', 2);
insert into room(name, class_id) values ('Room B', 2);

-- 4. Thêm học viên (Hai và Huynh)
insert into student(name, gender, birthday, email, point, username, class_id) values
('Nguyen Hai', true, '2000-01-15', 'hai@gmail.com', 8.5, 'hai123', 1),
('Nguyen Huynh', true, '2001-03-20', 'huynh@gmail.com', 9.0, 'huynh456', 2);
insert into student(name, gender, birthday, email, point, username) values ('Nguyen Huynh', false, '2001-03-20', 'huynh@gmail.com', 9.0, 'huynh4567');
insert into student(name, gender, birthday, email, point, username) values ('Nguyen Huynh', false, '2001-03-20', 'huynh@gmail.com', 9.0, 'conga123');
insert into student(name, gender, birthday, email, point, username) values ('Nguyen Huynh', false, '2001-03-20', 'huynh@gmail.com', 9.0, 'conga12344');
insert into student(name, gender, birthday, email, point, username) values ('Nguyen k', false, '2001-03-20', 'huynh@gmail.com', 4.0, 'conga1234455');
insert into student(name, gender, birthday, email, point, username) values ('Nguyen h', false, '2001-03-20', 'huynh@gmail.com', 3.0, 'conga1234466');

update student set name = 'a1' where id = 11;
-- 5. Thêm giảng viên
insert into instructor(name, birthday, salary) values
('Le Van An', '1980-05-10', 1200.50),
('Tran Thi Binh', '1975-08-22', 1350.00);

-- 6. Gán giảng viên cho lớp học
insert into instructor_class(instructor_id, class_id, start_time, end_time_time) values
(1, 1, '2025-01-01', '2025-06-01'),
(2, 2, '2025-02-01', '2025-07-01');

-- Lấy ra thông tin các học viên, và cho biết các học viên đang theo học lớp nào.
select c.name as Lớp, s.name, s.gender, s.birthday, s.email, s.point, s.username 
from student s join class c
on s.class_id = c.id ;

-- Lấy ra thông tin các học viên, và cho biết các học viên đang theo học lớp nào và cả các bạn đã đk nhưng chưa có lớp học.

select c.name as Lớp, s.name, s.gender, s.birthday, s.email, s.point, s.username 
from student s left join class c
on s.class_id = c.id ;

-- Lấy thông tin của các học viên tên “Hai” và 'Huynh’.
select s.name, s.gender, s.birthday, s.email, s.point, s.username
from student s where s.name LIKE '%Hai%' || s.name LIKE '%Huynh%';

-- Lấy ra học viên có điểm lớn hơn 5 .
select s.name, s.gender, s.birthday, s.email, s.point, s.username
from student s where s.point > 5;
-- Lấy ra học viên có họ là “nguyen”

select s.name, s.gender, s.birthday, s.email, s.point, s.username
from student s where s.name LIKE '%nguyen%' ;

-- Thông kế số lượng học sinh theo từng loại điểm.
select point, COUNT(name)
from student
group by point;

-- Thông kế số lượng học sinh theo điểm và điểm phải lớn hơn 5
select point, count(name)
from student
group by point
having point > 5;


-- Thông kế số lượng học sinh theo điểm lớn hơn 5 và chỉ hiện thị với số lượng>=2
select point as điểm, count(name) as Sốlượng
from student
group by point
having point > 5 && count(name)>=2;

-- Lấy ra danh sách học viên của lớp c1121g1 và sắp xếp tên học viên theo alphabet.
select * from student
order by student.name desc;