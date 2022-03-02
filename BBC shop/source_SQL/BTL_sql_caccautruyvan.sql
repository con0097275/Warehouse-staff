--cau 1:
--a.	2 Câu truy vấn từ 2 bảng trở lên có mệnh đề where, order by
--cho biết tên sản phẩm có mã Model là BL300PKVN và tên chi nhánh hiện đang có bán loại sản phẩm đó sắp xếp theo thứ tự giảm dần theo tên chi nhánh
SELECT TenSanPham,TenChiNhanh FROM dbo.ChiNhanh,dbo.LoaiSanPham,dbo.ThongTinSanPham
WHERE dbo.ChiNhanh.MaChiNhanh=dbo.LoaiSanPham.MaChiNhanh 
	AND dbo.LoaiSanPham.Model=dbo.ThongTinSanPham.Model
	AND ThongTinSanPham.Model= 'BL300PKVN' AND Soluong>0
ORDER BY TenChiNhanh DESC

SELECT * FROM dbo.LoaiSanPham

--cho biết tên sản phẩm và tên chi nhánh hiện có số lượng 1 loại sản phẩm lớn hơn 30 sắp xếp theo thứ tự tăng dần tên chi nhảnh
SELECT TenSanPham,TenChiNhanh FROM dbo.ChiNhanh,dbo.LoaiSanPham,dbo.ThongTinSanPham
WHERE dbo.ChiNhanh.MaChiNhanh=dbo.LoaiSanPham.MaChiNhanh 
	AND dbo.LoaiSanPham.Model=dbo.ThongTinSanPham.Model
	AND  Soluong>30
ORDER BY TenChiNhanh ASC

--b.	2 Câu truy vấn có aggreate function, group by, having, where và order by có liên kết từ 2 bảng trở lên
SELECT * FROM dbo.LoaiSanPham
SELECT * FROM dbo.ThongTinSanPham
SELECT * FROM dbo.ThongTinNhapKho
SELECT * FROM dbo.NhanVienNhapKho
SELECT * FROM dbo.ChiNhanh

INSERT INTO dbo.ThongTinNhapKho
VALUES
(   2,      -- ID_NVNK - numeric(9, 0)
    1,      -- Machinhanh - numeric(4, 0)
    '14Z90N-VAR52A5',        -- Model - varchar(15)
    GETDATE(), -- NgayGio - datetime
    2          -- soLuong - int
    )
DELETE FROM dbo.ThongTinNhapKho
WHERE ID_NVNK=2 AND Machinhanh=1 AND Model='14Z90N-VAR52A5' AND NgayGio='2021-05-29 16:10:10.883'


-- cho biết tên chi nhánh có số lượng tủ lạnh >30 xếp theo thứ tự tăng dần số lượng tủ lạnh của chi nhánh đó
SELECT TenChiNhanh ,SUM(Soluong) AS soluongtulanh FROM dbo.LoaiSanPham, dbo.ChiNhanh,dbo.ThongTinSanPham
WHERE dbo.LoaiSanPham.Model=dbo.ThongTinSanPham.Model
	AND dbo.LoaiSanPham.MaChiNhanh=dbo.ChiNhanh.MaChiNhanh
	AND TenDanhMuc=N'Tủ lạnh'
GROUP BY ChiNhanh.TenChiNhanh
HAVING SUM(Soluong)>30
ORDER BY SUM(Soluong) ASC

--cho biết tên chi nhánh có số lượng sản phẩm có nhà xản xuất là LG>8 và sắp xếp theo thứ tự tăng dần tên chi nhánh
SELECT TenChiNhanh,SUM(Soluong) AS soluongspLG FROM dbo.LoaiSanPham,dbo.ThongTinSanPham,dbo.ChiNhanh
WHERE dbo.LoaiSanPham.Model=dbo.ThongTinSanPham.Model
	AND dbo.LoaiSanPham.MaChiNhanh=dbo.ChiNhanh.MaChiNhanh
	AND TenNSX='LG'
GROUP BY TenChiNhanh 
HAVING SUM(Soluong)>8
ORDER BY TenChiNhanh ASC



--cau 2:
--1 thủ tục để hiển thị 
--hiển thị tất cả thông tin của tất cả các loại sản phẩm trong hệ thống
CREATE PROCEDURE selectallThongtinSP
AS
SELECT * FROM dbo.ThongTinSanPham
go; 

