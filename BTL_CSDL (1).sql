create database Abay
use Abay
create table Nguoi
(
	ID varchar(10) check(ID like 'TS[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' or ID like 'NS[0-9][0-9][0-9][0-9][0-9][0-9]'),
	CMND varchar(10),
	Ten nvarchar(50),
	GioiTinh int check(GioiTinh = 0 or GioiTinh = 1),
	NgaySinh date,
	NoiSinh nvarchar(50),
	primary key(ID)
)

create table ThiSinh
(
	maTS varchar(10) check(maTS like 'TS%'),
	DiaChi nvarchar(50),
	DienThoai int,
	GioiThieu varchar(5000),
	primary key(maTS)
)
alter table ThiSinh
add constraint FK_TS_ID foreign key(maTS) references Nguoi(ID)

create table NgheSy
(
	maNS varchar(10) check(maNS like 'NS%'),
	NgheDanh nvarchar(50),
	ThanhTich varchar(5000),
	MCFlag int check(MCFlag = 0 or MCFlag = 1),
	CSFlag int check(CSFlag = 0 or CSFlag = 1),
	NSFlag int check(NSFlag = 0 or NSFlag = 1),
	primary key(maNS)
)
alter table NgheSy
add constraint FK_NS_ID foreign key(maNS) references Nguoi(ID)

create table CTMC
(
	maMC varchar(10),
	CTdan nvarchar(50),
	primary key(maMC)
)
alter table CTMC
add constraint FK_maMC_CTMC foreign key(maMC) references NgheSy(maNS)

create table ABCS
(
	maCS varchar(10),
	Album nvarchar(50),
	primary key(maCS)
)
alter table ABCS
add constraint FK_maCS_ABCS foreign key(maCS) references NgheSy(maNS)

create table BaiHat
(
	maBH varchar(10) check(maBH like 'BH[0-9][0-9][0-9][0-9][0-9][0-9]'),
	TuaBH nvarchar(50) not null,
	primary key(maBH)
)

create table TheLoai
(
	maTL varchar(10) check(maTL like 'TT[0-9][0-9]'),
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
	ThongTinST int check(ThongTinST = 1 or ThongTinST = 2 or ThongTinST = 3),
	primary key(maNS, maBH)
)
alter table NSSangTac
add constraint FK_maNS_NSSangTac foreign key(maNS) references NgheSy(maNS)

create table TinhThanh
(
	maTT varchar(10) check(maTT like 'TT[0-9][0-9]'),
	tenTT nvarchar(50) unique not null,
	primary key(maTT)
)

create table NSX
(
	maNSX varchar(10) check(maNSX like 'NSX[0-9][0-9][0-9]'),
	tenNSX nvarchar(50),
	primary key(maNSX)
)

create table kenhTH
(
	maKenh varchar(10) check(maKenh like 'TH[0-9][0-9][0-9]'),
	tenKenh nvarchar(50) not null,
	primary key(maKenh)
)

create table MuaThi
(
	maMT varchar(10) check(maMT like 'MT[0-_]'),
	ngayBD date,
	ngayKT date,
	giaiThuong varchar(5000),
	ddvNH nvarchar(50),
	ddvBK nvarchar(50),
	ddvGL nvarchar(50),
	maGDAN varchar(10),
	maGK1 varchar(10),
	maGK2 varchar(10),
	maGK3 varchar(10),
	maMC varchar(10),
	primary key(maMT)
)
alter table MuaThi
add constraint ktnagy check(ngayKT > ngayBD)

create table BQthi
(
	maMT varchar(10),
	maNSX varchar(10),
	primary key(maMT, maNSX)
)

create table PhatSong
(
	maMT varchar(10),
	maKenh varchar(10),
	TTphat nvarchar(50) check(TTphat like 'chỉ phát sóng vòng bán kết' or TTphat like'chỉ phát sóng vòng gala' or TTphat like'phát sóng cả hai vòng'),
	primary key(maMT, maKenh)
)

create table VongThi
(
	sttVT int,
	maMT varchar(10),
	tenVT nvarchar(50),
	tgBD date,
	tgKT date,
	loaiVT int check(loaiVT = 1 or loaiVT = 2 or loaiVt = 3 or loaiVT = 4),
	primary key(sttVT, maMT)
)
alter table VongThi
add constraint kttg check(tgBD < tgKT)
alter table VongThi
add constraint lk foreign key(maMT) references MuaThi(maMT)

create table TSthamgiaVT
(
	sttVT int,
	maMT varchar(10),
	maTS varchar(10),
	ketqua int,
	primary key(sttVT, maMT, maTS)
)
alter table TSthamgiaVT
add constraint FK_maTS_TSthamgiaVT foreign key(maTS) references ThiSinh(maTS)

create table vongTG
(
	sttVT int,
	maMT varchar(10),
	maTinh varchar(10),
	diadiem nvarchar(50),
	primary key(sttVT, maMT)
)

