

/*
=>          SQL PROJECT NAME : Point of Sale ( POS ) SYSTEM
=>          TRAINEE NAME     : MD. MAHBUR RAHMAN
=>          TRAINEE ID       : 1269240
=>          BATCH ID         : CS/PNTL-A/51/01
*/

--->>>  DDL SCRIPT STATR -->>
---------------------------->


/**************************************************************************************/
/*      ==========================  *    CREATE    *  ==========================      */
/**************************************************************************************/

--------------------------------------------------->>>  CREATE DATABASE  -->>>
----------------------------------------------------------------------------->

-->>> CREATE DATABASE BASIC 

DROP DATABASE IF EXISTS [RetailMaster]
GO

CREATE DATABASE [RetailMaster]
GO

-->>> USE DATABASE

USE [RetailMaster]
GO

-->>> OR 
/*
-->>> CREATE DATABASE WITH DETAILS

CREATE DATABASE [RetailMaster]
ON 
(
	NAME       = 'RetailMaster_data',
	FILENAME   = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\RetailMaster_data.mdf',
	SIZE       = 10 MB,
	MAXSIZE    = 100 MB,
	FILEGROWTH = 10%
)
LOG ON 
(
	NAME	   = 'RetailMaster_log',
	FILENAME   = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\RetailMaster_log.ldf',
	SIZE	   = 10 MB,
	MAXSIZE	   = 100 MB,
	FILEGROWTH = 10MB
)
GO

-->>> USE DATABASE

USE [RetailMaster]
GO

-->>> MODIFY FILE OF AN EXISTING DATABASE
-->>> FOR DATA FILE

ALTER DATABASE [RetailMaster]
MODIFY FILE
(
	NAME       = 'RetailMaster_data',
	FILENAME   = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\RetailMaster_data.mdf',
	SIZE       = 100 MB,
	MAXSIZE    = 1 GB,
	FILEGROWTH = 10%
)
GO

-->>> MODIFY FILE OF AN EXISTING DATABASE
-->>> FOR LOG FILE

ALTER DATABASE [RetailMaster]
MODIFY FILE
(
	NAME	   = 'RetailMaster_log',
	FILENAME   = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\RetailMaster_log.ldf',
	SIZE	   = 100 MB,
	MAXSIZE	   = 1 GB,
	FILEGROWTH = 200 MB
)
GO

-->>> ADDING FILE OF AN EXISTING DATABASE
-->>> FOR DATA FILE

ALTER DATABASE [RetailMaster]
ADD FILE 
(
	NAME       = 'RetailMaster_data_01',
	FILENAME   = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\RetailMaster_data_01.mdf',
	SIZE       = 10 MB,
	MAXSIZE    = 100 MB,
	FILEGROWTH = 10%
)
GO

-->>> FOR LOG FILE

ALTER DATABASE [RetailMaster]
ADD FILE
(
	NAME	   = 'RetailMaster_log_01',
	FILENAME   = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\RetailMaster_log_01.ldf',
	SIZE	   = 10 MB,
	MAXSIZE	   = 100 MB,
	FILEGROWTH = 10MB
)
GO

-->>> DELETING A FILE FROM DATABASE 

ALTER DATABASE [RetailMaster]
REMOVE FILE RetailMaster_data_01
GO

ALTER DATABASE [RetailMaster]
REMOVE FILE RetailMaster_log_01
GO

-->>> RENAMING A DATABASE 

ALTER DATABASE [RetailMaster]
MODIFY NAME = [Radifshop]
GO

ALTER DATABASE [Radifshop]
MODIFY NAME = [RetailMaster]
GO

-->>> DELETE A DATABASE
/*``````````````````````````````
DROP DATABASE [RetailMaster]
GO
``````````````````````````````*/
*/


--------------------------  *******  [RetailMasterAuditTable]  *******  -------------------------->
-------------------------------------------------------------------------------------------------->

CREATE TABLE [dbo].[RetailMasterAuditTable] (

						[LOG_ID]	 INT IDENTITY		PRIMARY KEY,
						[EVENT_DATA] XML				NOT NULL,
						[CHANGED_BY] SYSNAME			NOT NULL,
						[CHANGED_ON] DATETIME			NOT NULL,
						[DB_USER]    NVARCHAR(100),
						[EVENT]      NVARCHAR(100),
						[TSQL]       NVARCHAR(2000)
						)
GO


-->>> CREATE DDL TRIGGER
-->>> ON DATABASE

CREATE TRIGGER [tr_RetailMasterAuditTable]
ON DATABASE
FOR
    CREATE_TABLE,
    ALTER_TABLE,
    DROP_TABLE
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE @data XML
	SET @data = EVENTDATA()

    INSERT INTO RetailMasterAuditTable ([EVENT_DATA],
										[CHANGED_BY],
										[CHANGED_ON],
										[DB_USER],
										[EVENT],
										[TSQL]
										)

								VALUES (EVENTDATA(),
										USER,
										GETDATE(),
										CONVERT(nvarchar(100), CURRENT_USER), 
										@data.value('(/EVENT_INSTANCE/EventType)[1]','nvarchar(100)'), 
										@data.value('(/EVENT_INSTANCE/TSQLCommand)[1]','nvarchar(2000)')
										)
END
GO

ENABLE TRIGGER [tr_RetailMasterAuditTable]
ON DATABASE
GO



----------------------------------------------------->>>  CREATE SCHEMA SECTION  START -->>>
------------------------------------------------------------------------------------------->

