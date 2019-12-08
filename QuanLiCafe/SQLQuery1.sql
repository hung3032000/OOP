CREATE DATABASE QuanLyQuancoffe
GO

USE QuanLyQuancoffe
GO


CREATE TABLE TableFood
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'B�n ch?a c� t�n',
	status NVARCHAR(100) NOT NULL DEFAULT N'Tr?ng'	-- Tr?ng || C� ng??i
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
	name NVARCHAR(100) NOT NULL DEFAULT N'Ch?a ??t t�n'
)
GO

CREATE TABLE Food
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Ch?a ??t t�n',
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
	status INT NOT NULL DEFAULT 0 -- 1: ?� thanh to�n && 0: ch?a thanh to�n
	
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
CREATE PROC USP_GetTableList
AS	SELECT * FROM dbo.TableFood
GO


DECLARE @i INT = 0

WHILE @i <= 20
BEGIN
	INSERT dbo.TableFood (name)VALUES  ( N'B�n ' + CAST(@i AS nvarchar(100)))
	SET @i = @i + 1
END
GO
EXEC dbo.USP_GetTableList

--th�m catagory

INSERT dbo.FoodCategory	
        ( name )
VALUES  ( N'C� ph�'  -- name - nvarchar(100)
          )
INSERT dbo.FoodCategory	
        ( name )
VALUES  ( N'Freeze'  -- name - nvarchar(100)
          )
INSERT dbo.FoodCategory	
        ( name )
VALUES  ( N'Tr�'  -- name - nvarchar(100)
)

INSERT dbo.FoodCategory	
        ( name )
VALUES  ( N'B�nh M�'  -- name - nvarchar(100)
          )		 
INSERT dbo.FoodCategory	
        ( name )
VALUES  ( N'Kh�c'  -- name - nvarchar(100)
          )
		  
INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'C� ph� phin', -- name - nvarchar(100)
          1, -- idCategory - int
          39000.0  -- price - float
          )
INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'C� ph� espresso', -- name - nvarchar(100)
          1, -- idCategory - int
          42000.0  -- price - float
          )
INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'Freze c� ph� phin', -- name - nvarchar(100)
          2, -- idCategory - int
          42000.0  -- price - float
          )
INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'Freze kh�ng c� ph�', -- name - nvarchar(100)
          2, -- idCategory - int
          35000.0  -- price - float
          )
INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'Tr� sen v�ng', -- name - nvarchar(100)
          3, -- idCategory - int
          35000.0  -- price - float
          )
INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'B�nh m� th?t n??ng', -- name - nvarchar(100)
          4, -- idCategory - int
          20000.0  -- price - float
          )
INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'N??c ng?t', -- name - nvarchar(100)
          5, -- idCategory - int
          10000.0  -- price - float
          )
--th�m bill
INSERT dbo.Bill
        ( DateCheckIn ,
          DateCheckOut ,
          idTable ,
          status
        )
VALUES  ( GETDATE() , -- DateCheckIn - date
          NULL , -- DateCheckOut - date
          1 , -- idTable - int
          0  -- status - int
        )
INSERT dbo.Bill
        ( DateCheckIn ,
          DateCheckOut ,
          idTable ,
          status
        )
VALUES  ( GETDATE() , -- DateCheckIn - date
          GETDATE() , -- DateCheckOut - date
          3 , -- idTable - int
          1  -- status - int
        )
INSERT dbo.Bill
        ( DateCheckIn ,
          DateCheckOut ,
          idTable ,
          status
        )
VALUES  ( GETDATE() , -- DateCheckIn - date
          NULL , -- DateCheckOut - date
          5 , -- idTable - int
          0  -- status - int
        )
-- th�m bill info
INSERT dbo.BillInfo
        ( idBill, idFood, count )
VALUES  ( 1, -- idBill - int
          1, -- idFood - int
          2  -- count - int
          )
INSERT dbo.BillInfo
        ( idBill, idFood, count )
VALUES  ( 2, -- idBill - int
          3, -- idFood - int
          4  -- count - int
          )
INSERT dbo.BillInfo
        ( idBill, idFood, count )
VALUES  ( 3, -- idBill - int
          4, -- idFood - int
          4  -- count - int
          )
SELECT f.name, bi.count,f.price,f.price*bi.count AS totalPrice FROM dbo.BillInfo AS bi,dbo.Bill AS b,dbo.Food AS f WHERE bi.idBill =b.id AND bi.idFood = f.id AND b.status =0 AND	b.idTable =1
SELECT * FROM	 dbo.Food

CREATE PROC USP_InsertBill
@idTable INT	
AS
BEGIN
	INSERT INTO dbo.Bill
	        ( DateCheckIn ,
	          DateCheckOut ,
	          idTable ,
	          status
	        )
	VALUES  ( GETDATE() , -- DateCheckIn - date
	          NULL , -- DateCheckOut - date
	          @idTable , -- idTable - int
	          0  -- status - int
	        )	
END
GO

