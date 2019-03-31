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
	TTphat int check(TTphat = 1 or TTphat = 2 or TTphat =3),
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
	
insert into Nguoi values ('TS2012000001','385125478',N'Lê Minh Tín',0,'8/1/1999',N'Long An')
insert into Nguoi values ('TS2012000002','156397453',N'Nguyễn Văn Di',0,'9/8/1996',N'TPHCM')
insert into Nguoi values ('TS2012000003','985534556',N'Trần Mỹ Dung',1,'8/1/1997',N'Bến Tre')
insert into Nguoi values ('TS2012000004','635225982',N'Trần Hoài Trọng',0,'8/10/1994',N'Hà Nội')
insert into Nguoi values ('TS2013000010','313122299',N'Đoàn Thị Đoan Trang',1,'10/10/1999',N'Tiền Giang')
insert into Nguoi values ('TS2013000011','524788512',N'Nguyễn Hữu Khánh',0,'8/3/1999',N'Tiền Giang')
insert into Nguoi values ('TS2013000001','897523562',N'Võ Huyền Trân',1,'6/10/1998',N'TPHCM')
insert into Nguoi values ('TS2013000002','985625852',N'Vũ Ngọc Kim Chi',1,'2/10/2000',N'Hà Nội')
insert into Nguoi values ('TS2014000001','234547587',N'Huỳnh Thị Lâm',1,'1/1/1997',N'Đà Lạt')
insert into Nguoi values ('TS2014000004','671776435',N'Nguyễn Văn Xệ',0,'3/12/1998',N'Hà Nội')
insert into Nguoi values ('TS2014000503','256984523',N'Trần Văn Bo',0,'3/1/1995',N'Hà Nội')
insert into Nguoi values ('TS2014000502','559687521',N'Nguyễn Ngọc Ngân',1,'12/10/1994',N'Bến Tre')
insert into Nguoi values ('TS2015000001','671776435',N'Trần Hồng Ngọc',0,'3/3/1998',N'Hà Nội')
insert into Nguoi values ('TS2015000002','156987452',N'Nguyễn Hoài Luân',1,'6/8/1995',N'TPHCM')
insert into Nguoi values ('TS2015000003','396578215',N'Nguyễn Văn Kỳ',1,'4/5/1991',N'Đà Lạt')
insert into Nguoi values ('TS2015000004','478952364',N'Hoàng Kim Mỹ Linh',0,'3/8/1990',N'Hà Nội')
insert into Nguoi values ('NS000001','536994281',N'Trần Việt Linh',1,'7/11/1995',N'TPHCM')
insert into Nguoi values ('NS000103','779984214',N'Huỳnh Anh Tôi',0,'3/6/1980',N'Hà Tĩnh')
insert into Nguoi values ('NS000504','458725812',N'Lê Thị Bích',1,'9/9/1989',N'Cà Mau')
insert into Nguoi values ('NS001056','654564564',N'Cẩm Lan',1,'5/6/1969',N'Bến Tre')
insert into Nguoi values ('NS000632','325698158',N'Đỗ Duy Hiệp',0,'12/12/2000',N'Đà Nẵng')
insert into Nguoi values ('NS000444','169854752',N'Lê Nguyễn Gia Huy',0,'11/5/1969',N'Nha Trang')
insert into Nguoi values ('NS002000','652146528',N'Trần Thị Châu',1,'1/2/1995',N'Quảng Nam')
insert into Nguoi values ('NS002050','556321288',N'Kiều Anh Minh',0,'2/1/1995',N'An Giang')
insert into Nguoi values ('NS000094','785100008',N'Diễm Trang',1,'9/2/1991',N'Nam Định')
insert into Nguoi values ('NS000010','236598422',N'Bùi Anh Sang',0,'3/2/1994',N'Cà Mau')
insert into Nguoi values ('NS000002','365019522',N'Lê Dương Trọng',0,'5/5/1995',N'Thanh Hóa')
insert into Nguoi values ('NS000003','156252215',N'Hoàng Văn Điền',0,'4/7/1990',N'Nghệ An')

