CREATE DATABASE ecommerce;
use ecommerce;


CREATE SCHEMA website;





CREATE TABLE [website].[Users]
(
    UsrId INT NOT NULL,
    FName VARCHAR(40) NULL,
	Age tinyint NOT NULL
    CONSTRAINT [PK_User_UserID] PRIMARY KEY (UsrId)
)

INSERT INTO [website].Users values (100,'Siamak',39)
select * from  [website].Users
drop table [website].Users



--********************************************************
CREATE TABLE [website].[Users]
(
    UsrId INT IDENTITY(1,1) NOT NULL,
    FName VARCHAR(40) NULL,
	Age tinyint NOT NULL
    CONSTRAINT [PK_User_UserID] PRIMARY KEY (UsrId)
)

INSERT INTO [website].Users values ('Siamak',39)
select * from  [website].Users
drop table [website].[Users]




--********************************************************
--Simple password
CREATE TABLE [website].[Users]
(
    UsrId INT IDENTITY(1,1) NOT NULL,
    FName VARCHAR(40) NULL,
    LName VARCHAR(40) NULL,
	Username VARCHAR(40) NOT NULL,
    Pass  VARCHAR(40) NOT NULL,
	Status BIT NOT NULL,
	DOB DATE,
	Photo VARCHAR(100)
    CONSTRAINT [PK_User_UserID] PRIMARY KEY (UsrId)
)

INSERT INTO [website].[Users]  ([FName],[LName],[Username],[Pass],[Status],[DOB],[Photo])
     VALUES
           ('John',
           'Smith',
           'js'
           ,'js1980'
           ,1
           ,'1980-01-01'
           ,'img/usr/john-smith.jpg')

select * from  [website].Users


	   
--********************************************************
--hashed password
drop table [website].[Users]
CREATE TABLE [website].[Users]
(
    UsrId INT IDENTITY(1,1) NOT NULL,
    FName VARCHAR(40) NULL,
    LName VARCHAR(40) DEFAULT NULL,
	Username VARCHAR(40) NOT NULL,
    PasswordHash BINARY(64) NOT NULL,
	Salt char(6),
	Status BIT NOT NULL,
	DOB DATE,
	Photo VARCHAR(100)
    CONSTRAINT [PK_User_UserID] PRIMARY KEY (UsrId)
)


--zero is inclusive so we might get 0 
DECLARE @salt int
set @salt=LEFT(CAST(RAND()*1000000000+999999 AS INT),6)
 

INSERT INTO [website].[Users]  ([FName],[LName],[Username],[PasswordHash],[Salt],[Status],[DOB],[Photo])
VALUES      ('John', 'Smith', 'js',HASHBYTES('SHA2_512', 'js1980'+CAST(@salt AS VARCHAR(6))),@salt ,1 ,'1980-01-01'  ,'img/usr/john-smith.jpg')


select * from  [website].Users





INSERT INTO [website].[Users]  ([FName],[LName],[Username],[PasswordHash],[Salt],[Status],[DOB],[Photo])
VALUES      ('Kyle', 'Adams', 'aa',HASHBYTES('SHA2_512', 'aa1980'+CAST(@salt AS VARCHAR(6))),@salt ,1 ,'1985-03-15'  ,'img/usr/adam-adams.jpg')


INSERT INTO [website].[Users]  ([FName],[LName],[Username],[PasswordHash],[Salt],[Status],[DOB],[Photo])
VALUES      ('Adam', 'Smith', 'as',HASHBYTES('SHA2_512', 'as1980'+CAST(@salt AS VARCHAR(6))),@salt ,0 ,'1981-02-02'  ,'img/usr/adam-smith.jpg')


INSERT INTO [website].[Users]  ([FName],[LName],[Username],[PasswordHash],[Salt],[Status],[DOB],[Photo])
VALUES      ('Susan', 'Rice' , 'as',HASHBYTES('SHA2_512', 's1980'+CAST(@salt AS char(6))),@salt ,0 ,'1986-06-12'  ,'img/usr/susan.jpg')


