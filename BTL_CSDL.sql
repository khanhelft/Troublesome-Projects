create database Abay
use Abay
create table Nguoi
(
	ID varchar(10) check(ID like 'TS%' or ID like'NS%'),
	CMND varchar(10),
	Ten nvarchar(50),
	GioiTinh int check(GioiTinh = 0 or GioiTinh = 1),
	NgaySinh date,
	NoiSinh nvarchar(50),
	primary key(ID)
)

create table ThiSinh
(
	MaThiSinh varchar(10),
	DiaChi nvarchar(50),
	DienThoai int,
	GioiThieu varchar(5000),
	primary key(MaThiSinh)
)
alter table ThiSinh
add constraint FK_TS_ID foreign key(MaThiSinh) references Nguoi(ID)

create table NgheSy
(
	MaNgheSy varchar(10),
	NgheDanh nvarchar(50),
	ThanhTich varchar(5000),
	MCFlag int check(MCFlag = 0 or MCFlag = 1),
	CSFlag int check(CSFlag = 0 or CSFlag = 1),
	NSFlag int check(NSFlag = 0 or NSFlag = 1),
	primary key(MaNgheSy)
)
alter table NgheSy
add constraint FK_NS_ID foreign key(MaNgheSy) references Nguoi(ID)

create table CTMC
(
	maMC varchar(10),
	CTdan nvarchar(50),
	primary key(maMC)
)
alter table CTMC
add constraint FK_maMC_CTMC foreign key(maMC) references NgheSy(MaNgheSy)

create table ABCS
(
	maCS varchar(10),
	Album nvarchar(50),
	primary key(maCS)
)
alter table ABCS
add constraint FK_maCS_ABCS foreign key(maCS) references NgheSy(MaNgheSy)

create table BaiHat
(
	maBH varchar(10) check(maBH like 'BH______'),
	TuaBH nvarchar(50) not null,
	primary key(maBH)
)

create table TheLoai
(
	maTL varchar(10) check(maTL like 'TT__'),
	tenTL nvarchar(50) unique not null,
	primary key(maTL)
)

create table BHTL
(
	maBH varchar(10),
	maTL varchar(10),
	primary key(maBH, maTL)
)
alter table BHTL
add constraint FK_maBH_BHTL foreign key(maBH) references BaiHat(maBH)
alter table BHTL
add constraint FK_maTL_BHTL foreign key(maTL) references TheLoai(maTL)

create table NSSangTac
(
	maNS varchar(10),
	maBH varchar(10),
	ThongTinST nvarchar(50) check(ThongTinST like N'1:sáng tác phần lời' or ThongTinST like N'sáng tác phần nhạc' or ThongTinST like N'cả hai (nhạc và lời)'),
	primary key(maNS, maBH)
)
alter table NSSangTac
add constraint FK_maNS_NSSangTac foreign key(maNS) references NgheSy(MaNgheSy)

create table TinhThanh
(
	maTT varchar(10) check(maTT like 'TT__'),
	tenTT nvarchar(50) unique not null,
	primary key(maTT)
)

create table NSX
(
	maNSX varchar(10) check(maNSX like 'NSX___'),
	tenNSX nvarchar(50),
	primary key(maNSX)
)

create table kenhTH
(
	maKenh varchar(10) check(maKenh like 'TH___'),
	tenKenh nvarchar(50) not null,
	primary key(maKenh)
)