EXEC dbo.selectallThongtinSP;

--1 thủ tục có thao tác dữ liệu với các tham số đầu vào là các trường dữ liệu cần nhập 
--hiển thị tất cả thông tin của tất cả loại sản phẩm có giá tiền trong đoạn [x,y] đồng trong hệ thống
CREATE PROCEDURE selectThongTinsp_giatienxy @x money, @y money
AS
BEGIN
	IF(@x>@y OR @x<0) BEGIN
		PRINT N'Dữ liệu Nhập sai';
	END
	ELSE BEGIN
		SELECT * FROM dbo.ThongTinSanPham
		WHERE dbo.ThongTinSanPham.giaTien >= @x AND dbo.ThongTinSanPham.giaTien<=@y
	END
END
go

--DROP PROCEDURE dbo.selectThongTinsp_giatienxy

EXEC dbo.selectThongTinsp_giatienxy @x = 8000000, -- money
                                    @y = 15000000  -- money


-- câu 3: TRigger:
-- Nhân viên nhập kho nhập thông tin số lượng vào bảng ThongTinNhapKho thì số lượng tự
--động cộng vào số lượng trong kho tương ứng(ứng với bảng LoaiSanPham)
CREATE TRIGGER TG_nhaphang_insert ON ThongTinNhapKho INSTEAD of INSERT AS 
BEGIN
	-- check xem  Nhân viên nhập kho thuộc chi nhánh nào chỉ được cập nhật sản phẩm của chi nhánh đó
	IF (NOT EXISTS(
		SELECT * FROM inserted,dbo.NhanVienNhapKho
		WHERE inserted.ID_NVNK=dbo.NhanVienNhapKho.ID_NVNK
			AND inserted.MaChiNhanh=dbo.NhanVienNhapKho.Machinhanh
	)) BEGIN
		RAISERROR('Lỗi Nhân viên nhập kho thuộc chi nhánh nào chỉ được cập nhật chi nhánh đó',15,1);
	END ELSE BEGIN
		INSERT INTO dbo.ThongTinNhapKho SELECT* FROM inserted	 
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
END
GO

--Khi nhân viên nhập kho nhập dư hoặc nhầm thông tin trong bảng ThongTinNhapKho và muốn xóa nó thì
-- Nhân viên nhập kho xóa thông tin số lượng vào bảng ThongTinNhapKho thì số lượng tự
--động được trừ vào số lượng trong kho tương ứng(ứng với bảng LoaiSanPham)
CREATE TRIGGER TG_nhapHang_delete on ThongTinNhapKho INSTEAD of DELETE AS
BEGIN
	-- check xem  Nhân viên nhập kho thuộc chi nhánh nào chỉ được cập nhật sản phẩm của chi nhánh đó
	IF (NOT EXISTS(
		SELECT * FROM deleted,dbo.NhanVienNhapKho
		WHERE deleted.ID_NVNK=dbo.NhanVienNhapKho.ID_NVNK
			AND deleted.MaChiNhanh=dbo.NhanVienNhapKho.Machinhanh
	)) BEGIN
		RAISERROR('Lỗi Nhân viên nhập kho thuộc chi nhánh nào chỉ được cập nhật chi nhánh đó',15,1);
	END ELSE BEGIN
		DELETE FROM dbo.ThongTinNhapKho WHERE dbo.ThongTinNhapKho.Model=(SELECT Model FROM deleted)
				AND dbo.ThongTinNhapKho.Machinhanh=(SELECT MaChiNhanh FROM deleted)
				AND dbo.ThongTinNhapKho.NgayGio=(SELECT NgayGio FROM deleted)
				AND dbo.ThongTinNhapKho.ID_NVNK=(SELECT ID_NVNK FROM deleted);

		UPDATE dbo.LoaiSanPham
		SET Soluong=Soluong-(
			SELECT Soluong
			FROM deleted
			WHERE MaChiNhanh=dbo.LoaiSanPham.MaChiNhanh AND Model=dbo.LoaiSanPham.Model
		)
		WHERE dbo.LoaiSanPham.MaChiNhanh=(SELECT MaChiNhanh FROM deleted)
			AND dbo.LoaiSanPham.Model=(SELECT Model FROM deleted)
	END
END
go

