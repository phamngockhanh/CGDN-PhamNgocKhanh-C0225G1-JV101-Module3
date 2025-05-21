create database furamaresort;

use furamaresort;

create table vi_tri(
	ma_vi_tri int primary key auto_increment,
    ten_vi_tri varchar(45)
);

create table trinh_do(
	ma_trinh_do int primary key auto_increment,
    ten_trinh_do varchar(45)
);

create table bo_phan(
	ma_bo_phan int primary key auto_increment,
    ten_bo_phan varchar(45)
);

create table nhan_vien(
	ma_nhan_vien int primary key auto_increment,
    ho_ten varchar(45),
    ngay_sinh date,
    so_cmnd varchar (45),
    luong double,
    so_dien_thoai varchar(45),
    email varchar(45),
    dia_chi varchar(45),
    ma_vi_tri int,
    ma_trinh_do int,
    ma_bo_phan int,
	foreign key (ma_vi_tri) references vi_tri(ma_vi_tri),
	foreign key (ma_trinh_do) references trinh_do(ma_trinh_do),
	foreign key (ma_bo_phan) references bo_phan(ma_bo_phan)
);

create table loai_khach(
	ma_loai_khach int primary key auto_increment,
    ten_loai_khach varchar(45)
);

create table khach_hang(
	ma_khach_hang int primary key auto_increment,
    ho_ten varchar(45),
    ngay_sinh date,
    gioi_tinh bit(1),
    so_cmnd varchar(45),
    so_dien_thoai varchar(45),
    email varchar(45),
    dia_chi varchar(45),
    ma_loai_khach int,
    foreign key (ma_loai_khach) references loai_khach(ma_loai_khach)
);

create table kieu_thue (
	ma_kieu_thue int primary key auto_increment,
    ten_kieu_thue varchar(45)
);

create table loai_dich_vu(
	ma_loai_dich_vu int primary key auto_increment,
    ten_loai_dich_vu varchar(45)
);


create table dich_vu(
	ma_dich_vu int primary key auto_increment,
    ten_dich_vu varchar(45),
    dien_tich int,
    chi_phi_thue double,
    so_nguoi_toi_da int,
    tieu_chuan_phong varchar(45),
    mo_ta_tien_nghi_khac varchar(45),
    dien_tich_ho_boi double,
    so_tang int,
    ma_kieu_thue int,
    ma_loai_dich_vu int,
    foreign key (ma_kieu_thue) references kieu_thue(ma_kieu_thue),
    foreign key (ma_loai_dich_vu) references loai_dich_vu(ma_loai_dich_vu)
);

create table hop_dong(
	ma_hop_dong int primary key auto_increment,
    ngay_lam_hop_dong datetime,
    ngay_ket_thuc datetime,
    tien_dat_coc double,
    ma_nhan_vien int,
    ma_khach_hang int,
    ma_dich_vu int,
    foreign key (ma_nhan_vien) references nhan_vien(ma_nhan_vien),
    foreign key (ma_khach_hang) references khach_hang(ma_khach_hang),
    foreign key (ma_dich_vu) references dich_vu(ma_dich_vu)
);

create table dich_vu_di_kem(
	ma_dich_vu_di_kem int primary key auto_increment,
    ten_dich_vu_di_kem varchar(45),
    gia double,
    don_vi varchar(10),
    trang_thai varchar(45)
);


create table hop_dong_chi_tiet(
	ma_hop_dong_chi_tiet int primary key auto_increment,
    so_luong int,
    ma_hop_dong int,
    ma_dich_vu_di_kem int,
    foreign key (ma_hop_dong) references hop_dong(ma_hop_dong),
    foreign key (ma_dich_vu_di_kem) references dich_vu_di_kem(ma_dich_vu_di_kem)
);

-- Thêm dữ liệu cho vị trí

INSERT INTO vi_tri (ten_vi_tri)
VALUES 
('Lễ tân'),
('Phục vụ'),
('Chuyên viên'),
('Giám sát'),
('Quản lý'),
('Giám đốc');

-- Thêm dữ liệu cho trình độalter

INSERT INTO trinh_do (ten_trinh_do)
VALUES 
('Trung cấp'),
('Cao đẳng'),
('Đại học'),
('Sau đại học');


-- Thêm dữ liệu cho bộ phận

INSERT INTO bo_phan (ten_bo_phan)
VALUES 
('Sale – Marketing'),
('Hành Chính'),
('Phục vụ'),
('Quản lý');


-- THêm dữ liệu cho loại khách

INSERT INTO loai_khach (ten_loai_khach)
VALUES 
('Diamond'),
('Platinium'),
('Gold'),
('Silver'),
('Member');


-- Thêm dữ liệu cho kiểu thuê

INSERT INTO kieu_thue (ten_kieu_thue)
VALUES 
('Thuê theo năm'),
('Thuê theo tháng'),
('Thuê theo ngày'),
('Thuê theo giờ');