Select top 1 Fname,LName from [website].Users

--Select columns 
Select Fname,LName from [website].Users



Declare @testUser varchar(20) = 'aa'
Declare @testPass varchar(20) = 'aa1980'
Declare @SaltExist char(6) =0

select @SaltExist=salt from [website].Users where [Username]=@testUSer
If @SaltExist != 0
Begin
	select 'Valid User! - User Id :' + cast(UsrId as varchar) from [website].Users where [Username]=@testUser and PasswordHash= HASHBYTES('SHA2_512', @testPass+@SaltExist)
END





--Select columns 
Select distinct Fname,LName from [website].Users


Select * from [website].Users where Status=0
Select * from [website].Users where Fname='Adam'
Select * from [website].Users where Fname='Adam' and LName like 'S%'
Select * from [website].Users where Fname='Adam' and LName like '%th%'
Select * from [website].Users where Fname='Adam' or Status=1


Select * from [website].Users order by DOB asc
Select * from [website].Users order by DOB desc

Select * from [website].Users order by DOB asc
Select * from [website].Users order by DOB desc

Select top 1 * from [website].Users order by DOB asc

Select * from [website].Users where LName is NULL


Select * from [website].Users where DOB > '1981-03-01'
Select * from [website].Users where DOB BETWEEN '1986-03-01' and '1993-03-01'
Select * from [website].Users where username in ('aa' , 'js')


Begin transaction
Update  [website].Users 
SET Lname='Jordan'
where FName = 'Susan'
--rollback
commit


--DELETE 
Begin transaction
Delete  [website].Users 
where FName = 'Susan'
--rollback
commit


--DATE Functions 
Select getdate() as currentdate
Select datepart(day, getdate()) as currentdate
Select datediff(DAY, getdate()-7, getdate()) 

SELECT CONVERT(VARCHAR,GETDATE()) 
SELECT CONVERT(VARCHAR,GETDATE(),1) 
SELECT CONVERT(VARCHAR,GETDATE(),101) 
SELECT CONVERT(VARCHAR,GETDATE(),110) 




--drop table [website].[Products]
CREATE TABLE [website].[Products]
(
    ProductId INT IDENTITY(100,1) NOT NULL,
	Product VARCHAR(50) NOT NULL,
	ProductDescription VARCHAR(200) NOT NULL,
	Price DECIMAL(19,4) NOT NULL
    CONSTRAINT [PK_Products_ProductId] PRIMARY KEY (ProductId),
	CONSTRAINT UC_Product UNIQUE (Product)
)


INSERT INTO [website].[Products] ([Product],[ProductDescription],[Price]) VALUES  ('Canon','DT4',200)
INSERT INTO [website].[Products]  VALUES   ('Dell Laptop','Core i7 - 8Gb RAM',1000)
INSERT INTO [website].[Products]  VALUES   ('iPad32','Silve, 32GB, Wi-Fi',300)
INSERT INTO [website].[Products]  VALUES   ('iPad64','Silve, 64GB, Wi-Fi',500)


SELECT * FROM [website].[Products]  WHERE Price<330

SELECT min(price) FROM [website].[Products]  

SELECT max(price) FROM [website].[Products]  

SELECT avg(price) FROM [website].[Products]  




--Union
SELECT CAST(min(price) AS CHAR) + 'Min'FROM [website].[Products]  
UNION
SELECT CAST(max(price) AS CHAR) + 'MAX' FROM [website].[Products]  



SELECT Max(price),Product FROM [website].[Products]  
Group by Product HAVING max(price)>400
--Group by
--having

--***********************************************************************
--drop table [website].[Address]
CREATE TABLE [website].[Address]
(
	AddressId INT IDENTITY(1,1),
	PhysicalAddress Varchar(60),
	CONSTRAINT [PK_Address_AddressId] PRIMARY KEY (AddressId)

)

