create database quanlyquannet;

use quanlyquannet;

create table may_tinh(
	ma_may varchar(50) primary key,
    hang_san_xuat varchar(50),
    vi_tri_dat_may varchar(50)
);

create table loai_khach_hang(
	ma_loai_khach_hang varchar(50) primary key,
    ten_loai_khach_hang varchar(50)
);

create table khach_hang(
	id int primary key,
	ten varchar(50),
    so_dien_thoai varchar(50),
    email varchar(50),
	ma_loai_khach_hang varchar(50),
    foreign key (ma_loai_khach_hang) references loai_khach_hang(ma_loai_khach_hang)
);

create table hoa_don(
	ma_dich_vu varchar(50) primary key,
    id_khach_hang int,
    ma_may varchar(50),
    thoi_gian_bat_dau datetime,
    thoi_gian_ket_thuc datetime,
    foreign key (id_khach_hang) references khach_hang(id),
    foreign key (ma_may) references may_tinh(ma_may)
);

create table dich_vu_di_kem(
	ma_dich_vu_di_kem varchar(50) primary key,
    ten_dich_vu varchar(50)
);

create table hoa_don_dich_vu_di_kem(
	ma_dich_vu varchar(50),
    ma_dich_vu_di_kem varchar(50),
    primary key (ma_dich_vu , ma_dich_vu_di_kem),
    foreign key (ma_dich_vu) references hoa_don(ma_dich_vu),
    foreign key (ma_dich_vu_di_kem) references dich_vu_di_kem(ma_dich_vu_di_kem)
);