-->>> SCHEMA NAME : Product

CREATE SCHEMA [product]
GO

-->>> SCHEMA NAME : customer

CREATE SCHEMA [customer]
GO

-->>> SCHEMA NAME : sales

CREATE SCHEMA [sales]
GO

-->>> END OF SCHEMA SECTION
------------------------------------------------------>>>  CREATE TABLE SECTION START -->>>
------------------------------------------------------------------------------------------>

-------------->>>   TABLE NAME :[dbo].[STORE] 
------------------------------------------------>>>

CREATE TABLE [dbo].[STORE](

	[STORE_CODE]		INT           IDENTITY(10101,1) CONSTRAINT [PK_STORE_CODE]  PRIMARY KEY,
	[STORE_NAME]		NVARCHAR(80) NOT NULL,
	[ADDRESS]			NVARCHAR(120) NOT NULL,
	[COUNTRY]			NVARCHAR(40)  NOT NULL CONSTRAINT [DF_STORE_COUNTRY]  DEFAULT ('Bangladesh'),
	[PHONE]				NVARCHAR(14)  NOT NULL CONSTRAINT [CHECK_STORE_PHONE]  CHECK([PHONE] LIKE '+8801[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	[EMAIL]				NVARCHAR(20)  NULL,
	[TIN]				NVARCHAR(30)  NULL,
	[STATUS]			NVARCHAR(20)  NOT NULL CONSTRAINT [DF_STORE_STATUS]  DEFAULT ('Active'),
	[CREATED_BY]		NVARCHAR(30)  NOT NULL CONSTRAINT [DF_STORE_CREATED_BY]  DEFAULT (user_name()),
	[CREATED_DATE]		DATE		  NOT NULL CONSTRAINT [DF_STORE_CREATED_DATE]  DEFAULT (GETDATE()),
	[UPDATED_BY]		NVARCHAR(30)  NOT NULL CONSTRAINT [DF_STORE_UPDATED_BY]  DEFAULT (user_name()),
	[UPDATED_DATE]		DATETIME	  NOT NULL CONSTRAINT [DF_STORE_UPDATED_DATE]  DEFAULT (GETDATE())
) 
GO

------------>>> TABLE NAME : [dbo].[EMPLOYEE]
------------------------------------------------>>>

CREATE TABLE [dbo].[EMPLOYEE](
	[EMPLOYEE_CODE]		INT IDENTITY(10001,1)  CONSTRAINT [PK_EMPLOYEE_CODE]  PRIMARY KEY,
	[EMPLOYEE_NAME]		NVARCHAR(80) NOT NULL,
	[USERNAME]			NVARCHAR(30) NULL	   UNIQUE,
	[STORE_CODE]		INT			 NOT NULL  CONSTRAINT [FK_EMPLOYEE_CODE_STORE_CODE] REFERENCES [STORE]([STORE_CODE]) ON DELETE CASCADE,
	[DESIGNATION]		NVARCHAR(80) NOT NULL,
	[CONTACT_NO]		NVARCHAR(80) NOT NULL,
	[EMAIL]				NVARCHAR(80) NULL,
	[ADDRESS]			NVARCHAR(150)NOT NULL,
	[COUNTRY]			NVARCHAR(40) NOT NULL  CONSTRAINT [DF_EMPLOYEE_COUNTRY]  DEFAULT ('Bangladesh'),
	[DOJ]				DATE		 NOT NULL,
	[CREATED_DATE]		DATETIME	 NOT NULL  CONSTRAINT [DF_EMPLOYEE_CREATED_DATE]  DEFAULT (GETDATE()),
	[UPDATED_DATE]		DATETIME	 NOT NULL  CONSTRAINT [DF_EMPLOYEE_UPDATED_DATE]  DEFAULT (GETDATE()),
	[STATUS]			NVARCHAR(20) NOT NULL  CONSTRAINT [DF_EMPLOYEE_STATUS]  DEFAULT ('Active')
)
GO

------>>> TABLE NAME : [product].[Department]
------------------------------------------------>>>

CREATE TABLE [product].[Department](

	[DEPARTMENT_CODE] INT	IDENTITY(10001,1) CONSTRAINT [PK_product.DEPARTMENT_CODE] PRIMARY KEY,
	[NAME]			  NVARCHAR(100) NOT NULL  UNIQUE,
	[CREATED_DATE]    DATETIME	    NOT NULL  CONSTRAINT [DF_product.DEPARTMENT_CREATED_DATE] DEFAULT(GETDATE()),
	[UPDATED_DATE]    DATETIME	    NOT NULL  CONSTRAINT [DF_product.DEPARTMENT_UPDATED_DATE] DEFAULT(GETDATE())
)
GO

-------->>> TABLE NAME : [product].[Category]
------------------------------------------------>>>

CREATE TABLE [product].[Category](

	 [CATEGORY_CODE]   INT  IDENTITY(10001,1)  CONSTRAINT [PK_product.CATEGORY_CODE] PRIMARY KEY
	,[CATEGORY_NAME]   NVARCHAR(100) NOT NULL  UNIQUE
	,[CREATED_DATE]	   DATETIME	     NOT NULL  CONSTRAINT [DF_product.CATEGORY_CREATED_DATE] DEFAULT(GETDATE())
	,[UPDATED_DATE]	   DATETIME	     NOT NULL  CONSTRAINT [DF_product.CATEGORY_UPDATED_DATE] DEFAULT(GETDATE())
) 
GO

---------->>> TABLE NAME : [product].[BRAND]
------------------------------------------------>>>

CREATE TABLE [product].[BRAND](

	[BRAND_CODE]   INT IDENTITY(10001,1)   CONSTRAINT [PK_product.BRAND_CODE] PRIMARY KEY,
	[BRAND_NAME]   NVARCHAR(100) NOT NULL  UNIQUE,
	[CREATED_DATE] DATETIME	     NOT NULL  CONSTRAINT [DF_product.BRAND_CREATED_DATE] DEFAULT(GETDATE()),
	[UPDATED_DATE] DATETIME	     NOT NULL  CONSTRAINT [DF_product.BRAND_UPDATED_DATE] DEFAULT(GETDATE())
)
GO

---------->>> TABLE NAME : [product].[PRODUCT]
------------------------------------------------>>>

CREATE TABLE [product].[PRODUCT](

	[PRODUCT_CODE]     INT IDENTITY(10001,1)     CONSTRAINT [PK_product.PRODUCT_PRODUCT_CODE] PRIMARY KEY,	
	[BARCODE]		   UNIQUEIDENTIFIER NOT NULL,
	[PRODUCT_NAME]	   NVARCHAR(500)	NOT NULL UNIQUE,
	[DEPARTMENT_CODE]  INT				NOT NULL REFERENCES [product].[Department]([DEPARTMENT_CODE]),
	[CATEGORY_CODE]	   INT				NOT NULL REFERENCES [product].[Category]([CATEGORY_CODE]),
	[BRAND_CODE]	   INT				NOT NULL REFERENCES product.BRAND(BRAND_CODE),
	[COUNTRY_OF_ORGIN] NVARCHAR(40)		NULL     CONSTRAINT [DF_product.PRODUCT_COUNTRY]  DEFAULT ('Bangladesh'),
	[TP]			   MONEY			NOT NULL,
	[MRP]			   AS				[TP]+([TP]*0.15),
	[QUANTITY]		   INT				NOT NULL DEFAULT 0,	
	[CREATED_BY]	   INT				NOT NULL REFERENCES [EMPLOYEE]([EMPLOYEE_CODE]),
	[CREATED_DATE]     DATETIME			NOT NULL CONSTRAINT [DF_product.PRODUCT_CREATED_DATE] DEFAULT(GETDATE()),
	[UPDATED_BY]       INT				NOT NULL REFERENCES [EMPLOYEE]([EMPLOYEE_CODE]),
	[UPDATED_DATE]     DATETIME			NOT NULL CONSTRAINT [DF_product.PRODUCT_UPDATED_DATE] DEFAULT(GETDATE())
)	
GO


----------->>> TABLE NAME : [dbo].[SUPPLIER]
------------------------------------------------>>>

CREATE TABLE [dbo].[SUPPLIER](
	[SUPPLIER_CODE] INT IDENTITY(1001,1)   CONSTRAINT [PK_SUPPLIER_PRODUCT_CODE] PRIMARY KEY,
	[SUPPLIER_NAME] NVARCHAR(150) NOT NULL UNIQUE,
	[ADDRESS]		NVARCHAR(200) NOT NULL,
	[COUNTRY]		NVARCHAR(40)  NOT NULL CONSTRAINT [DF_SUPPLIER_COUNTRY]  DEFAULT ('Bangladesh'),
	[CONTACT_NO]	NVARCHAR(80)  NOT NULL,
	[EMAIL]			NVARCHAR(80)  NULL,
	[ENTRY_BY]		INT           NOT NULL REFERENCES [EMPLOYEE]([EMPLOYEE_CODE]),
	[ENTRY_DATE]	DATETIME	  NOT NULL CONSTRAINT [DF_product.PRODUCT_CREATED_DATE] DEFAULT(GETDATE()),
	[UPDATED_BY]	INT	          NOT NULL REFERENCES [EMPLOYEE]([EMPLOYEE_CODE]),
	[UPDATED_DATE]  DATETIME	  NOT NULL CONSTRAINT [DF_product.PRODUCT_UPDATED_DATE] DEFAULT(GETDATE()),
	[STATUS]		NVARCHAR(20)  NOT NULL CONSTRAINT [DF_SUPPLIER_STATUS]  DEFAULT ('Active')
)
GO


----->>> TABLE NAME : [dbo].[PURCHASE_RECEIVE]
------------------------------------------------>>>

CREATE TABLE [dbo].[PURCHASE_RECEIVE](

	[GRN_NO]        INT IDENTITY(20001,1) CONSTRAINT [PK_PURCHASE-RECEIVED_GRN_NO] PRIMARY KEY,
	[GRN_DATE]      DATETIME NOT NULL    DEFAULT GETDATE(),
	[SUPPLIER_CODE] INT		 NOT NULL    REFERENCES [SUPPLIER]([SUPPLIER_CODE]),
	[PRODUCT_CODE]  INT		 NOT NULL    REFERENCES [product].[PRODUCT]([PRODUCT_CODE]),
	[TP]            MONEY	 NOT NULL,
	[QTY]			INT		 NOT NULL,
	[AMOUNT]		AS		 [TP]*[QTY],   			   
	[CREATED_BY]	INT      NOT NULL    REFERENCES [EMPLOYEE]([EMPLOYEE_CODE]),
	[UPDATED_BY]	INT	     NOT NULL    REFERENCES [EMPLOYEE]([EMPLOYEE_CODE]),
	[UPDATED_DATE]  DATETIME NOT NULL    CONSTRAINT [DF_product.PURCHASE_RECEIVED_UPDATED_DATE] DEFAULT(GETDATE())
)
GO


---------------------->>> customer.[CUSTOMER]
------------------------------------------------>>>

CREATE TABLE customer.[CUSTOMER](

	[CUSTOMAER_ID]	   INT IDENTITY(2001,1)   CONSTRAINT [PK_customer.CUSTOMER_CUSTOMER_CODE] PRIMARY KEY,
	[CUSTOMER_NAME]	   NVARCHAR(100) NOT NULL,
	[CUSTOMER_ADDRESS] NVARCHAR(250) NULL,
	[CUSTOMER_CITY]	   NVARCHAR(50)	 NULL     CONSTRAINT [DF_customer.CUSTOMER_CUSTOMER_CITY]     DEFAULT ('Dhaka'),
	[CUTOMER_COUNTRY]  NVARCHAR(50)	 NULL     CONSTRAINT [DF_customer.CUSTOMER_CUSTOMER_COUNTRY]  DEFAULT ('Bangladesh'),
	[CUSTOMER_PHONE]   INT			 NOT NULL,
	[CUSTOMER_EMAIL]   NVARCHAR(80)	 NULL,
	[ENTRY_BY]		   INT		     NULL	  REFERENCES [EMPLOYEE]([EMPLOYEE_CODE]),
	[ENTRY_DATE]	   DATETIME		 NOT NULL DEFAULT (GETDATE()),
	[UPDATED_DATE]	   DATETIME		 NOT NULL DEFAULT (GETDATE()),
	[STORE_CODE]	   INT			 NULL     REFERENCES [STORE]([STORE_CODE])
)
GO


-------------------------->>> [sales].[SALE]
------------------------------------------------>>>


CREATE TABLE [sales].[SALE](

			[INVOICE_NO]	INT IDENTITY(3001,1) CONSTRAINT [PK_sales.SALE_CUSTOMER_CODE] PRIMARY KEY,
			[INVOICE_DT]	DATETIME NOT NULL    DEFAULT GETDATE(),
			[CUSTOMAER_ID]  INT		 NOT NULL	 REFERENCES customer.[CUSTOMER]([CUSTOMAER_ID]),
			[PRODUCT_CODE]  INT		 NOT NULL    REFERENCES [product].[PRODUCT]([PRODUCT_CODE]),
			[MRP]			MONEY    NOT NULL,
			[SQTY]			INT      NOT NULL,
			[DISC_PRCNT]	FLOAT    NULL		 DEFAULT 0,
			[VAT_PRCNT]		FLOAT    NULL		 DEFAULT 0,
			[NET_AMT]		AS ([SQTY]*[MRP])-([MRP]*[DISC_PRCNT])+([MRP]*[VAT_PRCNT]),
			[PAYMENT_NAME]  NVARCHAR(20) NULL    DEFAULT 'CASH',
			[SALESMAN]		INT      NOT NULL    REFERENCES [EMPLOYEE]([EMPLOYEE_CODE]),
			[STORE_CODE]	INT	     NULL        REFERENCES [STORE]([STORE_CODE])
)
GO


---->>>> CREATE TABLE FOR MERGE

CREATE TABLE warehouse
(
	location  VARCHAR(50),
	productId INT,
	name      VARCHAR(50),
	qty       INT
)
GO

CREATE TABLE shop
(
	location VARCHAR(50),
	productId INT,
	productName VARCHAR(50),
	updateTime DATETIME,
	comments VARCHAR(75) NULL
)
GO

CREATE TABLE SEQUENCE_EXAMPLE_TABLE(
	id INT,
	[name] NVARCHAR(30)
)
GO


-->>> END OF CREATE TABLE SECTION
------------------------------------------------------>>>  CREATE INDEX SECTION START -->>>
------------------------------------------------------------------------------------------>

------------------------------>>> *  [dbo].[STORE]   
----------------------------------------------------->
-->>> NON CLUSTERED INDEX

CREATE NONCLUSTERED INDEX [IX_STORE]
ON [STORE](
		[STORE_NAME] ASC,
		[ADDRESS] ASC
)
GO

--------------------------->>> *  [dbo].[EMPLOYEE]    
----------------------------------------------------->
-->>> NON CLUSTERED INDEX

CREATE NONCLUSTERED INDEX [IX_EMPLOYEE_NAME]
ON [EMPLOYEE](
		[EMPLOYEE_NAME] ASC
)
GO

------------------->>> *  [SEQUENCE_EXAMPLE_TABLE] 
----------------------------------------------------->
-->>> CLUSTERED INDEX

CREATE CLUSTERED INDEX CLUSTERED_INDEX
ON [SEQUENCE_EXAMPLE_TABLE](
	id ASC
)
GO


-->>> END OF CREATE INDEX SECTION
----------------------------------------------------->>> CREATE TRIGGER SECTION START -->>>
------------------------------------------------------------------------------------------>

------------------------------>>> *  [dbo].[STORE]    
----------------------------------------------------->
-->>> TRIGGER TYPE : AFTER/FOR
-->>> FOR UPDATED UPDATE_DATE

CREATE TRIGGER dbo.tr_store_updated_date
ON [STORE]
FOR UPDATE
AS
BEGIN
	DECLARE @STORE_CODE NVARCHAR(20)
	SELECT @STORE_CODE=i.STORE_CODE FROM inserted i

	UPDATE [STORE]
		SET UPDATED_DATE=GETDATE()
		WHERE STORE_CODE=@STORE_CODE

		PRINT 'TRIGGER FIRED'
		PRINT 'UPDATED UPDATE_DATE'
END
GO

--------------------->>> *  [product].[Department]   
----------------------------------------------------->
-->>> TRIGGER TYPE : AFTER/FOR
-->>> FOR UPDATED UPDATE_DATE

CREATE TRIGGER product.tr_department_updated_date
ON [product].[Department]
FOR UPDATE
AS
BEGIN
	DECLARE @DEPARTMENT_CODE INT
	SELECT @DEPARTMENT_CODE=i.DEPARTMENT_CODE FROM inserted i

	UPDATE [product].[Department]
		SET UPDATED_DATE=GETDATE()
		WHERE DEPARTMENT_CODE=@DEPARTMENT_CODE

		PRINT 'TRIGGER FIRED'
		PRINT 'UPDATED UPDATE_DATE'
END
GO


-->>> TRIGGER TYPE : INSTEAD OF TRIGGER
-->>> FOR INSERT

CREATE TRIGGER product.tr_insteadOf_department1
ON [product].[Department]
INSTEAD OF INSERT
AS
BEGIN
	--Insert only required ones
	--ignore unwanted values

	INSERT INTO [product].[Department](DEPARTMENT_CODE,NAME,CREATED_DATE,UPDATED_DATE)
	SELECT DEPARTMENT_CODE,NAME,CREATED_DATE,UPDATED_DATE FROM inserted
END
GO

-->>> ALTER THIS TRIGGER

ALTER TRIGGER product.tr_insteadOf_department1
ON [product].[Department]
INSTEAD OF INSERT
AS
BEGIN
	--Insert only required ones
	--ignore unwanted values

	INSERT INTO [product].[Department](NAME,CREATED_DATE,UPDATED_DATE)
	SELECT NAME,CREATED_DATE,UPDATED_DATE FROM inserted
END
GO


---------------------->>> *  [product].[CATEGORY]   
----------------------------------------------------->
-->>> TRIGGER TYPE : AFTER/FOR
-->>> FOR UPDATED UPDATE_DATE

CREATE TRIGGER product.tr_category_updated_date
ON [product].[CATEGORY] 
FOR UPDATE
AS
BEGIN
	DECLARE @CATEGORY_CODE INT
	SELECT @CATEGORY_CODE=i.CATEGORY_CODE FROM inserted i

	UPDATE [product].[CATEGORY]
		SET UPDATED_DATE=GETDATE()
		WHERE CATEGORY_CODE=@CATEGORY_CODE

		PRINT 'TRIGGER FIRED'
		PRINT 'UPDATED UPDATE_DATE'
END
GO


------------------------->>> * [product].[BRAND]   
----------------------------------------------------->
-->>> TRIGGER TYPE : AFTER/FOR
-->>> FOR UPDATED UPDATE_DATE

CREATE TRIGGER product.tr_brand_updated_date
ON [product].[BRAND] 
FOR UPDATE
AS
BEGIN
	DECLARE @BRAND_CODE INT
	SELECT @BRAND_CODE=I.BRAND_CODE FROM inserted i

	UPDATE [product].[BRAND] 
		SET UPDATED_DATE=GETDATE()
		WHERE BRAND_CODE=@BRAND_CODE

		PRINT 'TRIGGER FIRED'
		PRINT 'UPDATED UPDATE_DATE'
END
GO


------------------------->>> * [product].[PRODUCT]   
----------------------------------------------------->
-->>> TRIGGER TYPE : AFTER/FOR
-->>> FOR UPDATED UPDATE_DATE

CREATE TRIGGER product.tr_product_updated_date
ON [product].[PRODUCT]
FOR UPDATE
AS
BEGIN
	DECLARE @PRODUCT_CODE INT
	SELECT @PRODUCT_CODE=i.PRODUCT_CODE FROM inserted i

	UPDATE [product].[PRODUCT]
		SET UPDATED_DATE=GETDATE()
		WHERE PRODUCT_CODE=@PRODUCT_CODE

		PRINT 'TRIGGER FIRED'
		PRINT 'UPDATED UPDATE_DATE'
END
GO


-------------------------->>> * [dbo].[SUPPLIER]   
----------------------------------------------------->
-->>> TRIGGER TYPE : AFTER/FOR
-->>> FOR UPDATED UPDATE_DATE

CREATE TRIGGER dbo.tr_supplier_updated_date
ON [dbo].[SUPPLIER]
FOR UPDATE
AS
BEGIN
	DECLARE @SUPPLIER_CODE INT
	SELECT @SUPPLIER_CODE=i.SUPPLIER_CODE FROM inserted i

	UPDATE [dbo].[SUPPLIER]
		SET UPDATED_DATE=GETDATE()
		WHERE SUPPLIER_CODE=@SUPPLIER_CODE

		PRINT 'TRIGGER FIRED'
		PRINT 'UPDATED UPDATE_DATE'
END
GO


-------------------->>> * [dbo].[PURCHASE_RECEIVE]   
----------------------------------------------------->
-->>> TRIGGER TYPE : AFTER/FOR
-->>> FOR UPDATED UPDATE_DATE


CREATE TRIGGER dbo.tr_purchase_updated_date
ON [dbo].[PURCHASE_RECEIVE]
FOR UPDATE
AS
BEGIN
	DECLARE @GRN_NO INT
	SELECT @GRN_NO=i.GRN_NO FROM inserted i

	UPDATE [dbo].[PURCHASE_RECEIVE]
		SET UPDATED_DATE=GETDATE()
		WHERE GRN_NO=@GRN_NO

		PRINT 'TRIGGER FIRED'
		PRINT 'UPDATED UPDATE_DATE'
END
GO


-->>> FOR INSERT

CREATE TRIGGER dbo.tr_insert_for_purcase_received
ON [dbo].[PURCHASE_RECEIVE]
FOR INSERT 
AS
	BEGIN
		DECLARE  @purchase_code INT, 
				@purchase_quantity INT
			

		SELECT @purchase_code=PRODUCT_CODE, @purchase_quantity=QTY FROM inserted

		UPDATE [product].[PRODUCT]
			SET QUANTITY = QUANTITY+@purchase_quantity
			WHERE PRODUCT_CODE=@purchase_code

	END
GO

---->>> DELETE

CREATE TRIGGER dbo.tr_delete_for_purcase_received
ON [dbo].[PURCHASE_RECEIVE]
FOR DELETE 
AS
	BEGIN
		DECLARE  @purchase_code INT, 
		@purchase_quantity INT 

		SELECT @purchase_code=PRODUCT_CODE, @purchase_quantity=QTY FROM inserted

		UPDATE [product].[PRODUCT]
			SET QUANTITY = QUANTITY - @purchase_quantity
			WHERE PRODUCT_CODE=@purchase_code

	END
GO


----->>>>> UPDATE 

CREATE TRIGGER dbo.tr_update_for_purcase_received
ON[dbo].[PURCHASE_RECEIVE]
AFTER UPDATE
AS
BEGIN
	IF UPDATE([QTY])
	BEGIN
		DECLARE @id INT,
			@deletequantity INT,
			@insertedquantity INT,
			@change INT

		SELECT @id=i.[PRODUCT_CODE],
			@deletequantity=d.[QTY],
			@insertedquantity=i.[QTY]
			
		FROM inserted i
		INNER JOIN deleted d
			ON i.PRODUCT_CODE=d.PRODUCT_CODE
		SET @change = @deletequantity-@insertedquantity

		UPDATE [product].[PRODUCT]
			SET [QUANTITY] = [QUANTITY]-@change
			WHERE [PRODUCT_CODE]=@id
	END
END
GO

----------------------------->>> * [sales].[SALE]  
----------------------------------------------------->
-->>> TRIGGER TYPE : AFTER/FOR
-->>> FOR INSERT

CREATE TRIGGER sales.tr_for_sale
ON [sales].[SALE]
FOR INSERT
AS
BEGIN
	DECLARE @orderPId INT, 
			@saleQuantity INT,
			@productQuantiy INT,
			@productMRP MONEY,
			@saleMRP MONEY

	SELECT @orderPId=i.PRODUCT_CODE,@saleQuantity=i.SQTY,@saleMRP=i.MRP FROM inserted i

	SELECT @productQuantiy=QUANTITY,@productMRP=MRP FROM product.PRODUCT
	WHERE @orderPId=PRODUCT_CODE

	
	IF(@saleQuantity<=@productQuantiy AND @saleMRP=@productMRP)

		BEGIN 
			UPDATE [product].[PRODUCT]
				SET QUANTITY=QUANTITY-@saleQuantity
				WHERE PRODUCT_CODE=@orderPId

				PRINT 'Products Sold'	
		END

	ELSE 
		BEGIN 
				RAISERROR ('PRODUCT PRICE OR QUANTITY ARE NOT CORRECT',10,1)
				ROLLBACK TRANSACTION
		END		
END
GO


-->>> TRIGGER TYPE INSTEAD OF TRIGGR
-->>> FOR UPDATE AND DELETE

CREATE TRIGGER sales.tr_sale_update_delete
ON [sales].[SALE]
INSTEAD OF UPDATE,DELETE
AS
	BEGIN
		PRINT 'DELETE AND UPDATE IS NOT EXECUTABLE'
		ROLLBACK TRANSACTION
	END
GO



-->>> END OF CREATE TRIGGR SECTION
---------------------------------------------------->>> CREATE STORE PROCEDURE SECTION START -->>>
------------------------------------------------------------------------------------------------->

--------------------------------->>> *  STORE TABLE    
----------------------------------------------------->

-->>> FOR INSERT

CREATE PROC dbo.sp_insert_for_store(
								@STORE_NAME			NVARCHAR(150),
								@ADDRESS			NVARCHAR(120),	
								@COUNTRY			NVARCHAR(80),	
								@PHONE				CHAR(14),		
								@EMAIL				VARCHAR(80),  
								@TIN				NVARCHAR(30), 
								@STATUS				NVARCHAR(30)
								)
AS
BEGIN
	INSERT INTO [STORE](STORE_NAME,ADDRESS,COUNTRY,PHONE,EMAIL,TIN,STATUS)
	VALUES(@STORE_NAME,@ADDRESS,@COUNTRY,@PHONE,@EMAIL,@TIN,@STATUS)
END
GO


-->>> FOR INSERT WITH DEFAULT PARAMETER

CREATE PROC dbo.sp_insert_for_store_with_default_parameter(
												@STORE_NAME			NVARCHAR(150),
												@ADDRESS			NVARCHAR(120),	
												@COUNTRY			NVARCHAR(80) = 'Bangladesh',	
												@PHONE				CHAR(14),		
												@EMAIL				VARCHAR(80)  = 'N/A',  
												@TIN				NVARCHAR(30) = 'N/A', 
												@STATUS				NVARCHAR(30) = 'Acive'
								)
AS
BEGIN
	INSERT INTO [STORE](STORE_NAME,ADDRESS,COUNTRY,PHONE,EMAIL,TIN,STATUS)
	VALUES(@STORE_NAME,@ADDRESS,@COUNTRY,@PHONE,@EMAIL,@TIN,@STATUS)
END
GO


EXEC  dbo.sp_insert_for_store_with_default_parameter @STORE_NAME = 'SUPER STORE', @ADDRESS='DHAKA', @PHONE='+8801703776655'
GO


-->>> FOR UPDATE

CREATE PROC dbo.sp_update_for_store(
								@STORE_CODE			INT,
								@STORE_NAME			NVARCHAR(150),
								@ADDRESS			NVARCHAR(120),	
								@COUNTRY			NVARCHAR(80),	
								@PHONE				CHAR(14),		
								@EMAIL				VARCHAR(80),  
								@TIN				NVARCHAR(30), 
								@STATUS				NVARCHAR(30)
								)
AS
BEGIN
	UPDATE [STORE]
	SET STORE_NAME=@STORE_NAME,ADDRESS=@ADDRESS,COUNTRY=@COUNTRY,PHONE=@PHONE,EMAIL=@EMAIL,TIN=@TIN,STATUS=@STATUS
	WHERE STORE_CODE=@STORE_CODE
END
GO


-->>> FOR DELETE

CREATE PROC dbo.sp_delete_for_store (
									@STORE_CODE	INT
)						
AS
BEGIN
	DELETE [STORE]
	WHERE STORE_CODE=@STORE_CODE
END
GO

-->>>  SHOW TABLE INFORMATION WITH STORE PROCEDURE

CREATE PROC dbo.tr_store_for_show_data(
							@STORE_CODE INT,
							@STORE_NAME NVARCHAR(150)
						)
AS
BEGIN
	SELECT * FROM STORE
	WHERE @STORE_CODE=STORE_CODE OR STORE_NAME LIKE '%' + @STORE_NAME + '%' 
END
GO


---------------------->>> * [product].[Department]   
----------------------------------------------------->

-->>> SHOW DATA

CREATE PROC showProduct
AS 
(SELECT D.NAME,P.PRODUCT_NAME 
FROM product.PRODUCT P
INNER JOIN product.Department D
ON P.DEPARTMENT_CODE=D.DEPARTMENT_CODE 
WHERE D.DEPARTMENT_CODE=10001
)
GO




/*
	RETURN PROCEDURE
*/

CREATE PROC sp_for_insert_department_with_Return (
												@NAME			 NVARCHAR(100),
												@CREATED_DATE    DATETIME,
												@UPDATED_DATE    DATETIME
												)
AS
	DECLARE @productId INT
	INSERT INTO [product].[Department] (NAME,CREATED_DATE,UPDATED_DATE)
	VALUES(@NAME,@CREATED_DATE,@UPDATED_DATE) 

	SELECT @productId=IDENT_CURRENT('product.Department')
	RETURN @productId
GO


/*
	--Passing OUTPUT Parameter
*/


CREATE PROC sp_for_insert_department_with_output_parameter (
												@NAME			 NVARCHAR(100),
												@CREATED_DATE    DATETIME,
												@UPDATED_DATE    DATETIME,
												@productId		 INT OUTPUT
												)
AS
	INSERT INTO [product].[Department] (NAME,CREATED_DATE,UPDATED_DATE)
	VALUES(@NAME,@CREATED_DATE,@UPDATED_DATE) 
	SELECT @productId=IDENT_CURRENT('product.Department')
GO



-->>> FOR INSERT

CREATE PROC sp_for_insert_department (
											@NAME			 NVARCHAR(100),
											@CREATED_DATE    DATETIME,
											@UPDATED_DATE    DATETIME
											)
AS
BEGIN
	INSERT INTO [product].[Department] (NAME,CREATED_DATE,UPDATED_DATE)
	VALUES(@NAME,@CREATED_DATE,@UPDATED_DATE) 
END
GO

------>>> DELETE

CREATE PROC dbo.sp_delete_for_department (
											@DEPARTMENT_CODE	INT)						
AS
BEGIN
	DELETE [product].[Department]
	WHERE [DEPARTMENT_CODE]=@DEPARTMENT_CODE
END
GO


-------------------------------------------------------------->>> VIEW   
---------------------------------------------------------------------------->


CREATE VIEW myView
AS
	(SELECT P.PRODUCT_CODE,P.BARCODE,P.PRODUCT_NAME,D.[NAME],C.CATEGORY_NAME,B.BRAND_NAME,P.TP,P.MRP,P.QUANTITY
	FROM product.PRODUCT P
	INNER JOIN product.DEPARTMENT D
		ON P.DEPARTMENT_CODE=D.DEPARTMENT_CODE
	INNER JOIN product.CATEGORY C
		ON C.CATEGORY_CODE=P.CATEGORY_CODE
	INNER JOIN product.BRAND B
		ON B.BRAND_CODE=P.BRAND_CODE
)
GO


---->>>> WITH ENCRYPTION

CREATE VIEW myViewEncryption
WITH ENCRYPTION
AS
	(SELECT P.PRODUCT_CODE,P.BARCODE,P.PRODUCT_NAME,D.[NAME],C.CATEGORY_NAME,B.BRAND_NAME,P.TP,P.MRP,P.QUANTITY
	FROM product.PRODUCT P
	INNER JOIN product.DEPARTMENT D
		ON P.DEPARTMENT_CODE=D.DEPARTMENT_CODE
	INNER JOIN product.CATEGORY C
		ON C.CATEGORY_CODE=P.CATEGORY_CODE
	INNER JOIN product.BRAND B
		ON B.BRAND_CODE=P.BRAND_CODE
)
GO

---->>>> WITH ENCRYPTION AND SCHEMABINDING

CREATE VIEW myViewEncryptionSchemabinding
WITH ENCRYPTION,SCHEMABINDING
AS
	(SELECT P.PRODUCT_CODE,P.BARCODE,P.PRODUCT_NAME,D.[NAME],C.CATEGORY_NAME,B.BRAND_NAME,P.TP,P.MRP,P.QUANTITY
	FROM product.PRODUCT P
	INNER JOIN product.DEPARTMENT D
		ON P.DEPARTMENT_CODE=D.DEPARTMENT_CODE
	INNER JOIN product.CATEGORY C
		ON C.CATEGORY_CODE=P.CATEGORY_CODE
	INNER JOIN product.BRAND B
		ON B.BRAND_CODE=P.BRAND_CODE
)
GO


---------------------->>> * [product].[Department]   
----------------------------------------------------->

CREATE VIEW V_DEPARTMENT
AS	(
	SELECT DEPARTMENT_CODE,NAME 
	FROM [product].[Department]
)
GO

CREATE VIEW V_DEPARTMENT1
AS	(
	SELECT DEPARTMENT_CODE,NAME 
	FROM [product].[Department]
)
GO


/*
	-----------------------------SEQUENCE
*/


CREATE SEQUENCE [DBO].[SequenceExample]
AS INT
START WITH 10
INCREMENT BY 5
GO

-------------------------------------------------------------->>> UDF (USER DEFINE FUNCTION)   
--------------------------------------------------------------------------------------------->

-->>> SCALAR-VALUED FUNCTION

---- FUNCTION 01

CREATE FUNCTION sales.udfNetSale
(
	@unitPrice MONEY,
	@quantity INT,
	@discount FLOAT
)
RETURNS MONEY
AS
BEGIN
	RETURN (@unitPrice*@quantity)*1-@discount
END
GO

---- FUNCTION 02

CREATE FUNCTION sales.udfNetSale1
(
	@unitPrice MONEY,
	@quantity INT,
	@discount FLOAT,
	@VAT FLOAT
)
RETURNS MONEY
AS
BEGIN
	RETURN ((@unitPrice*@quantity)-((@unitPrice*@quantity)*@discount)+((@unitPrice*@quantity)*@VAT))
END
GO


-----INLINE TABLE-VALUED FUNCTION

CREATE FUNCTION sales.product_table_valued
(
	@productId INT
)
RETURNS TABLE
AS 
RETURN
	SELECT *
	FROM sales.SALE
	WHERE PRODUCT_CODE=@productId
GO


CREATE FUNCTION sales.product_table_valued2
(
	@productId INT,
	@productId2 INT
)
RETURNS TABLE
AS 
RETURN
	SELECT *
	FROM sales.SALE
	WHERE PRODUCT_CODE BETWEEN @productId AND @productId2
GO


-->>> ALTER FUNCTION

ALTER FUNCTION sales.product_table_valued2
(
	@productId INT,
	@productId2 INT
)
RETURNS TABLE
AS 
RETURN
	SELECT *
	FROM sales.SALE
	WHERE PRODUCT_CODE >= @productId AND  PRODUCT_CODE <= @productId2
GO




-->>> MULTI STATEMENT TABLE-VALUED FUNCTION

CREATE FUNCTION sales.multistatement_table_valued_function(
															@year INT, 
															@month INT							
)
RETURNS @salesDetails TABLE 
(
	INVOICE_NO INT,
	total_Price MONEY,
	total_Discount MONEY,
	net_Price MONEY 
)
AS
BEGIN
	INSERT INTO @salesDetails
	SELECT  INVOICE_NO,
			SUM(MRP*SQTY),
			SUM(MRP*SQTY*DISC_PRCNT),
			SUM(MRP * SQTY*(1-DISC_PRCNT))
	FROM sales.SALE
	WHERE YEAR(INVOICE_DT)=@year AND MONTH(INVOICE_DT)=@month
	GROUP BY INVOICE_NO
	RETURN
END
GO

--->>>> CREATE A USER 
--------------------

CREATE LOGIN [RADIF]
WITH PASSWORD = 'pass123';


/**************************************************************************************/
/*      ==========================   *    ALTER    *  ==========================      */
/**************************************************************************************/

--------------------------------->>> *   STORE TABLE    -->>>
------------------------------------------------------------>

-->>> DATA TYPES & NULLABILITY

ALTER TABLE [STORE] ALTER COLUMN [EMAIL] NVARCHAR(30) NOT NULL 
GO

-->>> ADD COLUMN

ALTER TABLE [STORE] ADD [LICENSE_NO] [NVARCHAR](30) NULL
GO


/**************************************************************************************/
/*      ==========================    *    DROP    *  ==========================      */
/**************************************************************************************/

--------------------------------->>> *   STORE TABLE    -->>>
------------------------------------------------------------>

-->>> DROP COLUMN 

ALTER TABLE [STORE] DROP COLUMN [LICENSE_NO]
GO

--->>>>>>> DROP VIEW

DROP VIEW  V_DEPARTMENT1
GO



----------------------- * THE END *
-----------------------------------