INSERT INTO [website].[Address]   VALUES ('123 Main St, New York 10001')
INSERT INTO [website].[Address]   VALUES ('60 American Way, CA, 90291')
INSERT INTO [website].[Address]   VALUES ('Po Box 370, Golden Dr, CO, 80424 ')
INSERT INTO [website].[Address]   VALUES ('500 West Dr, CO, 80401')
INSERT INTO [website].[Address]   VALUES ('6 North Dr, CO, 80408')
INSERT INTO [website].[Address]   VALUES ('51 Second Way, CA, 90291')
--SELECT * FROM [website].[Address]

--***********************************************************************
--drop table [website].[CustomerShippingAddress]
CREATE TABLE [website].[CustomerShippingAddress]
(
	FK_UsrId INT,
	FK_AddressId INT,
	IsActive BIT  NOT NULL,
    CONSTRAINT [PK_CustomerShippingAddress_CustomerShippingAddressId] PRIMARY KEY (FK_UsrId,FK_AddressId),
	FOREIGN KEY (FK_UsrId) REFERENCES [website].[Users](UsrId),
	FOREIGN KEY (FK_AddressId) REFERENCES [website].[Address](AddressId)
)
INSERT INTO [website].[CustomerShippingAddress]([FK_UsrId],FK_AddressId,[IsActive])   VALUES (1,1,1)
INSERT INTO [website].[CustomerShippingAddress]([FK_UsrId],FK_AddressId,[IsActive])   VALUES (1,2,1)
INSERT INTO [website].[CustomerShippingAddress]([FK_UsrId],FK_AddressId,[IsActive])   VALUES (2,3,1)
INSERT INTO [website].[CustomerShippingAddress]([FK_UsrId],FK_AddressId,[IsActive])   VALUES (3,4,1)
INSERT INTO [website].[CustomerShippingAddress]([FK_UsrId],FK_AddressId,[IsActive])   VALUES (3,5,1)


--Now when ordering and selecting shipping address ,the uiser can select: 
SELECT * FROM [website].[CustomerShippingAddress] csd
JOIN [website].[Users] u ON csd.FK_UsrId=u.UsrId
JOIN [website].[Address] addr ON csd.FK_AddressId=addr.AddressId
Where u.UsrId=1
--***********************************************************************


--drop table [website].[Orders]
CREATE TABLE [website].[Orders]
(
    OrderId INT IDENTITY(1000,1) NOT NULL,
	FK_UsrId INT NOT NULL,
	FK_ShippingId INT NOT NULL,
	OrderDate DATE NOT NULL,
    OrderTotal Decimal(19,4) NOT NULL,
    CONSTRAINT [PK_Orders_OrderId] PRIMARY KEY (OrderId,FK_UsrId),
	FOREIGN KEY (FK_UsrId) REFERENCES [website].[Users](UsrId),
	FOREIGN KEY (FK_UsrId,FK_ShippingId) REFERENCES [website].[CustomerShippingAddress](FK_UsrId,FK_AddressId)
)

--Users Table
--UsrId	FName	LName
---------------------
--1	John	Smith
--2	Kyle	Adams
--3	Adam	Smith



--Address Table
--AddressId		PhysicalAddress
-------------------------------------------
--1				123 Main St, New York 10001
--2				60 American Way, CA, 90291
--3				Po Box 370, Golden Dr, CO, 80424 
--4				500 West Dr, CO, 80401
--5				6 North Dr, CO, 80408
--6				51 Second Way, CA, 90291


--Products Table
--ProductId		Product			ProductDescription		Price
-----------------------------------------------------------------
--100			Canon			DT4						$200
--101			Dell Laptop		Core i7 - 8Gb RAM		$1000
--102			iPad32			Black 32GB, Wi-Fi		$300
--103			iPad64			Black 64GB, Wi-Fi		$500


--CustomerShippingAddress Table
--FK_UsrId	FK_AddressId	IsActive
-----------------------------------
--1			1				1
--1			2				1
--2			3				1
--3			4				1
--3			5				1	