insert into ThiSinh values ('TS2012000001',N'Long An','0123456789',N'Tôi tên Tín')
insert into ThiSinh values ('TS2012000002',N'TPHCM','0968532585',N'Tôi tên Di')
insert into ThiSinh values ('TS2012000003',N'Bến Tre','0963251025',N'Tôi tên Dung')
insert into ThiSinh values ('TS2012000004',N'Hà Nội','0164823654',N'Tôi tên Trọng')
insert into ThiSinh values ('TS2013000010',N'Tiền Giang','0168224722',N'Tớ là Trang')
insert into ThiSinh values ('TS2013000011',N'Tiền Giang','0939697570',N'Tớ là Khánh')
insert into ThiSinh values ('TS2013000001',N'TPHCM','0164258588',N'Tớ là Trân')
insert into ThiSinh values ('TS2013000002',N'Hà Nội','0122535401',N'Tớ là Chi')
insert into ThiSinh values ('TS2014000001',N'Đà Lạt','0965231453',N'Mình tên là Lâm')
insert into ThiSinh values ('TS2014000004',N'Hà Nội','0156325891',N'Tôi tên Xệ')
insert into ThiSinh values ('TS2014000003',N'Hà Nội','0969541423',N'Mình tên là Bo')
insert into ThiSinh values ('TS2014000002',N'Bến Tre','0164258963',N'Mình tên là Ngân')
insert into ThiSinh values ('TS2015000001',N'Hà Nội','0936525789',N'Mình tên là Ngọc')
insert into ThiSinh values ('TS2015000002',N'TPHCM','0125632478',N'Mình tên là Luân')
insert into ThiSinh values ('TS2015000003',N'Đà Lạt','0123856472',N'Mình tên là Kỳ')
insert into ThiSinh values ('TS2015000004',N'Hà Nội','0963251247',N'Mình tên là Linh')

insert into NgheSy values ('NS000001',N'Xám',N'Nghệ Sĩ Ưu Tú',0,0,1)
insert into NgheSy values ('NS000002',N'Trọng Lễ',N'Nghệ Sĩ Ưu Tú',0,0,1)
insert into NgheSy values ('NS000003',N'Điền Đô',N'Nhạc Sỹ Ưu Tú',0,0,1)
insert into NgheSy values ('NS000010',N'Sang Trọng',N'Nghệ Sĩ Nhân Dân',0,0,1)
insert into NgheSy values ('NS000103',N'DenDi',N'Quán quân The International 2011',1,0,0)
insert into NgheSy values ('NS000504',N'Barabẻn',N'Á quân Giọng Hát Việt 2011',0,1,0)
insert into NgheSy values ('NS001056',N'Linda',N'Quán quân Giọng Hát Việt 2011',1,0,0)
insert into NgheSy values ('NS000632',N'Hiệp Gà',N'Người dẫn chương trình tài năng',1,0,0)
insert into NgheSy values ('NS001056',N'Tý',N'Nghệ Sỹ Nhân Dân',1,0,0)
insert into NgheSy values ('NS002000',N'Châu Nhý',N'Nghệ Sỹ Tài Năng',0,1,0)
insert into NgheSy values ('NS002050',N'Minh Mẫn',N'Ca Sỹ Đa Năng',0,1,0)
insert into NgheSy values ('NS000094',N'TripBlack',N'Quán Quân Giọng Ca Vàng 2011',0,1,0)

insert into CTMC values('NS000103',N'Thách Thức Danh Hài')
insert into CTMC values('NS001056',N'Cười Xuyên Việt')
insert into CTMC values('NS000632',N'Thiên Đường Ẩm Thực')
insert into CTMC values('NS000444',N'Hát Lên Đi')

insert into ABCS values('NS000504',N'Cháy Lên Nào')
insert into ABCS values('NS002000',N'Trọn Đời Bên Nhau')
insert into ABCS values('NS002050',N'The Honor')
insert into ABCS values('NS000094',N'Xa Nhau')

insert into BaiHat values('BH000001',N'Anh Không Chơi Đâu')
insert into BaiHat values('BH000002',N'Đến Bên Anh')
insert into BaiHat values('BH000010',N'Chúng Ta Liệu Có Phải Một Đôi')
insert into BaiHat values('BH000003',N'Không Thể Hay Có Thể')

insert into TheLoai values('TL001',N'Trữ Tình')
insert into TheLoai values('TL002',N'Pop')
insert into TheLoai values('TL003',N'Rock')
insert into TheLoai values('TL004',N'Rap')

insert into BHTL values('BH000001','TL004')
insert into BHTL values('BH000002','TL001')
insert into BHTL values('BH000010','TL003')
insert into NHTL values('BH000003','TL002')

