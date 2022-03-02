CREATE DATABASE ECOMMERCE3;
GO

USE ECOMMERCE3
GO

CREATE TABLE TaiKhoan(
	ID_taikhoan NUMERIC(9,0) PRIMARY KEY,
	tendangnhap VARCHAR(21) UNIQUE,
	matkhau VARCHAR(21),
	sdt VARCHAR(15),
	sonha NVARCHAR(100),   --40 phan chau trinh
	quan_huyen NVARCHAR(100),
	tinh_thanhpho NVARCHAR(100)
);

CREATE TABLE KhachHang(
	ID_khachhang NUMERIC(9,0) PRIMARY KEY
);

CREATE TABLE NhanVien(
	ID_nhanvien NUMERIC(9,0) PRIMARY KEY,
	bangcap Nvarchar(25)
);

CREATE TABLE NhanVienNhapKho(
	ID_NVNK NUMERIC(9,0) PRIMARY KEY,
	tocdogophim INT,
	Machinhanh NUMERIC(4,0)
);

CREATE TABLE NhanVienXuLi(
	ID_NVXL NUMERIC(9,0) PRIMARY KEY,
	tocdoxuly INT
);

CREATE TABLE NhanVienTuVan(
	ID_NVTV NUMERIC(9,0) PRIMARY KEY,
	TrinhDoNgoaiNgu NVARCHAR(20)
);

CREATE TABLE DanhMuc(
	Tendanhmuc NVARCHAR(100) PRIMARY KEY,
	danhmuccha NVARCHAR(100)
);

CREATE TABLE NhaSanxuat(
	tenNSX  NVARCHAR(15) PRIMARY KEY
);

CREATE TABLE NguoiGiaoHang(
	CMND NUMERIC(9,0) PRIMARY KEY,
	tenNGH NVARCHAR(25)
);

CREATE TABLE sdt_NguoiGiaoHang(
	CMND NUMERIC(9,0),
	sdt VARCHAR(15),
	PRIMARY KEY(CMND,sdt)
);

CREATE TABLE DonHang(
	MaDonHang CHAR(9) PRIMARY KEY,
	TinhtrangXuLi NVARCHAR(100) DEFAULT N'Chờ xác nhận mua',  --cho xac nhan mua, cho nhap hang, da xu li
	TinhtrangXacNhanMua bit DEFAULT 0,
	
	sonha NVARCHAR(100),   --40 phan chau trinh
	quan_huyen NVARCHAR(100),
	tinh_thanhpho NVARCHAR(100)
);

CREATE TABLE MaGiamGia(
	MaGiamGia CHAR(9) PRIMARY KEY,
	phantramGiamgia NUMERIC(3,0) NOT NULL,
	ThoiGianBatdau DATETIME,
	ThoiGianKetThuc DATETIME
);

CREATE TABLE PhuongThucThanhToan(
	MaPTTT CHAR(9) PRIMARY KEY,
);

CREATE TABLE ThanhToanKhiNhanHang(
	MaKhiNhanHang CHAR(9) PRIMARY KEY
);

CREATE TABLE ThanhToanTheATM(
	MaATM CHAR(9) PRIMARY KEY,
	NganHang NVARCHAR(15)
);

CREATE TABLE ThanhToanTheTinDung(
	MaTheTinDung CHAR(9) PRIMARY KEY
);


CREATE TABLE ChiNhanh(
	MaChiNhanh NUMERIC(4,0) PRIMARY KEY,
	sonha NVARCHAR(100),   --40 phan chau trinh
	quan_huyen NVARCHAR(100),
	tinh_thanhpho NVARCHAR(100),
	TenChiNhanh NVARCHAR(100)
);

CREATE TABLE LoaiSanPham(
	MaChiNhanh NUMERIC(4,0),
	Model VARCHAR(15),
	Soluong INT CHECK (Soluong>=0),
	PRIMARY KEY(MaChiNhanh,Model)
);

CREATE TABLE DacDiemSanPham(
	Model VARCHAR(15),
	tenthongso NVARCHAR(25),
	giaTri NVARCHAR(25),
	PRIMARY KEY(Model,tenthongso)
);

CREATE TABLE DanhMuc_co_NSX(
	TenDanhMuc NVARCHAR(100),
	TenNSX NVARCHAR(15),
	PRIMARY KEY (TenDanhMuc,TenNSX)
);

CREATE TABLE KH_danhGia_sanpham(
	ID_KH NUMERIC(9,0),
	Model VARCHAR(15),
	diemDanhGia INT CHECK (diemDanhGia IN (0,1,2,3,4,5)),
	PRIMARY KEY(ID_KH,Model)
);

CREATE TABLE KH_dung_magiamgia(
	MaDonHang CHAR(9),
	MaCode CHAR(9),
	ID_KH NUMERIC(9,0),
	daSuDung BIT DEFAULT 0 CHECK (daSuDung IN (1,0)) ,
	PRIMARY KEY(MaDonHang,MaCode)
);