--Ordering Scenarios
-----------------------------------------------
--John	Smith (usrId=1)	   is ordering  one		Camera  (ProductId=100)  and shipping address is (AddressId=1)	>>> Toral Order : $200
--John	Smith (usrId=1)    is ordering  two		ipads32 (ProductId=102)  and shipping address is (AddressId=2)	>>> Toral Order : $600
--Kyle	Adams (usrId=2)    is ordering  one		Laptop  (ProductId=101)  and shipping address is (AddressId=3)	>>> Toral Order : $1000
--Adam	Smith (usrId=3)    is ordering  one		ipad64  (ProductId=103)  and shipping address is (AddressId=4)	>>> Toral Order : $500



INSERT INTO [website].[Orders]  ([FK_UsrId],[FK_ShippingId],[OrderDate],[OrderTotal])  VALUES (1,1,getdate(),200)
INSERT INTO [website].[Orders]  ([FK_UsrId],[FK_ShippingId],[OrderDate],[OrderTotal])  VALUES (1,2,getdate(),600)
INSERT INTO [website].[Orders]  ([FK_UsrId],[FK_ShippingId],[OrderDate],[OrderTotal])  VALUES (2,3,getdate(),1000)
INSERT INTO [website].[Orders]  ([FK_UsrId],[FK_ShippingId],[OrderDate],[OrderTotal])  VALUES (3,4,getdate(),500)




--The following insert will give us an error
--We are sending the order to the wrong address 
-- 500 West Dr, CO, 80401 (AddressId=4) is not a valid address for John Smith (usrId=1)
--INSERT INTO [website].[Orders]  ([FK_UsrId],[FK_ShippingId],[OrderDate],[OrderTotal])  VALUES (1,4,getdate(),500)


--Records thath have matching in both tables
SELECT ord.OrderId,ord.OrderDate,ord.OrderTotal,usr.FName,usr.LName,addr.PhysicalAddress FROM [website].[Orders] ord
JOIN [website].[CustomerShippingAddress] saddr ON (ord.FK_ShippingId= saddr.FK_AddressId) and (ord.FK_UsrId=saddr.FK_UsrId)
JOIN [website].Address addr ON saddr.FK_AddressId= addr.AddressId 
JOIN [website].Users usr ON saddr.FK_UsrId= usr.UsrId
Where usr.UsrId=1


--***********************************************************************
--Different Types of SQL JOINs

--(INNER) JOIN: Returns records that have matching values in both tables
--LEFT (OUTER) JOIN: Returns all records from the left table, and the matched records from the right table
--RIGHT (OUTER) JOIN: Returns all records from the right table, and the matched records from the left table
--FULL (OUTER) JOIN: Returns all records when there is a match in either left or right table


SELECT ord.OrderId,ord.OrderDate,ord.OrderTotal,USR.UsrId,usr.FName,usr.LName,addr.PhysicalAddress FROM [website].[Orders] ord
FULL JOIN [website].[CustomerShippingAddress] saddr ON (ord.FK_ShippingId= saddr.FK_AddressId) and (ord.FK_UsrId=saddr.FK_UsrId)
FULL JOIN [website].Address addr ON saddr.FK_AddressId= addr.AddressId 
FULL JOIN [website].Users usr ON saddr.FK_UsrId= usr.UsrId
Where usr.UsrId=1


SELECT * FROM [website].Users  usr
LEFT JOIN [website].[Orders] ord ON ord.FK_UsrId=usr.UsrId


SELECT * FROM [website].Orders  ord
RIGHT JOIN [website].[Users] usr ON ord.FK_UsrId=usr.UsrId

--***********************************************************************
--Create Procedure 
GO
CREATE PROCEDURE UserOrders
	(@UsrId INT)
AS 
BEGIN
	SELECT ord.OrderId,ord.OrderDate,ord.OrderTotal,usr.FName,usr.LName,addr.PhysicalAddress FROM [website].[Orders] ord
	JOIN [website].[CustomerShippingAddress] saddr ON (ord.FK_ShippingId= saddr.FK_AddressId) and (ord.FK_UsrId=saddr.FK_UsrId)
	JOIN [website].Address addr ON saddr.FK_AddressId= addr.AddressId 
	JOIN [website].Users usr ON saddr.FK_UsrId= usr.UsrId
	Where usr.UsrId=@UsrId