insert into NSSangTac values('NS000001','BH000001',1)
insert into NSSangTac values('NS000002','BH000002',2)
insert into NSSAngTac values('NS000003','BH000003',3)
insert into NSSAngTac values('NS000010','BH000010',3)

insert into TinhThanh values('TT01',N'TPHCM')
insert into TinhThanh values('TT02',N'Hà Nội')
insert into TinhThanh values('TT03',N'Long An')
insert into TinhThanh values('TT04',N'Đà Nẵng')
insert into TinhThanh values('TT05',N'Đà Lạt')
insert into TinhThanh values('TT06',N'Thanh Hóa')
insert into TinhThanh values('TT07',N'Cà Mau')
insert into TinhThanh values('TT08',N'Nghệ An')
insert into TinhThanh values('TT09',N'Nam Định')
insert into TinhThanh values('TT10',N'An Giang')
insert into TinhThanh values('TT11',N'Quảng Nam')
insert into TinhThanh values('TT12',N'Nha Trang')
insert into TinhThanh values('TT13',N'Bến Tre')
insert into TinhThanh values('TT14',N'Tiền Giang')
insert into TinhThanh values('TT15','Hà Tĩnh')
insert into TinhThanh values('TT16','TPHCM')

insert into NSX values ('NSX001',N'Đỗ Hiếu ')
insert into NSX values ('NSX002',N'Huy Tuấn')
insert into NSX values ('NSX003',N'Đức Trí')
insert into NSX values ('NSX004',N'Hải Phong')

insert into kenhTH values ('TH001',N'VTV3')
insert into kenhTH values ('TH002',N'VTV6')
insert into kenhTH values ('TH003',N'HTV7')
insert into kenhTH values ('TH004',N'THVL')

insert into MuaThi values('MT1','1/1/2015','10/10/2015',N'10000000 VND',N'Nhà Hát Trung Tâm',N'Nhà Thi Đấu Quận 7',N'Nhà Thi Đấu Quân Khu 7','NS000001','NS000002','NS000094','NS000103')
insert into MuaThi values('MT2','1/1/2016','10/10/2016',N'50000000 VND',N'Nhà Hát Trung Tâm',N'Nhà Thi Đấu Quận 7',N'Nhà Thi Đấu Quân Khu 7','NS0000094','NS000002','NS000001','NS001056')
insert into MuaThi values('MT3','1/1/2017','10/10/2017',N'100000000 VND',N'Nhà Hát Trung Tâm',N'Nhà Thi Đấu Quận 7',N'Nhà Thi Đấu Quân Khu 7','NS000001','NS000002','NS000094','NS000632')
insert into MuaThi values('MT4','1/1/2018','10/10/2018',N'200000000 VND',N'Nhà Hát Trung Tâm',N'Nhà Thi Đấu Quận 7',N'Nhà Thi Đấu Quân Khu 7','NS000001','NS000002','NS000094','NS000444')

insert into BQthi values ('MT01','NSX001')
insert into BQthi values ('MT02','NSX003')
insert into BQthi values ('MT03','NSX004')
insert into BQthi values ('MT04','NSX002')

insert into PhatSong values ('MT1','TH001',1)
insert into PhatSong values ('MT2','TH002',2)
insert into PhatSong values ('MT3','TH003',3)
insert into PhatSong values ('MT4','TH004',3)

insert into VongThi values (01,'MT01',N'Vòng Thử Giọng','1/1/2015','3/3/2012',1)
insert into VongThi values (02,'MT01',N'Vòng Nhà Hát','4/4/2015','5/5/2012',2)
insert into VongThi values (03,'MT01',N'Vòng Bán Kết','6/6/2015','7/7/2012',3)
insert into VongThi values (04,'MT01',N'Vòng Gala','8/8/2015','10/10/2012',4)
insert into VongThi values (01,'MT02',N'Vòng Thử Giọng','1/1/2016','3/3/2013',1)
insert into VongThi values (02,'MT02',N'Vòng Nhà Hát','4/4/2016','5/5/2013',2)
insert into VongThi values (03,'MT02',N'Vòng Bán Kết','6/6/2016','7/7/2013',3)
insert into VongThi values (04,'MT02',N'Vòng Gala','8/8/2016','10/10/2013',4)
insert into VongThi values (01,'MT03',N'Vòng Thử Giọng','1/1/2017','3/3/2014',1)
insert into VongThi values (02,'MT03',N'Vòng Nhà Hát','4/4/2017','5/5/2014',2)
insert into VongThi values (03,'MT03',N'Vòng Bán Kết','6/6/2017','7/7/2014',3)
insert into VongThi values (04,'MT03',N'Vòng Gala','8/8/2017','10/10/2014',4)
insert into VongThi values (01,'MT04',N'Vòng Thử Giọng','1/1/2018','3/3/2015',1)
insert into VongThi values (02,'MT04',N'Vòng Nhà Hát','4/4/2018','5/5/2015',2)
insert into VongThi values (03,'MT04',N'Vòng Bán Kết','6/6/2018','7/7/2015',3)
insert into VongThi values (04,'MT04',N'Vòng Gala','8/8/2018','10/10/2015',4)