--Khi nhân viên nhập kho nhập sai số lượng của sản phẩm trong bảng ThongTinNhapKho thì
--nhân viên nhập kho update dữ liệu số lượng trong bảng ứng với dòng sai, sau đó số liệu sẽ được
--tính toán phù hợp với số lượng trong kho (ứng với bản LoaiSanPham)
CREATE TRIGGER TG_nhapHang_update ON ThongTinNhapKho INSTEAD of UPDATE AS 
BEGIN
	-- check xem  Nhân viên nhập kho thuộc chi nhánh nào chỉ được cập nhật sản phẩm của chi nhánh đó
	IF (NOT EXISTS(
		SELECT * FROM inserted,dbo.NhanVienNhapKho
		WHERE inserted.ID_NVNK=dbo.NhanVienNhapKho.ID_NVNK
			AND inserted.MaChiNhanh=dbo.NhanVienNhapKho.Machinhanh
	)) BEGIN
		RAISERROR('Lỗi Nhân viên nhập kho thuộc chi nhánh nào chỉ được cập nhật chi nhánh đó',15,1);
	END ELSE BEGIN
		UPDATE dbo.ThongTinNhapKho
		SET soLuong=(SELECT soLuong FROM inserted)
		WHERE dbo.ThongTinNhapKho.Model=(SELECT Model FROM deleted)
				AND dbo.ThongTinNhapKho.Machinhanh=(SELECT MaChiNhanh FROM deleted)
				AND dbo.ThongTinNhapKho.NgayGio=(SELECT NgayGio FROM deleted)
				AND dbo.ThongTinNhapKho.ID_NVNK=(SELECT ID_NVNK FROM deleted);

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
END
GO

--Câu 4: Hàm
--tính số lượng sản phẩm là loại sản phẩm @x (như tivi, tủ lạnh...) hiện đang có của chi nhánh có tên là @y
CREATE FUNCTION KTsoluongSP_xofy (@x Nvarchar(100), @y Nvarchar(40))
RETURNS int 
AS
BEGIN
	IF(@x NOT IN (SELECT TenDanhMuc FROM dbo.ThongTinSanPham)
	    OR @y NOT IN(SELECT TenChiNhanh FROM dbo.ChiNhanh)) BEGIN
		--PRINT N'Dữ liệu nhập bạn tìm không có';
		RETURN -100;
	END ELSE BEGIN
		IF (NOT EXISTS(
		SELECT * FROM dbo.LoaiSanPham,dbo.ChiNhanh,dbo.ThongTinSanPham
		WHERE dbo.LoaiSanPham.MaChiNhanh=dbo.ChiNhanh.MaChiNhanh
			AND dbo.LoaiSanPham.Model=dbo.ThongTinSanPham.Model
			AND TenDanhMuc=@x AND TenChiNhanh=@y
		)) BEGIN
			RETURN 0;
		END ELSE BEGIN
			DECLARE @z INT=0;
			SET @z=(
			SELECT sum(Soluong) FROM dbo.LoaiSanPham,dbo.ChiNhanh,dbo.ThongTinSanPham
			WHERE dbo.LoaiSanPham.MaChiNhanh=dbo.ChiNhanh.MaChiNhanh
				AND dbo.LoaiSanPham.Model=dbo.ThongTinSanPham.Model
				AND TenDanhMuc=@x AND TenChiNhanh=@y
			GROUP BY ChiNhanh.MaChiNhanh
			)
			RETURN @z;
		END
	END
	RETURN 0;
END
go;

SELECT * FROM dbo.LoaiSanPham
SELECT * FROM dbo.ThongTinSanPham


PRINT dbo.KTsoluongSP_xofy(N'Laptop',N'Chi nhánh 1'); --eq:13
PRINT dbo.KTsoluongSP_xofy(N'Tủ lạnh',N'Chi nhánh 1'); --eq:61
PRINT dbo.KTsoluongSP_xofy(N'Tủ lạnh',N'Chi nhánh 4'); --eq:0
PRINT dbo.KTsoluongSP_xofy(N'Tủ lạnh',N'Cádasdas'); --eq:-100








/*
USE master
DECLARE       @portNumber   NVARCHAR(10)
EXEC   xp_instance_regread
@rootkey    = 'HKEY_LOCAL_MACHINE',
@key        =
'Software\Microsoft\Microsoft SQL Server\MSSQLServer\SuperSocketNetLib\Tcp\IpAll',
@value_name = 'TcpDynamicPorts',
@value      = @portNumber OUTPUT
SELECT [Port Number] = @portNumber
GO
*/