END 
GO


--Create Databse Diagram


--***********************************************************************
--drop table [OrderDetails]
CREATE TABLE [website].[OrderDetails]
(
    OrderDetailId INT IDENTITY(1,1) NOT NULL,
	FK_OrderId INT NOT NULL,
    FK_ProductId INT NOT NULL,
	Qty SMALLINT NOT NULL,
    CONSTRAINT [PK_OrderDetails_OrderDetailId] PRIMARY KEY (OrderDetailId),
	FOREIGN KEY (FK_ProductId) REFERENCES [website].[Products](ProductId)
)

--Select * from [website].[Orders]
--John	Smith (usrId=1)	   is ordering  one		Camera  (ProductId=100)  and shipping address is (AddressId=1)	>>> (OrderId=1000)
--John	Smith (usrId=1)    is ordering  two		ipads32 (ProductId=102)  and shipping address is (AddressId=2)	>>> (OrderId=1001)
--Kyle	Adams (usrId=2)    is ordering  one		Laptop  (ProductId=101)  and shipping address is (AddressId=3)	>>> (OrderId=1002)
--Adam	Smith (usrId=3)    is ordering  one		ipad64  (ProductId=103)  and shipping address is (AddressId=4)	>>> (OrderId=1003)


--DELETE from  [website].[OrderDetails] 
INSERT INTO [website].[OrderDetails] ([FK_OrderId],[FK_ProductId],[Qty])  VALUES (1000,100,1)
INSERT INTO [website].[OrderDetails] ([FK_OrderId],[FK_ProductId],[Qty])  VALUES (1001,102,2)
INSERT INTO [website].[OrderDetails] ([FK_OrderId],[FK_ProductId],[Qty])  VALUES (1002,101,1)
INSERT INTO [website].[OrderDetails] ([FK_OrderId],[FK_ProductId],[Qty])  VALUES (1003,103,1)




SELECT usr.UsrId,usr.FName,usr.LName,prd.Product,ord.OrderDate,ord.OrderTotal, ordd.Qty, prd.Price, (ordd.Qty * prd.Price) as amount FROM [website].[Orders] ord
JOIN [website].[Users] usr ON ord.FK_UsrId=usr.UsrId
JOIN [website].[OrderDetails] ordd ON ord.OrderId=ordd.FK_OrderId
JOIN [website].[Products] prd on prd.ProductId=ordd.FK_ProductId



--***********************************************************************

--Table variables (DECLARE @t TABLE) are visible only to the connection that creates it, and are deleted when the batch or stored procedure ends.

--Local temporary tables (CREATE TABLE #t) are visible only to the connection that creates it, and are deleted when the connection is closed.
CREATE TABLE #local_table ( fname varchar(50), lname varchar(150))
INSERT INTO #local_table  VALUES ('Susan', 'Smith' )
SELECT * FROM #local_table


--Global temporary tables (CREATE TABLE ##t) are visible to everyone, and are deleted when all connections that have referenced them have closed.
CREATE TABLE ##global_table ( fname varchar(50), lname varchar(150))
INSERT INTO ##global_table  VALUES ('John', 'Smith' )
SELECT * FROM ##global_table


INSERT INTO ##global_table
SELECT * FROM #local_table


SELECT * FROM ##global_table
--***********************************************************************
--cursor
DECLARE @orderId INT;

DECLARE orderAuditCursor CURSOR
FOR SELECT OrderId FROM [website].[Orders];
OPEN orderAuditCursor;
FETCH NEXT FROM orderAuditCursor INTO @orderId

WHILE @@FETCH_STATUS=0
	BEGIN
		print 'Auditing Oreder ' + CAST(@orderId as varchar)
		--Call another procedure that double checks the payment 
		FETCH NEXT FROM orderAuditCursor INTO @orderId
		print 'Finished Auditing Order ' + CAST(@orderId as varchar)
		print ('')		
	END
CLOSE orderAuditCursor;
DEALLOCATE orderAuditCursor;








