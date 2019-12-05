CREATE DATABASE QuanLyQuanCafe
GO

USE QuanLyQuanCafe
GO


-- Food do an
-- Table ban 
-- FoodCategory thuc don
-- Account tai khoang
-- Bill hoa don
-- BillInfo thong tin hoa don
-- suy nghi chuc nang dat ban trc
-- chua nhap xuat hang
CREATE TABLE TableFood
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Bàn chưa có tên',
	status NVARCHAR(100) NOT NULL DEFAULT N'Trống'	-- Trống || Có người
)
GO

CREATE TABLE Account
(
	UserName NVARCHAR(100) PRIMARY KEY,	
	DisplayName NVARCHAR(100) NOT NULL DEFAULT N'ccc',--khong duoc null 
	PassWord NVARCHAR(1000) NOT NULL DEFAULT 0,
	Type INT NOT NULL  DEFAULT 0 -- 1: admin && 0: staff
)
GO

CREATE TABLE FoodCategory
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Chưa đặt tên'
)
GO

CREATE TABLE Food
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Chưa đặt tên',
	idCategory INT NOT NULL,
	price FLOAT NOT NULL DEFAULT 0
	
	FOREIGN KEY (idCategory) REFERENCES dbo.FoodCategory(id)
)
GO

CREATE TABLE Bill
(
	id INT IDENTITY PRIMARY KEY,
	DateCheckIn DATE NOT NULL DEFAULT GETDATE(),-- ngay vao
	DateCheckOut DATE,--ngay ra
	idTable INT NOT NULL,
	status INT NOT NULL DEFAULT 0 -- 1: đã thanh toán && 0: chưa thanh toán
	
	FOREIGN KEY (idTable) REFERENCES dbo.TableFood(id)
)
GO

CREATE TABLE BillInfo
(
	id INT IDENTITY PRIMARY KEY,
	idBill INT NOT NULL,
	idFood INT NOT NULL,
	count INT NOT NULL DEFAULT 0
	
	FOREIGN KEY (idBill) REFERENCES dbo.Bill(id),
	FOREIGN KEY (idFood) REFERENCES dbo.Food(id)
)
GO
INSERT INTO dbo.Account
        ( UserName ,
          DisplayName ,
          PassWord ,
          Type
        )
VALUES  ( N'hung' , -- UserName - nvarchar(100)
          N'hung1' , -- DisplayName - nvarchar(100)
          N'1' , -- PassWord - nvarchar(1000)
          1  -- Type - int
        )
INSERT INTO dbo.Account
        ( UserName ,
          DisplayName ,
          PassWord ,
          Type
        )
VALUES  ( N'trang' , -- UserName - nvarchar(100)
          N'trang1' , -- DisplayName - nvarchar(100)
          N'1' , -- PassWord - nvarchar(1000)
          0  -- Type - int
        )
GO
       
CREATE	PROC USP_GetAccountByUserName
@userName nvarchar (100)
AS	
BEGIN	
	SELECT	* FROM	dbo.Account WHERE UserName = @userName
END	
GO

EXEC dbo.USP_GetAccountByUserName @userName = N'hung' -- nvarchar(100)
GO


CREATE PROC USP_Login
@passWord NVARCHAR(100), @userName NVARCHAR(100)
AS	
BEGIN
	SELECT * FROM dbo.Account WHERE	UserName = @userName AND PassWord = @passWord
END	
GO
DECLARE @i INT =0

WHILE @i<=20
BEGIN	
INSERT dbo.TableFood( name)
VALUES  ( N'Bàn '+ CAST(@i AS NVARCHAR(100)))
		  SET @i=@i+1
END	
GO

CREATE PROC USP_GetTableList
AS SELECT * FROM dbo.TableFood
GO
EXEC dbo.USP_GetTableList