create table TSthamgiaVTG
(
	sttVT int,
	maMT varchar(10),
	maTS varchar(10),
	GK1 int check(GK1 = 0 or GK1 = 1),
	GK2 int check(GK2 = 0 or GK2 = 1),
	GK3 int check(GK3 = 0 or GK3 = 1),
	primary key(sttVT,maMT, maTS)
)
alter table TSthamgiaVTG
add constraint FK_maTS_TSthamgiaVTG foreign key(maTS) references ThiSinh(maTS)
alter table TSthamgiaVTG
add constraint FK_sttVT_maMT_TSthamgiaVTG foreign key(sttVT, maMT) references vongTG(sttVT, maMT)

create table TShatVTG
(
	sttVT int,
	maMT varchar(10),
	maTS varchar(10),
	maBH varchar(10),
	primary key(sttVT,maMT, maTS, maBH)
)
alter table TShatVTG
add constraint FK_maTS_TShatVTG foreign key(maTS) references ThiSinh(maTS)
alter table TShatVTG
add constraint FK_sttVT_maMT_TShatVTG foreign key(sttVT, maMT) references vongTG(sttVT, maMT)

create table VNH
(
	sttVT int, 
	maMT varchar(10),
	HatNhomFlag varchar(10) check(HatNhomFlag = 0 or HatNhomFlag = 1),
	primary key(sttVT, maMT)
)

create table TShatVNH
(
	sttVT int,
	maMT varchar(10),
	maTS varchar(10),
	maBH varchar(10),
	primary key(sttVT, maMT, maTS, maBH)
)
alter table TShatVNH
add constraint FK_maTS_TShatVNH foreign key(maTS) references ThiSinh(maTS)
alter table TShatVNH
add constraint FK_sttVT_maMT_TShatVNH foreign key(sttVT, maMT) references VNH(sttVT, maMT)

create table NhomCa
(
	maNhom varchar(10),
	tenNhom nvarchar(50),
	maTS1 varchar(10) unique not null,
	maTS2 varchar(10) unique not null,
	maTS3 varchar(10) unique not null,
	maTS4 varchar(10) unique not null,
	primary key(maNhom)
)

create table NhomCaBH
(
	maNhom varchar(10),
	maBH varchar(10),
	sttVT int, 
	maMT varchar(10),
	primary key(maNhom, maBH)
)
alter table NhomCaBH
add constraint FK_sttVT_maMT_NhomCaBH foreign key(sttVT, maMT) references VNH(sttVT, maMT)

create table VongBK
(
	sttVT int,
	maMT varchar(10),
	Nam_Nu varchar(10) default -1,
	primary key(sttVT,maMT)
)

create table TSthamgiaVBK
(
	sttVT int,
	maMT varchar(10),
	maTS varchar(10),
	MSBC varchar(10),
	tongTN int,
	primary key(sttVT,maMT, maTS)
)
alter table TSthamgiaVBK
add constraint FK_maTS_TSthamgiaVBK foreign key(maTS) references ThiSinh(maTS)
alter table TSthamgiaVBK
add constraint FK_sttVT_maMT_TSthamgiaVBK foreign key(sttVT, maMT) references VongBK(sttVT, maMT)

create table TShatVBK
(
	maTS varchar(10),
	maBH varchar(10) not null,
	sttVT int not null,
	maMT varchar(10) not null,
	primary key(maTS, maBH)
)
alter table TShatVBK
add constraint FK_sttVT_maMT_TShatVBK foreign key(sttVT, maMT) references VongBK(sttVT, maMT)

create table VongGL
(
	sttVT int,
	maMT varchar(10),
	chuDe nvarchar(50) unique not null,
	maNHD varchar(10),
	HatDoiFlag varchar(10) check(HatDoiFlag = 0 or HatDoiFlag = 1),
	primary key(sttVT, maMT)
)
alter table VongGL
add constraint FK_maNHD_VongGL foreign key(maNHD) references NgheSy(maNS)

create table TSthamgiaVGL
(
	sttVT int,
	maMT varchar(10),
	maTS varchar(10),
	MSBC varchar(10),
	tongTN int,
	primary key(sttVT, maMT, maTS)
)
alter table TSthamgiaVGL
add constraint FK_maTS_TSthamgiaVGL foreign key(maTS) references ThiSinh(maTS)
alter table TSthamgiaVGL
add constraint FK_sttVT_maMT_TSthamgiaVGL foreign key(sttVT, maMT) references VongGL(sttVT, maMT)

create table TShatVGL
(
	maTS varchar(10),
	maBH varchar(10),
	sttVT int,
	maMT varchar(10),
	primary key(maTS, maBH)
)
alter table TShatVGL
add constraint FK_sttVT_maMT_TShatVGL foreign key(sttVT, maMT) references VongGL(sttVT, maMT)

--index 
create index idx_ttVongThi on VongThi (tenVT);
create index idx_cmnd on Nguoi (CMND);
create index idx_ttMuaGiai on MuaThi (ngayBD);

