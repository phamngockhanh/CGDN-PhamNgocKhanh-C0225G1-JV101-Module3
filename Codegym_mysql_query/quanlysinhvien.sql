CREATE DATABASE QuanLySinhVien;

USE QuanLySinhVien;

CREATE TABLE Class(

         ClassID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,

          ClassName VARCHAR(60) NOT NULL,

          StartDate DATETIME NOT NULL,

          Status BIT

);


CREATE TABLE Student(

          StudentId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,

          StudentName VARCHAR(30) NOT NULL,

          Address VARCHAR(50),

          Phone VARCHAR(20),

          Status BIT,

          ClassId INT NOT NULL,

          FOREIGN KEY (ClassId) REFERENCES Class (ClassID)

);


CREATE TABLE Subject(

         SubId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,

         SubName VARCHAR(30) NOT NULL,

         Credit TINYINT NOT NULL DEFAULT 1 CHECK ( Credit >= 1 ),

         Status BIT DEFAULT 1

);


CREATE TABLE Mark(

        MarkId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,

        SubId INT NOT NULL,

        StudentId INT NOT NULL,

        Mark FLOAT DEFAULT 0 CHECK ( Mark BETWEEN 0 AND 100),

        ExamTimes TINYINT DEFAULT 1,

        UNIQUE (SubId, StudentId),

        FOREIGN KEY (SubId) REFERENCES Subject (SubId),

        FOREIGN KEY (StudentId) REFERENCES Student (StudentId)

 );
 
 INSERT INTO Class (ClassName, StartDate, Status) VALUES
('Lập trình C cơ bản', '2025-09-01 08:00:00', 1),
('Toán cao cấp 1', '2025-09-01 08:00:00', 1),
('Lịch sử Đảng', '2025-09-01 08:00:00', 0);

INSERT INTO Student (StudentName, Address, Phone, Status, ClassId) VALUES
('Nguyễn Văn A', '123 Đường Lê Lợi, Hà Nội', '0912345678', 1, 1),
('Trần Thị B', '456 Đường Trần Phú, TP.HCM', '0908765432', 1, 1),
('Lê Văn C', '789 Đường Hai Bà Trưng, Đà Nẵng', '0988123456', 1, 2),
('Phạm Thị D', '101 Nguyễn Huệ, Huế', '0977554433', 0, 3);


INSERT INTO Subject (SubName, Credit, Status) VALUES
('Toán học', 3, 1),
('Vật lý đại cương', 2, 1),
('Lịch sử Việt Nam', 2, 0),
('Kỹ thuật lập trình', 4, 1);

INSERT INTO Mark (SubId, StudentId, Mark, ExamTimes) VALUES
(1, 1, 8.5, 1),
(2, 1, 7.8, 1),
(1, 2, 9.2, 1),
(4, 2, 8.8, 2),
(3, 3, 6.7, 1),
(2, 3, 7.5, 1);
-- Hiển thị tất cả các sinh viên có tên bắt đầu bảng ký tự ‘h’
	select * 
    from Student s 
    where s.StudentName like '% h%';

-- Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12.

	select  * 
    from Class c
    where MONTH(c.StartDate) = 12; 

-- Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5.
	select *
    from Subject s
    where s.Credit >= 3 && s.Credit<=5;

-- Thay đổi mã lớp(ClassID) của sinh viên có tên ‘Hung’ là 2.
	update Class set ClassID = 2 where ClassName = '% Hung';
-- Hiển thị các thông tin: StudentName, SubName, Mark. Dữ liệu sắp xếp theo điểm thi (mark) giảm dần. nếu trùng sắp theo tên tăng dần.

	select StudentName as TenHS, SubName as Ho, Mark as Diem
    from Student s join Mark m on s.StudentId = m.StudentId join Subject s1 on m.SubId = s1.SubId
    order by m.Mark desc, s.StudentName asc;