CREATE TABLE CO_loaiSP_NVXL_NGH_donHang(
	Model VARCHAR(15),
	MaDonHang CHAR(9),
	CMND_NGH  NUMERIC(9,0),
	ID_NVXuli NUMERIC(9,0),
	PRIMARY KEY (Model,MaDonHang,CMND_NGH)
);

CREATE TABLE BinhLuan(
	ID_BinhLuan NUMERIC(9,0) PRIMARY KEY,
	NgayGio DATETIME,
	NoiDung NTEXT,
	ID_KH NUMERIC(9,0),
	Model VARCHAR(15)
);

CREATE TABLE KH_xacNhan_donHang(
	ID_KH NUMERIC(9,0),
	MaDonHang CHAR(9),
	ID_PTTT CHAR(9),
	PRIMARY KEY (ID_KH,MaDonHang)
);

CREATE TABLE chiNhanh_vanchuyen_donhang(
	MaDonHang CHAR(9),
	MaChiNhanh NUMERIC(4,0),
	PRIMARY KEY (MaDonHang,MaChiNhanh)
);

CREATE TABLE ThongTinNhapKho (
	ID_NVNK NUMERIC(9,0),
	Machinhanh NUMERIC(4,0),
	Model VARCHAR(15),
	NgayGio DATETIME,
	soLuong INT CHECK (soLuong>=0),
	PRIMARY KEY(ID_NVNK,Machinhanh,Model,NgayGio)
);

CREATE TABLE ThongTinSanPham(
	Model VARCHAR(15) PRIMARY KEY,
	TenDanhMuc NVARCHAR(100),
	TenNSX NVARCHAR(15),
	giaTien MONEY,
	HinhAnh VARCHAR(300),
	TenSanPham NVARCHAR(100),
	xuatSu NVARCHAR(15),
	dacdiemNoiBat NVARCHAR(400),
	namRaMat NUMERIC(4,0),
	ThoiGianBaoHanh NVARCHAR(10),
	MauSac NVARCHAR(15)
);
GO


--add foreign KEY
ALTER TABLE dbo.KhachHang ADD CONSTRAINT FK_KH_TK FOREIGN KEY(ID_khachhang)
REFERENCES dbo.TaiKhoan(ID_taikhoan) ON UPDATE CASCADE

ALTER TABLE dbo.NhanVien ADD CONSTRAINT FK_NV_TK FOREIGN KEY (ID_nhanvien)
REFERENCES dbo.TaiKhoan(ID_taikhoan) ON UPDATE CASCADE

ALTER TABLE dbo.NhanVienNhapKho ADD CONSTRAINT FK_NVNK_NV FOREIGN KEY(ID_NVNK)
REFERENCES dbo.NhanVien(ID_nhanvien) ON UPDATE CASCADE

ALTER TABLE dbo.NhanVienXuLi ADD CONSTRAINT FK_NVXL_NV FOREIGN KEY (ID_NVXL)
REFERENCES dbo.NhanVien(ID_nhanvien) ON UPDATE CASCADE

ALTER TABLE dbo.NhanVienTuVan ADD CONSTRAINT FK_NVTV_NV FOREIGN KEY(ID_NVTV)
REFERENCES dbo.NhanVien(ID_nhanvien) ON UPDATE CASCADE

ALTER TABLE dbo.DanhMuc ADD CONSTRAINT FK_danhmuc_dmcha FOREIGN KEY (danhmuccha)
REFERENCES dbo.DanhMuc(Tendanhmuc) 

ALTER TABLE dbo.sdt_NguoiGiaoHang ADD CONSTRAINT FK_sdt_NGH FOREIGN KEY(CMND)
REFERENCES dbo.NguoiGiaoHang(CMND) ON UPDATE CASCADE

ALTER TABLE dbo.ThanhToanKhiNhanHang ADD CONSTRAINT FK_TTKNH_PTTT FOREIGN KEY(MaKhiNhanHang)
REFERENCES dbo.PhuongThucThanhToan(MaPTTT) ON UPDATE CASCADE

ALTER TABLE dbo.ThanhToanTheATM ADD CONSTRAINT FK_TTTATM_PTTT FOREIGN KEY(MaATM)
REFERENCES dbo.PhuongThucThanhToan(MaPTTT) ON UPDATE CASCADE

ALTER TABLE dbo.ThanhToanTheTinDung ADD CONSTRAINT FK_TTTTD_PTTT FOREIGN KEY(MaTheTinDung)
REFERENCES dbo.PhuongThucThanhToan(MaPTTT) ON UPDATE CASCADE

ALTER TABLE dbo.LoaiSanPham ADD CONSTRAINT FK_LSP_CN FOREIGN KEY(MaChiNhanh)
REFERENCES dbo.ChiNhanh(MaChiNhanh) ON UPDATE CASCADE