--function cau1-a
create function MinSTTV(@maMT varchar(10), @loaiVT int)
returns int as
begin 
	declare @STTmin int;
	select @STTmin = min(sttVT)
	from VongThi, MuaThi
	where VongThi.maMT = MuaThi.maMT
	return @STTmin;
end

--function cau1-b
create function MaxSTTV(@maMT varchar(10), @loaiVT int)
returns int as
begin 
	declare @STTmax int;
	select @STTmax = max(sttVT)
	from VongThi, MuaThi
	where VongThi.maMT = MuaThi.maMT
	return @STTmax;
end

--function cau-2
create function CapNhatKetQuaThuGiong(@sttVT int, @maMT varchar(10), @maTS varchar(10))
returns int as
begin 
	declare @kq int;
	select @kq = GK1 + GK2 + GK3
	from TSthamgiaVTG;
		if (@kq >= 2) 
		begin
			set @kq = 1;
		end;
		else 
		begin
			set @kq =  0
		end;
	return @kq;
end

--trigger 1-a
create trigger kt_thongtinTS 
on dbo.Nguoi 
for insert, update
as
begin
	declare @count int = 0
	select @count = Count(*)
	from inserted 
	where ID = (select Nguoi.ID 
		from Nguoi, ThiSinh, TSthamgiaVT, MuaThi
		where Nguoi.ID = ThiSinh.maTS 
		and ThiSinh.maTS = TSthamgiaVT.maTS 
		and TSthamgiaVT.maMT = MuaThi.maMT 
		and (year(ngayBD) - year(NgaySinh)) >= 15 
		and (year(ngayBD) - year(NgaySinh)) <= 30)
	if (@count > 0)
	begin 
		print N'Thí sinh tham gia phải có độ tuổi từ 15 đến 30'
		rollback tran
	end
end;

--trigger 1-b
create trigger TSGL
on dbo.Nguoi
for insert, update 
as
begin
	declare @count int = 0
	select @count = Count(*)
	from inserted
	where ID = (select Nguoi.ID 
		from Nguoi, ThiSinh, TSthamgiaVT, VongThi
		where Nguoi.ID = ThiSinh.maTS 
		and ThiSinh.maTS = TSthamgiaVT.maTS 
		and TSthamgiaVT.maMT = VongThi.maMT 
		and VongThi.loaiVT = 4)
	if(@count > 0)
	begin
		print N'Thí sinh đã từng tham gia vòng gala'
		rollback tran
	end
end;

--trigger 2
create trigger kt_MSBC
on dbo.Nguoi
for insert, update 
as
begin
	declare @count int = 0
	select @count = Count(*)
	from inserted
	where ID = (select Nguoi.ID 
		from Nguoi, ThiSinh, TSthamgiaVT, TSthamgiaVGL, TSthamgiaVBK
		where Nguoi.ID = ThiSinh.maTS 
		and ThiSinh.maTS = TSthamgiaVT.maTS 
		and TSthamgiaVT.maMT = TSthamgiaVGL.maMT 
		and TSthamgiaVT.maMT = TSthamgiaVBK.maMT 
		and TSthamgiaVGL.MSBC != TSthamgiaVBK.MSBC)
	if(@count > 0)
	begin
		print N'Mã số bình chọn này đã bị trùng lặp ở cuộc thi khác'
		rollback tran
		end
end;
	
insert into Nguoi values ('TS2012000001','385125478',N'Lê Minh Chó',0,'8/1/1999',N'Long An')
insert into Nguoi values ('TS2013000010','313122299',N'Đoàn Thị Đoan Trang',1,'10/10/1999',N'Tiền Giang')
insert into Nguoi values ('TS2014000201','234547587',N'Huỳnh Thị Lâm',1,'1/1/1999',N'Đà Lạt')
insert into Nguoi values ('TS2014000504','671776435',N'Nguyễn Văn Xệ',0,'3/12/1999',N'Hà Nội')
insert into Nguoi values ('NS000001','536994281',N'Trần Việt Linh',1,'7/11/1999',N'TPHCM')
insert into Nguoi values ('NS000103','536994281',N'Lê Anh Tôi',0,'3/6/1999',N'Ukraine')
insert into Nguoi values ('NS000504','458725812',N'Lê Thị Bích',1,'9/9/1999',N'Cà Mau')
insert into Nguoi values ('NS001056','654564564',N'Cẩm Lan Sục',1,'5/6/1969',N'Bến Tre')

insert into ThiSinh values ('TS2012000001',N'Long An','0123456789',N'Tôi tên Hiếu')
insert into ThiSinh values ('TS2013000010',N'Tiền Giang','0123456789',N'Tớ là Trang')
insert into ThiSinh values ('TS2014000201',N'Đà Lạt','0123456789',N'Mình tên là Lâm')
insert into ThiSinh values ('TS2014000504',N'Hà Nội','0123456789',N'Tôi tên Xệ')

insert into NgheSy values ('NS000001',N'Xám',N'Quán quân The Voice VN 2010',0,0,1)
insert into NgheSy values ('NS000103',N'DenDi',N'Quán quân The International',1,0,0)
insert into NgheSy values ('NS000504',N'