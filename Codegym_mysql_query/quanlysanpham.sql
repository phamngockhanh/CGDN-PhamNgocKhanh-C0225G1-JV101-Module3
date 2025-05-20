create database if not exists quanlysanpham;

use quanlysanpham;

create table nha_cung_cap(
	ma_nha_cc varchar(50) primary key,
    ten_nha_cc varchar(50),
    dia_chi varchar(50)
);

create table so_dien_thoai(
	so_dien_thoai varchar(50) primary key,
    ma_nha_cc varchar(50),
    foreign key (ma_nha_cc) references nha_cung_cap(ma_nha_cc)
);

create table don_dat_hang(
	so_don_hang int primary key auto_increment,
    ngay_dat_hang date,
    ma_nha_cc varchar(50),
    foreign key (ma_nha_cc) references nha_cung_cap(ma_nha_cc)
);

create table phieu_xuat(
	so_phieu_xuat int primary key auto_increment,
    ngay_xuat date
);

create table vat_tu(
	ma_vat_tu varchar(50) primary key,
    ten_vat_tu varchar(50)
);

create table phieu_xuat_vat_tu(
	so_phieu_xuat int,
    ma_vat_tu varchar(50),
	primary key (so_phieu_xuat, ma_vat_tu),
    don_gia_xuat float,
    so_luong_xuat int,
    foreign key (so_phieu_xuat) references phieu_xuat(so_phieu_xuat),
    foreign key (ma_vat_tu) references vat_tu(ma_vat_tu)
);


create table phieu_nhap(
	so_phieu_nhap int primary key auto_increment,
    ngay_nhap date
);

create table vat_tu_phieu_nhap(
	ma_vat_tu varchar(50) ,
	so_phieu_nhap int ,
    primary key (ma_vat_tu, so_phieu_nhap),
	don_gia_nhap float,
	so_luong_nhap int,
    foreign key (ma_vat_tu) references vat_tu(ma_vat_tu),
    foreign key (so_phieu_nhap) references phieu_nhap(so_phieu_nhap)
);

create table vat_tu_don_dat_hang(
	ma_vat_tu varchar(50),
    so_don_hang int,
     primary key (ma_vat_tu, so_don_hang),
    foreign key (ma_vat_tu) references vat_tu(ma_vat_tu),
    foreign key (so_don_hang) references don_dat_hang(so_don_hang)
);