ALTER TABLE dbo.LoaiSanPham ADD CONSTRAINT FK_LSP_Model FOREIGN KEY(Model)
REFERENCES dbo.ThongTinSanPham(Model);

ALTER TABLE dbo.DacDiemSanPham ADD CONSTRAINT FK_DDSP_LSP FOREIGN KEY (Model)
REFERENCES dbo.ThongTinSanPham(Model) ON UPDATE CASCADE

ALTER TABLE dbo.DanhMuc_co_NSX ADD CONSTRAINT FK_DMCNSX_TDM1 FOREIGN KEY(TenDanhMuc)
REFERENCES dbo.DanhMuc(Tendanhmuc) ON UPDATE CASCADE

ALTER TABLE dbo.DanhMuc_co_NSX ADD CONSTRAINT FK_DMCNSX_tenNSX FOREIGN KEY(TenNSX)
REFERENCES dbo.NhaSanxuat(tenNSX) ON UPDATE CASCADE

ALTER TABLE dbo.KH_danhGia_sanpham ADD CONSTRAINT FK_KHDGSP_IDKH FOREIGN KEY(ID_KH)
REFERENCES dbo.KhachHang(ID_khachhang) ON UPDATE CASCADE

ALTER TABLE dbo.KH_danhGia_sanpham ADD CONSTRAINT FK_KHDGSP_Model FOREIGN KEY (Model)
REFERENCES dbo.ThongTinSanPham(Model) ON UPDATE CASCADE

ALTER TABLE dbo.CO_loaiSP_NVXL_NGH_donHang ADD CONSTRAINT FK_CO_MCN FOREIGN KEY(Model)
REFERENCES dbo.ThongTinSanPham(Model) ON UPDATE CASCADE

ALTER TABLE dbo.CO_loaiSP_NVXL_NGH_donHang ADD CONSTRAINT FK_CO_Madon FOREIGN KEY(MaDonHang)
REFERENCES dbo.DonHang(MaDonHang) ON UPDATE CASCADE

ALTER TABLE dbo.CO_loaiSP_NVXL_NGH_donHang ADD CONSTRAINT FK_CO_CMND FOREIGN KEY(CMND_NGH)
REFERENCES dbo.NguoiGiaoHang(CMND) ON UPDATE CASCADE

ALTER TABLE dbo.CO_loaiSP_NVXL_NGH_donHang ADD CONSTRAINT FK_CO_IDNVXL FOREIGN KEY(ID_NVXuli)
REFERENCES dbo.NhanVienXuLi(ID_NVXL) 

ALTER TABLE dbo.KH_dung_magiamgia ADD CONSTRAINT FK_KHDMGG_MDH FOREIGN KEY(MaDonHang)
REFERENCES dbo.DonHang(MaDonHang) ON UPDATE CASCADE

ALTER TABLE dbo.KH_dung_magiamgia ADD CONSTRAINT FK_KHDMGG_MaCode FOREIGN KEY(MaCode)
REFERENCES dbo.MaGiamGia(MaGiamGia) ON UPDATE CASCADE

ALTER TABLE dbo.KH_dung_magiamgia ADD CONSTRAINT FK_KHDMGG_IDKH FOREIGN KEY (ID_KH)
REFERENCES dbo.KhachHang(ID_khachhang) ON UPDATE CASCADE

ALTER TABLE dbo.BinhLuan ADD CONSTRAINT FK_BL_IDKH FOREIGN KEY(ID_KH)
REFERENCES dbo.KhachHang (ID_khachhang) ON UPDATE CASCADE

ALTER TABLE dbo.BinhLuan ADD CONSTRAINT FK_BL_Model FOREIGN KEY(Model)
REFERENCES dbo.ThongTinSanPham(Model)

ALTER TABLE dbo.KH_xacNhan_donHang ADD CONSTRAINT FK_KHXNDH_IDKH FOREIGN KEY(ID_KH)
REFERENCES dbo.KhachHang(ID_khachhang) ON UPDATE CASCADE

ALTER TABLE dbo.KH_xacNhan_donHang ADD CONSTRAINT FK_KHXNDH_MDH FOREIGN KEY(MaDonHang)
REFERENCES dbo.DonHang(MaDonHang) ON UPDATE CASCADE

ALTER TABLE dbo.KH_xacNhan_donHang ADD CONSTRAINT FK_KHXNDH_IDPTTT FOREIGN KEY(ID_PTTT)
REFERENCES dbo.PhuongThucThanhToan(MaPTTT) ON UPDATE CASCADE

ALTER TABLE dbo.chiNhanh_vanchuyen_donhang ADD CONSTRAINT FK_CNVCDH_MDH FOREIGN KEY(MaDonHang)
REFERENCES dbo.DonHang(MaDonHang) ON UPDATE CASCADE

ALTER TABLE dbo.chiNhanh_vanchuyen_donhang ADD CONSTRAINT FK_CNVCDH_MCN FOREIGN KEY(MaChiNhanh)
REFERENCES dbo.ChiNhanh(MaChiNhanh) ON UPDATE CASCADE