-- Thêm dữ liệu cho loại dịch vụ

INSERT INTO loai_dich_vu (ten_loai_dich_vu)
VALUES 
('Villa'),
('House'),
('Room');

-- Thêm dữ liệu cho dịch vụ đi kèm

INSERT INTO dich_vu_di_kem (ten_dich_vu_di_kem, gia, don_vi, trang_thai)
VALUES 
('Massage', 500000, 'giờ', 'Đang hoạt động'),
('Karaoke', 300000, 'giờ', 'Đang hoạt động'),
('Thức ăn', 200000, 'suất', 'Đang hoạt động'),
('Nước uống', 50000, 'chai', 'Đang hoạt động'),
('Thuê xe', 800000, 'ngày', 'Đang hoạt động');

-- bảng nhân viên

INSERT INTO nhan_vien (ho_ten, ngay_sinh, so_cmnd, luong, so_dien_thoai, email, dia_chi, ma_vi_tri, ma_trinh_do, ma_bo_phan)
VALUES 
('Nguyễn Văn A', '1990-05-10', '123456789', 15000000, '0905123456', 'a.nguyen@furama.vn', 'Đà Nẵng', 1, 3, 2),
('Trần Thị B', '1985-07-20', '234567891', 12000000, '0912345678', 'b.tran@furama.vn', 'Đà Nẵng', 2, 2, 3),
('Lê Văn C', '1988-09-15', '345678912', 20000000, '0923456789', 'c.le@furama.vn', 'Hội An', 3, 4, 1);

-- bảng khách hàng 

INSERT INTO khach_hang (ho_ten, ngay_sinh, gioi_tinh, so_cmnd, so_dien_thoai, email, dia_chi, ma_loai_khach)
VALUES 
('Phạm Minh D', '1995-03-12', b'1', '456789123', '0934567890', 'd.pham@gmail.com', 'Hà Nội', 1),
('Ngô Thị E', '1993-11-22', b'0', '567891234', '0945678912', 'e.ngo@gmail.com', 'TP.HCM', 3),
('Đỗ Văn F', '1989-08-08', b'1', '678912345', '0956789123', 'f.do@gmail.com', 'Huế', 5);


-- bảng dịch vụ 
-- Villa
INSERT INTO dich_vu (ten_dich_vu, dien_tich, chi_phi_thue, so_nguoi_toi_da, tieu_chuan_phong, mo_ta_tien_nghi_khac, dien_tich_ho_boi, so_tang, ma_kieu_thue, ma_loai_dich_vu)
VALUES 
('Villa Biển 1', 350, 5000000, 6, '5 sao', 'Có bếp nướng, ban công rộng', 100, 2, 3, 1),
('Villa Biển 2', 400, 6000000, 8, '5 sao', 'Có phòng xông hơi, minibar', 120, 3, 2, 1);

-- House
INSERT INTO dich_vu (ten_dich_vu, dien_tich, chi_phi_thue, so_nguoi_toi_da, tieu_chuan_phong, mo_ta_tien_nghi_khac, dien_tich_ho_boi, so_tang, ma_kieu_thue, ma_loai_dich_vu)
VALUES 
('House Sân Vườn', 250, 3000000, 5, '4 sao', 'Gần hồ bơi, có sân BBQ', NULL, 1, 2, 2);

-- Room
INSERT INTO dich_vu (ten_dich_vu, dien_tich, chi_phi_thue, so_nguoi_toi_da, tieu_chuan_phong, mo_ta_tien_nghi_khac, dien_tich_ho_boi, so_tang, ma_kieu_thue, ma_loai_dich_vu)
VALUES 
('Phòng Deluxe 101', 60, 1500000, 2, NULL, 'Miễn phí buffet sáng', NULL, 1, 4, 3);


-- Bảng hop_dong (Hợp đồng thuê)

INSERT INTO hop_dong (ngay_lam_hop_dong, ngay_ket_thuc, tien_dat_coc, ma_nhan_vien, ma_khach_hang, ma_dich_vu)
VALUES 
('2025-05-01 14:00:00', '2025-05-05 12:00:00', 1000000, 1, 1, 1),  -- Villa Biển 1
('2025-05-03 10:00:00', '2025-05-06 10:00:00', 500000, 2, 2, 3);   -- House Sân Vườn


-- Bảng hop_dong_chi_tiet (Chi tiết dịch vụ đi kèm)


INSERT INTO hop_dong_chi_tiet (so_luong, ma_hop_dong, ma_dich_vu_di_kem)
VALUES 
(2, 1, 1),  -- Massage
(1, 1, 2),  -- Karaoke
(3, 2, 3),  -- Thức ăn
(2, 2, 5);  -- Thuê xe

select * from nhan_vien