insert into TSthamgiaVT values (01,'MT01','TS2012000001',1)
insert into TSthamgiaVT values (02,'MT01','TS2012000001',2)
insert into TSthamgiaVT values (03,'MT01','TS2012000001',1)
insert into TSthamgiaVT values (04,'MT01','TS2012000001',1)
insert into TSthamgiaVT values (01,'MT02','TS2013000010',1)
insert into TSthamgiaVT values (02,'MT02','TS2013000010',1)
insert into TSthamgiaVT values (03,'MT02','TS2013000010',1)
insert into TSthamgiaVT values (04,'MT02','TS2013000010',0)
insert into TSthamgiaVT values (01,'MT03','TS2014000201',1)
insert into TSthamgiaVT values (02,'MT03','TS2014000201',1)
insert into TSthamgiaVT values (03,'MT03','TS2014000201',1)
insert into TSthamgiaVT values (04,'MT03','TS2014000201',0)
insert into TSthamgiaVT values (01,'MT04','TS2014000504',1)
insert into TSthamgiaVT values (02,'MT04','TS2014000504',1)
insert into TSthamgiaVT values (03,'MT04','TS2014000504',1)
insert into TSthamgiaVT values (04,'MT04','TS2014000504',0)

insert into vongTG values (01,'MT01','TT01','Nhà thi đấu quận 7')
insert into vongTG values (01,'MT02','TT02','Nhà thi đấu Bách Khoa')
insert into vongTG values (01,'MT03','TT01','Nhà thi đấu quận 7')
insert into vongTG values (01,'MT04','TT02','Nhà thi đấu quận 7')

insert into TSthamgiaVTG values (01,'MT01','TS2012000001',1,1,1)
insert into TSthamgiaVTG values (01,'MT02','TS2013000010',1,1,1)
insert into TSthamgiaVTG values (01,'MT03','TS2014000201',1,1,1)
insert into TSthamgiaVTG values (01,'MT04','TS2014000504',1,1,0)

insert into TShatVTG values (01,'MT01','TS2012000001','BH000001')
insert into TShatVTG values (01,'MT02','TS2013000010','BH000002')
insert into TShatVTG values (01,'MT03','TS2014000201','BH000003')
insert into TShatVTG values (01,'MT04','TS2014000504','BH000010')

insert into VNH values (02,'MT01',1)
insert into VNH values (02,'MT02',1)
insert into VNH values (02,'MT03',1)
insert into VNH values (02,'MT04',1)

insert into TShatVNH values (02,'MT01','TS2012000001','BH000002')
insert into TShatVNH values (02,'MT02','TS2013000010','BH000003')
insert into TShatVNH values (02,'MT03','TS2014000201','BH000010')
insert into TShatVNH values (02,'MT04','TS2014000504','BH000001')

insert into NhomCa values ('NC201201',N'Nhóm 1','TS2012000001','TS2012000002','TS2012000003','TS2012000004')
insert into NhomCa values ('NC201302',N'Nhóm 2','TS2013000010','TS2013000011','TS2013000001','TS2013000002')
insert into NhomCa values ('NC201403',N'Nhóm 3','TS2014000001','TS2014000004','TS2014000003','TS2014000002')
insert into NhomCa values ('NC201504',N'Nhóm 4','TS2015000001','TS2015000002','TS2015000003','TS2015000004')

insert into NhomCaBH values ('NC201201','BH000001',1,'MT1')
insert into NhomCaBH values ('NC201302','BH000002',1,'MT2')
insert into NhomCaBH values ('NC201403','BH000003',1,'MT3')
insert into NhomCaBH values ('NC201504','BH000010',1,'MT4')

insert into VongBK