ALTER TABLE dbo.NhanVienNhapKho ADD CONSTRAINT FK_NVNK_machinhanh FOREIGN KEY(Machinhanh)
REFERENCES dbo.ChiNhanh(MaChiNhanh)

ALTER TABLE dbo.ThongTinNhapKho ADD CONSTRAINT FK_TTNK_IDNVNK FOREIGN KEY(ID_NVNK)
REFERENCES dbo.NhanVienNhapKho(ID_NVNK)

ALTER TABLE dbo.ThongTinNhapKho ADD CONSTRAINT FK_TTNK_cn FOREIGN KEY(Machinhanh)
REFERENCES dbo.ChiNhanh(MaChiNhanh)

ALTER TABLE dbo.ThongTinNhapKho ADD CONSTRAINT FK_TTNK_ttsp FOREIGN KEY(Model)
REFERENCES dbo.ThongTinSanPham(Model)

ALTER TABLE dbo.ThongTinSanPham ADD CONSTRAINT FK_TTSP_TDM FOREIGN KEY(TenDanhMuc)
REFERENCES dbo.DanhMuc(Tendanhmuc)

ALTER TABLE dbo.ThongTinSanPham ADD CONSTRAINT FK_TTSP FOREIGN KEY (TenNSX)
REFERENCES dbo.NhaSanxuat(tenNSX)
GO

--check
ALTER TABLE dbo.MaGiamGia ADD CONSTRAINT check_tg CHECK (ThoiGianBatdau<ThoiGianKetThuc)
GO

--create index
CREATE INDEX search_tenLoaisp ON dbo.ThongTinSanPham(TenSanPham) 
GO

--insert values into a specific table
--insert table account:: 100 accounts
DECLARE @count INT 
SET @count=1
WHILE (@count<=9)
BEGIN
    INSERT INTO dbo.TaiKhoan VALUES (@count,'nguyenvan'+STR(@count,1),123456789,NULL,NULL,NULL,NULL)
	SET @count=@count+1
END
WHILE (@count<=99)
BEGIN
    INSERT INTO dbo.TaiKhoan VALUES (@count,'nguyenvan'+STR(@count,2),123456789,NULL,NULL,NULL,NULL)
	SET @count=@count+1
END
INSERT INTO dbo.TaiKhoan VALUES (@count,'nguyenvan'+STR(@count,3),123456789,NULL,NULL,NULL,NULL)
GO

--insert into table staff: ID 1-50
DECLARE @count INT
SET @count=1
WHILE (@count<=50)
BEGIN
    INSERT INTO NhanVien VALUES (@count,N'Cử nhân')
	SET @count=@count+1
END
GO

--insert into table Nhan vien nhap kho: ID 1-5
INSERT INTO NhanVienNhapKho VALUES(1,54,1)
INSERT INTO NhanVienNhapKho VALUES(2,43,1)
INSERT INTO NhanVienNhapKho VALUES(3,48,2)
INSERT INTO NhanVienNhapKho VALUES(4,45,3)
INSERT INTO NhanVienNhapKho VALUES(5,50,4)
GO

--insert into table NhanVienTuVan: ID 6-15
INSERT INTO NhanVienTuVan VALUES(6,N'Giỏi')
INSERT INTO NhanVienTuVan VALUES(7,N'Khá')
INSERT INTO NhanVienTuVan VALUES(8,N'Trung Bình')
INSERT INTO NhanVienTuVan VALUES(9,N'Khá')
INSERT INTO NhanVienTuVan VALUES(10,N'Khá')
INSERT INTO NhanVienTuVan VALUES(11,N'Khá')
INSERT INTO NhanVienTuVan VALUES(12,N'Trung Bình')
INSERT INTO NhanVienTuVan VALUES(13,N'Giỏi')
INSERT INTO NhanVienTuVan VALUES(14,N'Xuất sắc')
INSERT INTO NhanVienTuVan VALUES(15,N'Khá')
GO

--insert into table NhanVienXuLi: ID 20-40
INSERT INTO NhanVienXuLi VALUES(20,53);
INSERT INTO NhanVienXuLi VALUES(21,41);
INSERT INTO NhanVienXuLi VALUES(22,45);
INSERT INTO NhanVienXuLi VALUES(23,39);
INSERT INTO NhanVienXuLi VALUES(24,51);
INSERT INTO NhanVienXuLi VALUES(25,47);
INSERT INTO NhanVienXuLi VALUES(26,47);
INSERT INTO NhanVienXuLi VALUES(27,60);
INSERT INTO NhanVienXuLi VALUES(28,54);
INSERT INTO NhanVienXuLi VALUES(29,56);
INSERT INTO NhanVienXuLi VALUES(30,58);
INSERT INTO NhanVienXuLi VALUES(31,46);
INSERT INTO NhanVienXuLi VALUES(32,54);
INSERT INTO NhanVienXuLi VALUES(33,45);
INSERT INTO NhanVienXuLi VALUES(34,36);
INSERT INTO NhanVienXuLi VALUES(35,47);
INSERT INTO NhanVienXuLi VALUES(36,60);
INSERT INTO NhanVienXuLi VALUES(37,57);
INSERT INTO NhanVienXuLi VALUES(38,58);
INSERT INTO NhanVienXuLi VALUES(39,45);
INSERT INTO NhanVienXuLi VALUES(40,46);
GO