CREATE PROC USP_InsertBillInfo
@idBill INT, @idFood INT, @count INT
AS
BEGIN

	DECLARE @isExitsBillInfo INT
	DECLARE @foodCount INT = 1
	
	SELECT @isExitsBillInfo = id, @foodCount = b.count 
	FROM dbo.BillInfo AS b 
	WHERE idBill = @idBill AND idFood = @idFood

	IF (@isExitsBillInfo > 0)
	BEGIN
		DECLARE @newCount INT = @foodCount + @count
		IF (@newCount > 0)
			UPDATE dbo.BillInfo	SET count = @foodCount + @count WHERE idFood = @idFood
		ELSE
			DELETE dbo.BillInfo WHERE idBill = @idBill AND idFood = @idFood
	END
	ELSE
	BEGIN
		INSERT	dbo.BillInfo
        ( idBill, idFood, count )
		VALUES  ( @idBill, -- idBill - int
          @idFood, -- idFood - int
          @count  -- count - int
          )
	END
END
GO

DELETE dbo.BillInfo

DELETE dbo.Bill

CREATE TRIGGER UTG_UpdateBillInfo
ON dbo.BillInfo FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @idBill INT
	
	SELECT @idBill = idBill FROM Inserted
	
	DECLARE @idTable INT
	
	SELECT @idTable = idTable FROM dbo.Bill WHERE id = @idBill AND status = 0
	
	UPDATE dbo.TableFood SET status = N'C� ng??i' WHERE id = @idTable
END
GO

CREATE TRIGGER UTG_UpdateBill
ON dbo.Bill FOR UPDATE
AS
BEGIN
	DECLARE @idBill INT
	
	SELECT @idBill = id FROM Inserted	
	
	DECLARE @idTable INT
	
	SELECT @idTable = idTable FROM dbo.Bill WHERE id = @idBill
	
	DECLARE @count int = 0
	
	SELECT @count = COUNT(*) FROM dbo.Bill WHERE idTable = @idTable AND status = 0
	
	IF (@count = 0)
		UPDATE dbo.TableFood SET status = N'Tr?ng' WHERE id = @idTable
END
GO

DELETE dbo.BillInfo
DELETE dbo.Bill

GO
ALTER TABLE dbo.Bill ADD totalPrice FLOAT
go
CREATE PROC USP_GetListBillByDate
@checkIn date, @checkOut date
AS 
BEGIN
	SELECT t.name AS [T�n b�n], b.totalPrice AS [T?ng ti?n], DateCheckIn AS [Ng�y v�o], DateCheckOut AS [Ng�y ra]
	FROM dbo.Bill AS b,dbo.TableFood AS t
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1
	AND t.id = b.idTable
END
GO
CREATE PROC USP_UpdateAccount
@userName NVARCHAR(100), @displayName NVARCHAR(100), @password NVARCHAR(100), @newPassword NVARCHAR(100)
AS
BEGIN
	DECLARE @isRightPass INT = 0
	
	SELECT @isRightPass = COUNT(*) FROM dbo.Account WHERE USERName = @userName AND PassWord = @password
	
	IF (@isRightPass = 1)
	BEGIN
		IF (@newPassword = NULL OR @newPassword = '')
		BEGIN
			UPDATE dbo.Account SET DisplayName = @displayName WHERE UserName = @userName
		END		
		ELSE
			UPDATE dbo.Account SET DisplayName = @displayName, PassWord = @newPassword WHERE UserName = @userName
	end
END
GO

CREATE TRIGGER UTG_DeleteBillInfo
ON dbo.BillInfo FOR DELETE
AS 
BEGIN
	DECLARE @idBillInfo INT
	DECLARE @idBill INT
	SELECT @idBillInfo = id, @idBill = Deleted.idBill FROM Deleted
	
	DECLARE @idTable INT
	SELECT @idTable = idTable FROM dbo.Bill WHERE id = @idBill
	
	DECLARE @count INT = 0
	
	SELECT @count = COUNT(*) FROM dbo.BillInfo AS bi, dbo.Bill AS b WHERE b.id = bi.idBill AND b.id = @idBill AND b.status = 0
	
	IF (@count = 0)
		UPDATE dbo.TableFood SET status = N'Tr?ng' WHERE id = @idTable
END
GO

CREATE FUNCTION [dbo].[fuConvertToUnsign1] ( @strInput NVARCHAR(4000) ) RETURNS NVARCHAR(4000) AS BEGIN IF @strInput IS NULL RETURN @strInput IF @strInput = '' RETURN @strInput DECLARE @RT NVARCHAR(4000) DECLARE @SIGN_CHARS NCHAR(136) DECLARE @UNSIGN_CHARS NCHAR (136) SET @SIGN_CHARS = N'?�?��??�?�?�??????????�???�????? �???��?�?�??????????�???�?????????� ?�?��??�?�?�??????????�???�?????�???� �?�?�??????????�???�?????????�' +NCHAR(272)+ NCHAR(208) SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' DECLARE @COUNTER int DECLARE @COUNTER1 int SET @COUNTER = 1 WHILE (@COUNTER <=LEN(@strInput)) BEGIN SET @COUNTER1 = 1 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) BEGIN IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) BEGIN IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) ELSE SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) BREAK END SET @COUNTER1 = @COUNTER1 +1 END SET @COUNTER = @COUNTER +1 END SET @strInput = replace(@strInput,' ','-') RETURN @strInput END
GO