-- 1. Thêm mới thông tin cho tất cả các bảng có trong CSDL để có thể thoả mãn các yêu cầu bên dưới.


-- 2. Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là một trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 kí tự.


-- 3. Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”.


-- 4.Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần. Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của khách hàng. 
-- Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.


-- 5. Hiển thị ma_khach_hang, ho_ten, ten_loai_khach, ma_hop_dong, ten_dich_vu, ngay_lam_hop_dong, ngay_ket_thuc, tong_tien 
-- (Với tổng tiền được tính theo công thức như sau: Chi Phí Thuê + Số Lượng * Giá, với Số Lượng và Giá là từ bảng dich_vu_di_kem, hop_dong_chi_tiet) 
-- cho tất cả các khách hàng đã từng đặt phòng. (những khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra).


-- 6. Hiển thị ma_dich_vu, ten_dich_vu, dien_tich, chi_phi_thue, ten_loai_dich_vu của tất cả các loại dịch vụ 
-- chưa từng được khách hàng thực hiện đặt từ quý 1 của năm 2021 (Quý 1 là tháng 1, 2, 3).



-- 7. Hiển thị thông tin ma_dich_vu, ten_dich_vu, dien_tich, so_nguoi_toi_da, chi_phi_thue, ten_loai_dich_vu 
-- của tất cả các loại dịch vụ đã từng được khách hàng đặt phòng trong năm 2020 nhưng chưa từng được khách hàng đặt phòng trong năm 2021.


-- 8. Hiển thị thông tin ho_ten khách hàng có trong hệ thống, với yêu cầu ho_ten không trùng nhau.
-- Học viên sử dụng theo 3 cách khác nhau để thực hiện yêu cầu trên.



-- 9. Thực hiện thống kê doanh thu theo tháng, nghĩa là tương ứng với mỗi tháng trong 
-- năm 2021 thì sẽ có bao nhiêu khách hàng thực hiện đặt phòng.


-- 10. Hiển thị thông tin tương ứng với từng hợp đồng thì đã sử dụng bao nhiêu dịch vụ đi kèm. 
-- Kết quả hiển thị bao gồm ma_hop_dong, ngay_lam_hop_dong, ngay_ket_thuc, tien_dat_coc,
-- so_luong_dich_vu_di_kem (được tính dựa trên việc sum so_luong ở dich_vu_di_kem).



-- 11.Hiển thị thông tin các dịch vụ đi kèm đã được sử dụng bởi những khách hàng 
-- có ten_loai_khach là “Diamond” và có dia_chi ở “Vinh” hoặc “Quảng Ngãi”.




-- 12. Hiển thị thông tin ma_hop_dong, ho_ten (nhân viên), ho_ten (khách hàng), so_dien_thoai (khách hàng), ten_dich_vu, so_luong_dich_vu_di_kem 
-- (được tính dựa trên việc sum so_luong ở dich_vu_di_kem), tien_dat_coc của tất cả các dịch vụ 
-- đã từng được khách hàng đặt vào 3 tháng cuối năm 2020 nhưng chưa từng được khách hàng đặt vào 6 tháng đầu năm 2021.



-- 13.Hiển thị thông tin các Dịch vụ đi kèm được sử dụng nhiều nhất bởi các Khách hàng đã đặt phòng.
-- (Lưu ý là có thể có nhiều dịch vụ có số lần sử dụng nhiều như nhau).


-- 14. Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một lần duy nhất. Thông tin hiển thị bao gồm ma_hop_dong, 
-- ten_loai_dich_vu, ten_dich_vu_di_kem, so_lan_su_dung (được tính dựa trên việc count các ma_dich_vu_di_kem).



-- 15. Hiển thi thông tin của tất cả nhân viên bao gồm ma_nhan_vien, ho_ten, ten_trinh_do, 
-- ten_bo_phan, so_dien_thoai, dia_chi mới chỉ lập được tối đa 3 hợp đồng từ năm 2020 đến 2021.



-- 16. Xóa những Nhân viên chưa từng lập được hợp đồng nào từ năm 2019 đến năm 2021.



-- 17. Cập nhật thông tin những khách hàng có ten_loai_khach từ Platinum lên Diamond, 
-- chỉ cập nhật những khách hàng đã từng đặt phòng với Tổng Tiền thanh toán trong năm 2021 là lớn hơn 10.000.000 VNĐ.




-- 18. Xóa những khách hàng có hợp đồng trước năm 2021 (chú ý ràng buộc giữa các bảng).



-- 19. Cập nhật giá cho các dịch vụ đi kèm được sử dụng trên 10 lần trong năm 2020 lên gấp đôi.



-- 20. Hiển thị thông tin của tất cả các nhân viên và khách hàng có trong hệ thống, thông tin hiển thị bao gồm id 
-- (ma_nhan_vien, ma_khach_hang), ho_ten, email, so_dien_thoai, ngay_sinh, dia_chi.