--insert into table NguoiGiaoHang
INSERT INTO NguoiGiaoHang VALUES (215557324,N'Nguyễn Văn Tèo');
INSERT INTO NguoiGiaoHang VALUES (215577324,N'Nguyễn Tèo');
INSERT INTO NguoiGiaoHang VALUES (217557324,N'Nguyễn Thị É');
INSERT INTO NguoiGiaoHang VALUES (219557324,N'Trần Tèo');
INSERT INTO NguoiGiaoHang VALUES (215457324,N'Chí Phèo');
INSERT INTO NguoiGiaoHang VALUES (215657324,N'Mai Linh');
INSERT INTO NguoiGiaoHang VALUES (215557724,N'Hồ Thị Ly');
INSERT INTO NguoiGiaoHang VALUES (215552324,N'Trương Vô Kị');
INSERT INTO NguoiGiaoHang VALUES (255557324,N'Quách Tị');
INSERT INTO NguoiGiaoHang VALUES (285557324,N'Nguyễn Phùng');
INSERT INTO NguoiGiaoHang VALUES (115657324,N'Sơn Tùng');
INSERT INTO NguoiGiaoHang VALUES (45657324,N'Đặng Thị Lài');
INSERT INTO NguoiGiaoHang VALUES (215657324,N'Trần Quốc Toản');
INSERT INTO NguoiGiaoHang VALUES (375657324,N'Lương Lẹo');
GO
--insert into sdt NguoiGIaoHang
INSERT INTO sdt_NguoiGiaoHang VALUES (215557324,'0339331754');
INSERT INTO sdt_NguoiGiaoHang VALUES (215577324,'0335335754');
INSERT INTO sdt_NguoiGiaoHang VALUES (217557324,'0988174125');
INSERT INTO sdt_NguoiGiaoHang VALUES (219557324,'0335605794');
INSERT INTO sdt_NguoiGiaoHang VALUES (215657324,'0455501364');
INSERT INTO sdt_NguoiGiaoHang VALUES (215657324,'0345125426');
INSERT INTO sdt_NguoiGiaoHang VALUES (215557724,'0984512451');
INSERT INTO sdt_NguoiGiaoHang VALUES (215552324,'0451223432');
INSERT INTO sdt_NguoiGiaoHang VALUES (255557324,'0762632533');
INSERT INTO sdt_NguoiGiaoHang VALUES (285557324,'0485462156');
INSERT INTO sdt_NguoiGiaoHang VALUES (115657324,'0542356325');
INSERT INTO sdt_NguoiGiaoHang VALUES (45657324,'0412463256');
INSERT INTO sdt_NguoiGiaoHang VALUES (215657324,'0335615624');
INSERT INTO sdt_NguoiGiaoHang VALUES (375657324,'0982325326');
INSERT INTO sdt_NguoiGiaoHang VALUES (375657324,'0961521531');
INSERT INTO sdt_NguoiGiaoHang VALUES (375657324,'0707232332');
INSERT INTO sdt_NguoiGiaoHang VALUES (45657324,'0554262163');
INSERT INTO sdt_NguoiGiaoHang VALUES (215557324,'0975146213');
INSERT INTO sdt_NguoiGiaoHang VALUES (215557324,'0909542153');
INSERT INTO sdt_NguoiGiaoHang VALUES (215552324,'0907226353');
GO

--insert into table ChiNhanh
INSERT INTO ChiNhanh VALUES(1,N'80 Trần Quốc Toản',N'Đắc Nông',N'DakLak',N'Chi nhánh 1');
INSERT INTO ChiNhanh VALUES(2,N'43 Nguyễn Chí Thanh',N'Mê Linh',N'Hà Nội',N'Chi nhánh 2');
INSERT INTO ChiNhanh VALUES(3,N'52 Quang Trung',N'Phù Cát',N'Bình Định',N'Chi nhánh 3');
INSERT INTO ChiNhanh VALUES(4,N'99 Lê Lợi',N'Bình Chánh',N'Hồ Chí Minh',N'Chi nhánh 4');
INSERT INTO ChiNhanh VALUES(5,N'146 Phan Văn Trị',N'Sơn Trà',N'Đà Nẵng',N'Chi nhánh 5');
GO

--insert into table DANHMUC
INSERT INTO DanhMuc VALUES (N'Tủ lạnh',NULL);
INSERT INTO DanhMuc VALUES(N'Tivi',NULL);
INSERT INTO DanhMuc VALUES(N'Máy giặt',NULL);
INSERT INTO DanhMuc VALUES(N'Điện thoại',NULL);
INSERT INTO DanhMuc VALUES(N'Laptop',NULL);
INSERT INTO DanhMuc VALUES(N'Máy lạnh',NULL);
INSERT INTO DanhMuc VALUES(N'Tủ Lạnh-Tủ Đông-Tủ Mát',NULL);
INSERT INTO DanhMuc VALUES(N'Tivi-Loa-Dàn loa',NULL);
INSERT INTO DanhMuc VALUES(N'Máy giặt- Máy nước nóng',NULL);
INSERT INTO DanhMuc VALUES(N'Điện thoại- Tablet- Phụ Kiện',NULL);
INSERT INTO DanhMuc VALUES(N'Máy Lạnh-Máy lọc khí',NULL);
INSERT INTO DanhMuc VALUES(N'Laptop- PC- Máy in- Phụ kiện',NULL);
go
UPDATE dbo.DanhMuc SET danhmuccha=N'Tủ Lạnh-Tủ Đông-Tủ Mát'
WHERE Tendanhmuc=N'Tủ lạnh';
UPDATE dbo.DanhMuc SET danhmuccha=N'Tivi-Loa-Dàn loa'
WHERE Tendanhmuc=N'Tivi';
UPDATE dbo.DanhMuc SET danhmuccha=N'Máy giặt- Máy nước nóng'
WHERE Tendanhmuc=N'Máy giặt';
UPDATE dbo.DanhMuc SET danhmuccha=N'Điện thoại- Tablet- Phụ Kiện'
WHERE Tendanhmuc=N'Điện thoại';
UPDATE dbo.DanhMuc SET danhmuccha=N'Laptop- PC- Máy in- Phụ kiện'
WHERE Tendanhmuc=N'Laptop';
UPDATE dbo.DanhMuc SET danhmuccha=N'Máy Lạnh-Máy lọc khí'
WHERE Tendanhmuc=N'Máy lạnh';
go


--insert into table NSX
INSERT INTO NhaSanXuat VALUES ('Samsung')
INSERT INTO NhaSanXuat VALUES ('Panasonic')
INSERT INTO NhaSanXuat VALUES ('Sharp')
INSERT INTO NhaSanXuat VALUES ('Aqua')
INSERT INTO NhaSanXuat VALUES ('Toshiba')
INSERT INTO NhaSanXuat VALUES ('LG')
INSERT INTO NhaSanXuat VALUES ('Mitsubishi')
INSERT INTO NhaSanXuat VALUES ('Sony')
go

--insert into Table ThongTinSanPham
INSERT INTO dbo.ThongTinSanPham
VALUES
(   'RT20HAR8DBU',   -- Model - varchar(15)
    N'Tủ lạnh',  -- TenDanhMuc - nvarchar(100)
    N'Samsung',  -- TenNSX - nvarchar(15)
    5600000, -- giaTien - money
    'https://cdn.nguyenkimmall.com/images/detailed/640/10045345-tu-lanh-samsung-inverter-208l-rt20har8dbu-1.jpg',   -- HinhAnh - varchar(300)
    N'Tủ lạnh Samsung Inverter 208 lít RT20HAR8DBU',  -- TenSanPham - nvarchar(100)
    N'Việt Nam',  -- xuatSu - nvarchar(15)
    N'Dung tích 208 lít thích hợp cho gia đình từ 2 - 3 thành viên/Công nghệ Digital Inverter hoạt động êm ái, tiết kiệm điện ',  -- dacdiemNoiBat - nvarchar(400)
    2020, -- namRaMat - numeric(4, 0)
    N'24 tháng',  -- ThoiGianBaoHanh - nvarchar(10)
    N'Đen'   -- MauSac - nvarchar(15)
    )
INSERT INTO dbo.ThongTinSanPham
VALUES
(   'BL300PKVN',   -- Model - varchar(15)
    N'Tủ lạnh',  -- TenDanhMuc - nvarchar(100)
    N'Panasonic',  -- TenNSX - nvarchar(15)
    10490000, -- giaTien - money
    'https://cdn.nguyenkimmall.com/images/thumbnails/600/336/detailed/552/10038524-tu-lanh-panasonic-inverter-268l-nr-bl300pkvn-1.jpg',   -- HinhAnh - varchar(300)
    N'Tủ lạnh Panasonic Inverter 268 lít NR-BL300PKVN',  -- TenSanPham - nvarchar(30)
    N'Việt Nam',  -- xuatSu - nvarchar(15)
    N'Cảm biến Econavi nâng cao hiệu quả tiết kiệm điện/Hệ thống Ag Clean loại bỏ vi khuẩn, khử mùi hiệu quả',  -- dacdiemNoiBat - nvarchar(80)
    2020, -- namRaMat - numeric(4, 0)
    N'24 tháng',  -- ThoiGianBaoHanh - nvarchar(10)
    N'Đen ánh kim'   -- MauSac - nvarchar(15)
    )
INSERT INTO dbo.ThongTinSanPham
VALUES
(   'KDL-50W660G',   -- Model - varchar(15)
    N'Tivi',  -- TenDanhMuc - nvarchar(100)
    N'Sony',  -- TenNSX - nvarchar(15)
    9950000, -- giaTien - money
    'https://cdn.nguyenkimmall.com/images/thumbnails/600/336/detailed/582/10041655-smart-tivi-sony-50-inch-kdl-50w660g-2_ak74-83.jpg',   -- HinhAnh - varchar(300)
    N'Smart Tivi Sony 50 inch KDL-50W660G VN3',  -- TenSanPham - nvarchar(30)
    N'Malaysia',  -- xuatSu - nvarchar(15)
    N'Xem nội dung từ smartphone trên tivi nhờ Smart Plug & Play/Công nghệ X-Protection PRO chống bụi, chống ẩm, chống sét,...',  -- dacdiemNoiBat - nvarchar(400)
    2019, -- namRaMat - numeric(4, 0)
    N'24 tháng',  -- ThoiGianBaoHanh - nvarchar(10)
    N'Đen'   -- MauSac - nvarchar(15)
    )

INSERT INTO dbo.ThongTinSanPham
VALUES
(   '14Z90N-VAR52A5',   -- Model - varchar(15)
    N'Laptop',  -- TenDanhMuc - nvarchar(100)
    N'LG',  -- TenNSX - nvarchar(15)
    25500000, -- giaTien - money
    'https://cdn.nguyenkimmall.com/images/thumbnails/1024/717/product/731/10046970-lg-gram-i5-1035g7-14-inch-14z90n-v-ar52a5-1.jpg',   -- HinhAnh - varchar(300)
    N'Laptop LG Gram i5-1035G7 14 inch 14Z90N-V.AR52A5',  -- TenSanPham - nvarchar(30)
    N'Trung Quốc',  -- xuatSu - nvarchar(15)
    N'Xem nội dung từ smartphone trên tivi nhờ Smart Plug & Play/Công nghệ X-Protection PRO chống bụi, chống ẩm, chống sét,...',  -- dacdiemNoiBat - nvarchar(400)
    2020, -- namRaMat - numeric(4, 0)
    N'12 tháng',  -- ThoiGianBaoHanh - nvarchar(10)
    N'Bạc'   -- MauSac - nvarchar(15)
    )

--insert into table LoaiSanPham
INSERT INTO LoaiSanPham VALUES (
	1, -- MaChiNhanh - numeric(4, 0)
    'RT20HAR8DBU',   -- Model - varchar(15)
    4   
);
INSERT INTO LoaiSanPham VALUES (
	4, -- MaChiNhanh - numeric(4, 0)
    '14Z90N-VAR52A5',   -- Model - varchar(15)
    5   
);
INSERT INTO LoaiSanPham VALUES (
	3, -- MaChiNhanh - numeric(4, 0)
    '14Z90N-VAR52A5',   -- Model - varchar(15)
    6   
);
INSERT INTO LoaiSanPham VALUES (
	1, -- MaChiNhanh - numeric(4, 0)
    '14Z90N-VAR52A5',   -- Model - varchar(15)
    10   
);
INSERT INTO LoaiSanPham VALUES (
	2, -- MaChiNhanh - numeric(4, 0)
    '14Z90N-VAR52A5',   -- Model - varchar(15)
    9   
);

INSERT INTO LoaiSanPham
VALUES
(   2, -- MaChiNhanh - numeric(4, 0)
    'BL300PKVN',   -- Model - varchar(15)
    9  
    )
INSERT INTO LoaiSanPham
VALUES
(   1, -- MaChiNhanh - numeric(4, 0)
    'BL300PKVN',   -- Model - varchar(15)
    8
)
INSERT INTO LoaiSanPham
VALUES
(   4, -- MaChiNhanh - numeric(4, 0)
    'KDL-50W660G',   -- Model - varchar(15)
    7
    )
go;

--insert into table ThongTinNhapKho
INSERT INTO dbo.ThongTinNhapKho
VALUES
(   5,      -- ID_NVNK - numeric(9, 0)
    4,      -- Machinhanh - numeric(4, 0)
    'KDL-50W660G',        -- Model - varchar(15)
    GETDATE(), -- NgayGio - datetime
    2          -- soLuong - int
)
INSERT INTO dbo.ThongTinNhapKho
VALUES
(   5,      -- ID_NVNK - numeric(9, 0)
    4,      -- Machinhanh - numeric(4, 0)
    'KDL-50W660G',        -- Model - varchar(15)
    GETDATE(), -- NgayGio - datetime
    2        -- soLuong - int
)

INSERT INTO dbo.ThongTinNhapKho
VALUES
(   3,      -- ID_NVNK - numeric(9, 0)
    2,      -- Machinhanh - numeric(4, 0)
    'BL300PKVN',        -- Model - varchar(15)
    GETDATE(), -- NgayGio - datetime
    3         -- soLuong - int
)
INSERT INTO dbo.ThongTinNhapKho
VALUES
(   3,      -- ID_NVNK - numeric(9, 0)
    2,      -- Machinhanh - numeric(4, 0)
    'BL300PKVN',        -- Model - varchar(15)
    GETDATE(), -- NgayGio - datetime
    4         -- soLuong - int
)

INSERT INTO dbo.ThongTinNhapKho
VALUES
(   1,      -- ID_NVNK - numeric(9, 0)
    1,      -- Machinhanh - numeric(4, 0)
    'BL300PKVN',        -- Model - varchar(15)
    GETDATE(), -- NgayGio - datetime
    5         -- soLuong - int
)
INSERT INTO dbo.ThongTinNhapKho
VALUES
(   2,      -- ID_NVNK - numeric(9, 0)
    1,      -- Machinhanh - numeric(4, 0)
    'BL300PKVN',        -- Model - varchar(15)
    GETDATE(), -- NgayGio - datetime
    3        -- soLuong - int
)
INSERT INTO dbo.ThongTinNhapKho
VALUES
(   2,      -- ID_NVNK - numeric(9, 0)
    1,      -- Machinhanh - numeric(4, 0)
    'BL300PKVN',        -- Model - varchar(15)
    GETDATE(), -- NgayGio - datetime
    1         -- soLuong - int
)
INSERT INTO dbo.ThongTinNhapKho
VALUES
(   1,      -- ID_NVNK - numeric(9, 0)
    1,      -- Machinhanh - numeric(4, 0)
    '14Z90N-VAR52A5',        -- Model - varchar(15)
    GETDATE(), -- NgayGio - datetime
    3          -- soLuong - int
    )
INSERT INTO dbo.ThongTinNhapKho
VALUES
(   2,      -- ID_NVNK - numeric(9, 0)
    1,      -- Machinhanh - numeric(4, 0)
    '14Z90N-VAR52A5',        -- Model - varchar(15)
    GETDATE(), -- NgayGio - datetime
    1          -- soLuong - int
    )














/*
--trigger
-- 
CREATE TRIGGER TG_nhaphang_insert ON ThongTinNhapKho AFTER INSERT AS 
BEGIN
	DECLARE @a NUMERIC(4,0)
	SET @a=(SELECT MaChiNhanh FROM inserted)
	DECLARE @b VARCHAR(15)
	SET @b=(SELECT Model FROM inserted)
	IF (EXISTS(SELECT * FROM(dbo.LoaiSanPham JOIN inserted ON 
		dbo.LoaiSanPham.MaChiNhanh=@a
	     AND dbo.LoaiSanPham.Model=@b))
	)
		BEGIN
		UPDATE dbo.LoaiSanPham
		SET Soluong=Soluong + (
			SELECT Soluong
			FROM inserted
			WHERE MaChiNhanh=dbo.LoaiSanPham.MaChiNhanh AND Model=dbo.LoaiSanPham.Model
		)
		WHERE dbo.LoaiSanPham.MaChiNhanh=@a
			 AND dbo.LoaiSanPham.Model=@b
		END
	ELSE
		BEGIN
		INSERT INTO dbo.LoaiSanPham
		VALUES (@a,@b,(SELECT Soluong FROM inserted))
		END
END

--
CREATE TRIGGER TG_nhapHang_delete on ThongTinNhapKho for DELETE AS
BEGIN
	UPDATE dbo.LoaiSanPham
	SET Soluong=Soluong-(
		SELECT Soluong
		FROM deleted
		WHERE MaChiNhanh=dbo.LoaiSanPham.MaChiNhanh AND Model=dbo.LoaiSanPham.Model
	)
	WHERE dbo.LoaiSanPham.MaChiNhanh=(SELECT MaChiNhanh FROM deleted)
		AND dbo.LoaiSanPham.Model=(SELECT Model FROM deleted)
END
--
CREATE TRIGGER TG_nhapHang_update ON ThongTinNhapKho AFTER UPDATE AS 
BEGIN
	UPDATE dbo.LoaiSanPham
	SET Soluong=Soluong + (
		SELECT Soluong
		FROM inserted
		WHERE MaChiNhanh=dbo.LoaiSanPham.MaChiNhanh AND Model=dbo.LoaiSanPham.Model
	)- (
		SELECT Soluong
		FROM deleted
		WHERE MaChiNhanh=dbo.LoaiSanPham.MaChiNhanh AND Model=dbo.LoaiSanPham.Model
	)
    WHERE dbo.LoaiSanPham.MaChiNhanh=(SELECT MaChiNhanh FROM deleted)
		AND dbo.LoaiSanPham.Model=(SELECT Model FROM deleted)
END
--
*/





















