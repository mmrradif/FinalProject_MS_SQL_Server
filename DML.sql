
/*
=>          SQL PROJECT NAME : Point of Sale ( POS ) SYSTEM
=>          TRAINEE NAME     : MD. MAHBUR RAHMAN
=>          TRAINEE ID       : 1269240
=>          BATCH ID         : CS/PNTL-A/51/01
*/

--->>> DML SCRIPT START -->>
--------------------------->


------------------------------------------->>>  USE DATABASE  -->>>
------------------------------------------------------------------>

USE [RetailMaster]
GO


/*
------------------------------------>>>  Renaming A DATABASE  -->>>
------------------------------------------------------------------>

EXEC sp_renamedb [RetailMaster],[shop]
GO

EXEC sp_renamedb [shop],[RetailMaster]
GO
*/


------------->>>  VIEW DATABASE INFORMATION FOR RetailMaster  -->>>
------------------------------------------------------------------>

EXEC sp_helpdb [RetailMaster]
GO

----------------------------->>>  VIEW ALL TABLE INFORMATION  -->>>
------------------------------------------------------------------>

EXEC sp_help 'RetailMasterAuditTable';
EXEC sp_help 'STORE';
EXEC sp_help 'EMPLOYEE';
EXEC sp_help '[product].[Department]';
EXEC sp_help '[product].[Category]';
EXEC sp_help '[product].[BRAND]';
EXEC sp_help '[product].[PRODUCT]';
EXEC sp_help '[dbo].[SUPPLIER]';
EXEC sp_help '[dbo].[PURCHASE_RECEIVE]';
EXEC sp_help '[customer].[CUSTOMER]';
EXEC sp_help '[sales].[SALE]';
EXEC sp_help '[dbo].[SEQUENCE_EXAMPLE_TABLE]';
GO


-------------------------------------------------- >>>> TABLE -->>>
------------------------------------------------------------------>
-->>> TABLE NAME : [STORE] 


----------------------->>>  INSERT DATA WITH STORE PROCEDURE  -->>>
------------------------------------------------------------------>

-->>> STORE

EXEC dbo.sp_insert_for_store 'Smart Store','ECB CHATTOR','Bangladesh','+8801947617894','mmrradif@gmail.com',NULL,'ACTIVE'
GO

-->>>  [product].[Department]

EXEC sp_for_insert_department 'SNACKS & CONFECTIONARY','',''
GO



--------------------------->>>  UPDATE DATA  WITH STORE PROCEDURE  -->>>
----------------------------------------------------------------------->

-->>> STORE

EXEC dbo.sp_update_for_store 10101,'Smart Store','ECB CHATTOR','Bangladesh','+8801947617894','mmrradif@gmail.com','113322','ACTIVE'
GO


----------------------------->>>  DELETE DATA WITH STORE PROCEDURE  -->>>
------------------------------------------------------------------------>

-->>> STORE

EXEC dbo.sp_delete_for_store 10101
GO

-->>>  [product].[Department]

EXEC dbo.sp_delete_for_department 10021
GO

---------------------------------------->>>  BREAK IDENTITY INSERT  -->>>
------------------------------------------------------------------------>

----- >>> STORE

SET IDENTITY_INSERT [STORE] ON
INSERT INTO [STORE](STORE_CODE,STORE_NAME,ADDRESS,COUNTRY,PHONE,EMAIL,TIN,STATUS)
VALUES(10101,'Smart Store','ECB CHATTOR','Bangladesh','+8801947617894','mmrradif@gmail.com',NULL,'ACTIVE')
GO
SET IDENTITY_INSERT [STORE] OFF
GO


------------------->>> SHOW TABLE INFORMATION WITH STORE PROCEDURE  -->>>
------------------------------------------------------------------------>

----->>> STORE

EXEC dbo.tr_store_for_show_data 10101,'STORE'
GO

EXEC dbo.tr_store_for_show_data '','STORE'
GO

EXEC dbo.tr_store_for_show_data '','SMART'
GO


/*
-->>> RENAME COLUMN 

EXEC sp_rename '[STORE].[TIN]','[TIN_ID]','COLUMN'
GO

EXEC sp_rename '[STORE].[[TIN_ID]]]','TIN','COLUMN'
GO

*/


--------------------------------------------------->>>  INSERT DATA -->>>
------------------------------------------------------------------------>

-->>>  [EMPLOYEE] 

INSERT INTO [EMPLOYEE](EMPLOYEE_NAME,USERNAME,STORE_CODE,DESIGNATION,CONTACT_NO,EMAIL,ADDRESS,COUNTRY,DOJ)
VALUES
('MD. MAHFIZUR RAHMAN','MAHFUZ',10101,'Executive POS','+8801947616785','mahfuz@gmail.com','DHAKA','Bangladesh','2016-01-01'),
('MD. Habibir RAHMAN','HABIB',10101,'POS Operator','+8801947616700','habib@gmail.com','DHAKA','Bangladesh','2019-01-01')
GO

-->>>  [product].[Department]

INSERT INTO [product].[Department]
			([NAME])   
     VALUES
           ('BABY CARE'),
		   ('DAIRY & FROZEN'),
		   ('ELECTRICAL'),
		   ('FOOD'),
		   ('GROCERY'),
		   ('HEALTH & BEAUTY'),
		   ('HOUSEHOLD'),
		   ('LIFE STYLE'),
		   ('PET CARE'),
		   ('SPORTS & FITNESS ITEMS'),
		   ('STATIONERY'),
		   ('TOYS'),
		   ('MEAT'),
		   ('VEGETABLE S'),
		   ('LAUNDRY'),
		   ('TOILETRIES'),
		   ('COSMETICS'),
		   ('SKIN CARE'),
		   ('DRY FISH'),
		   ('FRUITS')
GO


-->>>  [product].[Category]

INSERT INTO [product].[Category](
            [CATEGORY_NAME]   )         
     VALUES 
			('FEEDING'),
			('BABY FOOD'),
			('BABY MILK'),
			('SKIN CARE'),
			('TAPE'),
			('BUTTER'),
			('CHEESE'),
			('ICE CREAM'),
			('CHARGER'),
			('EAR PHONE'),
			('BISCUIT'),
			('CHOCOLATE'),
			('NOODLES'),
			('NUTS'),
			('ATTA'),
			('COOKING OIL'),
			('RICE'),
			('BODY LOTION'),
			('ADULT DIAPER'),
			('AIR FRESHENER'),
			('BUCKET'),
			('MOSQUITO COIL'),
			('BELT'),
			('SHIRT'),
			('SHORTS'),
			('SOCKS'),
			('TOPS'),
			('T-SHIRT'),
			('CAT FOOD'),
			('DOG FOOD'),
			('BADMINTON RACKET'),
			('SPORTS & FITNESS ITEMS'),
			('CALCULATOR'),
			('FILE BAG'),
			('HIGHLIGHTER'),
			('BABY TOYS')
GO

-->>>  [product].[BRAND]

INSERT INTO [product].[BRAND]
            ([BRAND_NAME])
     VALUES('NESTLE')
GO

INSERT INTO [product].[BRAND]
            ([BRAND_NAME])
     VALUES
			('THAILAND'),
			('CHINA'),
			('ANGELIC'),
			('APTAMIL'),
			('AXE'),
			('BABY LOONEY TUNES'),
			('BARBIE'),
			('BD FOOD'),
			('BELLS')		
GO


-->>> product.PRODUCT

INSERT INTO product.PRODUCT(BARCODE,PRODUCT_NAME,DEPARTMENT_CODE,CATEGORY_CODE,BRAND_CODE,TP,QUANTITY,CREATED_BY,UPDATED_BY) 
VALUES 
(NEWID(),'BABY PUREE ONLY ORGANIC PEAR & MANGO 120GM',10001,10002,10001,500.00,100,10002,10002),
(NEWID(),'CERELAC NESTLE HONEY & WH.W.MILK (T) 1KG',10001,10002,10001,400.00,70,10001,10001),
(NEWID(),'CERELAC NESTLE RICE CARROT & CHICKEN WITH MILK 350 GM',10001,10003,10001,375.00,55,10001,10002)
GO

INSERT INTO product.PRODUCT(BARCODE,PRODUCT_NAME,DEPARTMENT_CODE,CATEGORY_CODE,BRAND_CODE,TP,QUANTITY,CREATED_BY,UPDATED_BY) 
VALUES 
(NEWID(),'BABY WASH & SHAMPOO CETAPHIL WITH ORGANIC CALENDULA 399 ML',10001,10002,10003,500.00,100,10002,10002),
(NEWID(),'BABY POWDER JOHNSONS 500G (JST)',10001,10002,10003,400.00,70,10001,10001),
(NEWID(),'BABY OIL  JOHNSON & JOHNSON 500 ML',10001,10003,10003,375.00,55,10001,10002)
GO


-->>> [dbo].[SUPPLIER]

INSERT INTO [dbo].[SUPPLIER](SUPPLIER_NAME,ADDRESS,CONTACT_NO,ENTRY_BY,UPDATED_BY)
VALUES
('AAA','DHAKA','01947617894',10001,10001),
('BBB','DHAKA','01703197174',10002,10002)
GO


-->>> [dbo].[PURCHASE_RECEIVE] 

INSERT INTO [dbo].[PURCHASE_RECEIVE] 
VALUES(GETDATE(),1001,10002,500.00,20,10002,10002,GETDATE())
GO

---------------->>> customer.[CUSTOMER]

INSERT INTO customer.[CUSTOMER] (CUSTOMER_NAME,CUSTOMER_ADDRESS,CUSTOMER_PHONE,ENTRY_BY,STORE_CODE)
VALUES('AAA','DHAKA',01788990045,10002,10101)
GO

INSERT INTO customer.[CUSTOMER] (CUSTOMER_NAME,CUSTOMER_ADDRESS,CUSTOMER_PHONE,CUSTOMER_EMAIL,ENTRY_BY,STORE_CODE)
VALUES('AAA','DHAKA',01788990045,'mm@gmail.com',10002,10101)
GO


---------------->>> sales.SALE

INSERT INTO sales.SALE(CUSTOMAER_ID,PRODUCT_CODE,MRP,SQTY,DISC_PRCNT,VAT_PRCNT,PAYMENT_NAME,SALESMAN,STORE_CODE)
VALUES(2001,10002,575.00,110,0.05,0.02,'CARD',10002,10101)
GO

INSERT INTO sales.SALE(CUSTOMAER_ID,PRODUCT_CODE,MRP,SQTY,DISC_PRCNT,VAT_PRCNT,PAYMENT_NAME,SALESMAN,STORE_CODE)
VALUES(2002,10002,575.00,110,0.05,0.02,'CARD',10002,10101)
GO


INSERT INTO sales.SALE(CUSTOMAER_ID,PRODUCT_CODE,MRP,SQTY,DISC_PRCNT,VAT_PRCNT,PAYMENT_NAME,SALESMAN,STORE_CODE)
VALUES(2001,10002,575.00,110,0.05,0.02,'CARD',10002,10101)
GO

INSERT INTO sales.SALE(CUSTOMAER_ID,PRODUCT_CODE,MRP,SQTY,DISC_PRCNT,VAT_PRCNT,PAYMENT_NAME,SALESMAN,STORE_CODE)
VALUES(2001,10003,460.00,50,0.05,0.02,'CARD',10002,10101)
GO

INSERT INTO sales.SALE(CUSTOMAER_ID,PRODUCT_CODE,MRP,SQTY,DISC_PRCNT,VAT_PRCNT,PAYMENT_NAME,SALESMAN,STORE_CODE)
VALUES(2001,10003,460.00,50,0.05,0.02,'CARD',10002,10101)
GO

INSERT INTO sales.SALE(CUSTOMAER_ID,PRODUCT_CODE,MRP,SQTY,DISC_PRCNT,VAT_PRCNT,PAYMENT_NAME,SALESMAN,STORE_CODE)
VALUES(2001,10003,460.00,50,0.05,0.02,'CARD',10002,10101)
GO


---------->>> [SEQUENCE_EXAMPLE_TABLE]

INSERT INTO dbo.[SEQUENCE_EXAMPLE_TABLE] VALUES
(NEXT VALUE FOR [DBO].[SequenceExample],'Basir'),
(NEXT VALUE FOR [DBO].[SequenceExample],'Ahmed')
GO

INSERT INTO dbo.[SEQUENCE_EXAMPLE_TABLE] VALUES
(NEXT VALUE FOR [DBO].[SequenceExample],'RANA')
GO

-->>> warehouse

INSERT INTO warehouse VALUES('WH',1,'Shari',120)
INSERT INTO warehouse VALUES('WH',2,'Ties',1)
INSERT INTO warehouse VALUES('WH',3,'Shocks',33)
INSERT INTO warehouse VALUES('WH',4,'Jersey',17)
GO


-->>> SHOP

INSERT INTO shop VALUES('SP',1,'Shari',NULL,NULL)
INSERT INTO shop VALUES('SP',2,'Ties',NULL,NULL)
INSERT INTO shop VALUES('SP',4,'Jersey',NULL,NULL)
INSERT INTO shop VALUES('SP',7,'Belts',NULL,NULL)
GO



-------------------------------------->>> INSTEAD OF TRIGGER  -->>>
------------------------------------------------------------------>

-->>> FOR product.Department
-->>> product.tr_insteadOf_department1

INSERT INTO product.Department VALUES
('GIRL',GETDATE(),GETDATE())
GO

INSERT INTO product.Department VALUES
('GIRLS',199,8877)
GO


----------------------------->>>  CHECK TRIGGER UPDATED_DATE  -->>>
------------------------------------------------------------------>

----------------------------->>> STORE

UPDATE STORE
SET PHONE='+8801703197174'
WHERE STORE_CODE=10101
GO

-->>> [product].[Department]

UPDATE [product].[Department]
SET NAME='BABY_CARES'
WHERE DEPARTMENT_CODE=10001
GO

UPDATE product.Department
SET [NAME] = 'BABY_CARE'
WHERE DEPARTMENT_CODE = 10001
GO

--------------------------->>> [product].[Category]

UPDATE [product].[Category]
SET CATEGORY_NAME='CHOCOLATES'
WHERE CATEGORY_CODE=10012
GO

--------------------------->>> [product].[BRAND]

UPDATE [product].[BRAND]
SET BRAND_NAME='NESTLEE'
WHERE BRAND_CODE=10001
GO

UPDATE [product].[BRAND]
SET BRAND_NAME='NESTLE'
WHERE BRAND_CODE=10001
GO


--------------------------->>> product.PRODUCT

UPDATE  product.PRODUCT
SET QUANTITY=100
WHERE PRODUCT_CODE=10002
GO


--------------------------->>> [SUPPLIER]

UPDATE [SUPPLIER]
SET CONTACT_NO='01703197174'
WHERE SUPPLIER_CODE=1001
GO

--------------------------->>> PURCHASE_RECEIVE

UPDATE PURCHASE_RECEIVE
SET QTY=100
WHERE GRN_NO=20001
GO



/*
	HOW TO GET CURRENT VALUE OF SEQUENCE
*/

SELECT CURRENT_VALUE
FROM sys.sequences
WHERE name='SequenceExample'
GO


/*
	BUILD IN FUNCTION - ROW_NUMBER()
*/

SELECT DEPARTMENT_CODE,
ROW_NUMBER() OVER (ORDER BY NAME) as ROW_NUMBER
FROM product.DEPARTMENT
GO


/*
	BUILD IN FUNCTION - RANK(), DENSE_RANK()
*/


SELECT DEPARTMENT_CODE,NAME,
RANK() OVER (ORDER BY NAME) as RANK,
DENSE_RANK() OVER (ORDER BY NAME) as DENSE_RANK
FROM product.DEPARTMENT
GO


/*
	BUILD IN FUNCTION - NTILE()
*/

SELECT DEPARTMENT_CODE,
NTILE(6) OVER (ORDER BY NAME) as NTILE
FROM product.DEPARTMENT
GO


/*
	BUILD IN FUNCTION LENGTH
*/

SELECT LEN(PRODUCT_NAME) 'Length' FROM product.PRODUCT
GO


/*
	SELECT Statement 
*/

SELECT * FROM [dbo].[STORE];
SELECT * FROM [dbo].[EMPLOYEE];
SELECT * FROM [product].[Department];
SELECT * FROM [product].[BRAND];
SELECT * FROM [product].[Category];
SELECT * FROM [product].[PRODUCT];
SELECT * FROM [dbo].[SUPPLIER];
SELECT * FROM [dbo].[PURCHASE_RECEIVE];
SELECT * FROM [sales].[SALE];
SELECT * FROM [dbo].[RetailMasterAuditTable];
GO

-->>> FROM product.Department

SELECT * FROM product.Department
GO

SELECT * FROM product.Department
WHERE DEPARTMENT_CODE>=10004
GO

SELECT * FROM product.Department
WHERE DEPARTMENT_CODE>=10004
ORDER BY [NAME]
GO

SELECT * FROM product.Department
WHERE DEPARTMENT_CODE>=10010
ORDER BY DEPARTMENT_CODE DESC
GO


/*
	IN, NOT IN
*/

SELECT * FROM product.Department
WHERE [NAME] IN ('BABY_CARE','COSMETICS','DAIRY & FROZEN')
GO

SELECT * FROM product.Department
WHERE [NAME] NOT IN ('BABY_CARE','COSMETICS','DAIRY & FROZEN')
GO


-->>> IS NULL, IS NOT NULL

SELECT * 
FROM customer.CUSTOMER
WHERE CUSTOMER_EMAIL IS NULL
GO

SELECT CUSTOMER_NAME 
FROM customer.CUSTOMER
WHERE CUSTOMER_EMAIL IS NULL
GO

SELECT * 
FROM customer.CUSTOMER
WHERE CUSTOMER_EMAIL IS NOT NULL
GO


/*
	BETWEEN
*/

SELECT * FROM product.Department
WHERE DEPARTMENT_CODE BETWEEN 10004 AND 10010
ORDER BY DEPARTMENT_CODE DESC
GO


/*
	LIKE OPERATOR
*/

SELECT CATEGORY_NAME 
FROM product.Category
WHERE CATEGORY_NAME LIKE 'B%'
GO

SELECT CATEGORY_NAME 
FROM product.Category
WHERE CATEGORY_NAME LIKE '%A'
GO

SELECT CATEGORY_NAME 
FROM product.Category
WHERE CATEGORY_NAME LIKE '%A%'
GO


/*
	---->>>>  SOME, ANY
*/

IF(10045<SOME(SELECT CATEGORY_CODE FROM product.Category))

	PRINT 'TRUE'
ELSE
	PRINT 'FALSE'
GO

IF(10028>ANY(SELECT CATEGORY_CODE FROM product.Category))

	PRINT 'TRUE'
ELSE
	PRINT 'FALSE'
GO



/*
	------CONCATINATION
*/

SELECT CUSTOMER_CITY+ ', '+CUTOMER_COUNTRY AS CITY_COUNTRY
FROM customer.CUSTOMER
GO

/*
	-----STR
*/

SELECT EMPLOYEE_NAME+'. '+'YOUR EMPLOYEE CODE IS'+STR(EMPLOYEE_CODE) 'STR EXAMPLE'
FROM EMPLOYEE
GO

/*
	LTRIM(), RTRIM(),LEFT(),RIGHT(),SUBSTRING()
*/

SELECT LTRIM('                                        RADIF') 'LTRIM'
GO

SELECT RTRIM('MD. RADIF                               ')+' RAHMAN' AS 'RTRIM'
GO

SELECT LEFT('MAHBUR RAHMAN',6) AS 'LEFT'
GO

SELECT RIGHT('MAHBUR RAHMAN',6) AS 'RIGHT'
GO

SELECT LEFT(EMPLOYEE_NAME,5) AS 'LEFT'
FROM EMPLOYEE
GO

SELECT SUBSTRING('MAHBUR RAHMAN',8,10) AS 'SUBSTRING'
GO



/*
	GETDATE(), YEAR(GETDATE()),MONTH(GETDATE()),DAY(GETDATE())
*/

SELECT GETDATE() 'Today'
GO

SELECT YEAR(GETDATE()) 'YEAR'
GO

SELECT MONTH(GETDATE()) 'Month'
GO

SELECT DAY(GETDATE()) 'DAY'
GO

SELECT YEAR(CREATED_DATE) AS 'CREATED_YEAR' FROM STORE
GO

SELECT MONTH(CREATED_DATE) AS 'CREATED_MONTH' FROM STORE
GO

SELECT DAY(CREATED_DATE) AS 'CREATED_DAY' FROM STORE
GO


/*
	DATEDIFF() - YEAR, MONTH, DAY
*/

SELECT DATEDIFF(YEAR,'11-11-1984',GETDATE())
GO

SELECT DATEDIFF(YEAR,'11-11-2011',CREATED_DATE) AS 'YEAR_DIFFERENT' FROM STORE
GO

SELECT DATEDIFF(MONTH,'11-11-1984',GETDATE())
GO


SELECT DATEDIFF(MONTH,'11-11-2011',CREATED_DATE) AS 'MONTH_DIFFERENT' FROM STORE
GO

SELECT DATEDIFF(DAY,'11-11-1984',GETDATE())
GO

SELECT DATEDIFF(DAY,'11-11-2011',CREATED_DATE) AS 'DAY_DIFFERENT' FROM STORE
GO


/*
	DATEADD() - YEAR, MONTH, DAY
*/

SELECT DATEADD(YEAR,-10,GETDATE())
GO

SELECT DATEADD(YEAR,10,CREATED_DATE) AS 'NEXT_10_YEAR' FROM STORE
GO

SELECT DATEADD(MONTH,-10,GETDATE())
GO

SELECT DATEADD(MONTH,10,CREATED_DATE) AS 'NEXT_10_MONTH' FROM STORE
GO

SELECT DATEADD(DAY,10,GETDATE())
GO

SELECT DATEADD(DAY,10,CREATED_DATE) AS 'NEXT_10_DAY' FROM STORE
GO


/*
	TOP
*/

SELECT TOP 10 [NAME]
FROM product.Department
GO

/*
	TOP WITH TIES
*/

SELECT TOP 10 WITH TIES [NAME]
FROM product.Department
ORDER BY [NAME]
GO

/*
	COUNT(*)
*/

SELECT COUNT(*) COUNT FROM product.Department
GO

/*`````````````````` JOIN
	INNER JOIN
*/

SELECT * FROM product.PRODUCT
INNER JOIN product.Department
	ON PRODUCT.DEPARTMENT_CODE=Department.DEPARTMENT_CODE
GO

-- WITH ALIAS

SELECT * FROM product.PRODUCT P
INNER JOIN product.Department D
	ON P.DEPARTMENT_CODE=D.DEPARTMENT_CODE
GO


/*`````````````````` JOIN
	LEFT JOIN
*/


SELECT * FROM product.PRODUCT
LEFT JOIN product.Department
	ON PRODUCT.DEPARTMENT_CODE=Department.DEPARTMENT_CODE
GO


/*`````````````````` JOIN
	RIGHT JOIN
*/

SELECT * FROM product.PRODUCT
RIGHT JOIN product.Department
	ON PRODUCT.DEPARTMENT_CODE=Department.DEPARTMENT_CODE
GO


/*`````````````````` JOIN
	FULL JOIN
*/

SELECT * FROM product.PRODUCT
FULL JOIN product.Department
	ON PRODUCT.DEPARTMENT_CODE=Department.DEPARTMENT_CODE
GO


/*`````````````````` JOIN
	CROSS JOIN
*/

SELECT * FROM product.PRODUCT
CROSS JOIN product.Department
GO

---------------------------------------------->>> SUQUERY -->>

SELECT *
FROM product.Department
WHERE DEPARTMENT_CODE NOT IN (SELECT DISTINCT DEPARTMENT_CODE FROM product.PRODUCT)
GO


/*
	EXISTS, NOT EXISTS
*/

SELECT CATEGORY_CODE
FROM product.Category
WHERE  EXISTS (SELECT CATEGORY_CODE FROM product.PRODUCT)
GO

SELECT DEPARTMENT_CODE
FROM product.Department
WHERE  NOT EXISTS (SELECT DEPARTMENT_CODE FROM product.PRODUCT)
GO

-->>> CORRELATED SUBQUERY

SELECT * FROM customer.CUSTOMER
WHERE  EXISTS (SELECT * FROM sales.SALE WHERE CUSTOMAER_ID=SALE.CUSTOMAER_ID)
GO


--------------------------------------------- >>> ROLLUP - WITH COALESCE -->>>

SELECT COALESCE(CATEGORY_NAME,'TOTAL') AS CATEGORY,COUNT(PRODUCT_NAME) 'PRODUCT'
FROM product.Category C
INNER JOIN product.PRODUCT P
	ON C.CATEGORY_CODE=P.CATEGORY_CODE
GROUP BY ROLLUP(CATEGORY_NAME)
GO

SELECT  COALESCE (D.NAME,'DEPARTMENT TOTAL') 'DEPARTMENT',
		COALESCE(C.CATEGORY_NAME,'CATEGORY TOTAL') AS CATEGORY,
		COUNT(P.PRODUCT_NAME) 'PRODUCT'
FROM product.Category C
INNER JOIN product.PRODUCT P
	ON C.CATEGORY_CODE=P.CATEGORY_CODE
INNER JOIN product.Department D
	ON D.DEPARTMENT_CODE=P.DEPARTMENT_CODE
GROUP BY ROLLUP(D.NAME,C.CATEGORY_NAME)
GO


--------------------------------------------- >>> CUBE - WITH COALESCE -->>>

SELECT COALESCE(CATEGORY_NAME,'TOTAL') AS CATEGORY,COUNT(PRODUCT_NAME) 'PRODUCT'
FROM product.Category C
INNER JOIN product.PRODUCT P
	ON C.CATEGORY_CODE=P.CATEGORY_CODE
GROUP BY CUBE(CATEGORY_NAME)
GO

SELECT  COALESCE (D.NAME,'DEPARTMENT TOTAL') 'DEPARTMENT',
		COALESCE(C.CATEGORY_NAME,'CATEGORY TOTAL') AS CATEGORY,
		COUNT(P.PRODUCT_NAME) 'PRODUCT'
FROM product.Category C
INNER JOIN product.PRODUCT P
	ON C.CATEGORY_CODE=P.CATEGORY_CODE
INNER JOIN product.Department D
	ON D.DEPARTMENT_CODE=P.DEPARTMENT_CODE
GROUP BY CUBE(D.NAME,C.CATEGORY_NAME)
GO


--------------------------------------------- >>> GROUPING SETS -->>>

SELECT  COALESCE (D.NAME,'DEPARTMENT TOTAL') 'DEPARTMENT',
		COALESCE(C.CATEGORY_NAME,'CATEGORY TOTAL') AS CATEGORY,
		COUNT(P.PRODUCT_NAME) 'PRODUCT'
FROM product.Category C
INNER JOIN product.PRODUCT P
	ON C.CATEGORY_CODE=P.CATEGORY_CODE
INNER JOIN product.Department D
	ON D.DEPARTMENT_CODE=P.DEPARTMENT_CODE
GROUP BY GROUPING SETS (D.NAME,C.CATEGORY_NAME)
GO



/* ```````````````````````````````````````````````````````````````````
	--------------------------------------------------->>> MERGE -->>
*/

MERGE shop as tgt
USING warehouse as src

ON tgt.productId=src.productId

WHEN MATCHED 
THEN
	UPDATE 
	SET updateTime=GETDATE(),comments='Product in stock warehouse and shop'

WHEN NOT MATCHED
THEN
	INSERT (location,productId,productName,updateTime,comments)
	VALUES 
	('WH_to_SH',src.productId,src.name,GETDATE(),'Move product from warehouse to shop')

WHEN NOT MATCHED BY SOURCE
THEN
	UPDATE 
	SET updateTime=GETDATE(),comments='Last unit available in shop';
GO


/* ```````````````````````````````````````````````````````````````````
	--------------------------------------------------->>> CTE -->>
*/

USE RetailMaster
GO

WITH myCTE 
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

SELECT PRODUCT_CODE,PRODUCT_NAME FROM myCTE
GO


/*
	SUM, AVG, MIN, MAX, COUNT
*/

SELECT PRODUCT_CODE,SUM(NET_AMT) 'TOTAL SALE'
FROM sales.SALE
GROUP BY PRODUCT_CODE
GO

SELECT CUSTOMAER_ID,SUM(NET_AMT) 'TOTAL SALE'
FROM sales.SALE
GROUP BY CUSTOMAER_ID
GO

SELECT PRODUCT_CODE,MAX(NET_AMT) 'MAX SALE'
FROM sales.SALE
GROUP BY PRODUCT_CODE
GO

SELECT CUSTOMAER_ID,MIN(NET_AMT) 'MIN SALE'
FROM sales.SALE
GROUP BY CUSTOMAER_ID
GO

SELECT CUSTOMAER_ID,COUNT(NET_AMT) 'COUNT SALE'
FROM sales.SALE
GROUP BY CUSTOMAER_ID
GO



/*
	IF, ELSE IF, ELSE
*/


DECLARE @totalOrder INT
SET @totalOrder=2

IF @totalOrder>=5
	BEGIN
		PRINT 'Congratulations!!'
		PRINT 'You get a BONUS!!'
	END

ELSE IF @totalOrder>=2
	BEGIN
		PRINT 'Congratulations!!'
		PRINT 'You get a Discount!!'
	END

ELSE
	BEGIN
		PRINT 'SORRY!!!'
		PRINT 'Please One More Order!!'
	END
GO


/*
	LOOP
*/

DECLARE @val INT
SET @val=1

WHILE @val<=10
	BEGIN
		PRINT @val
		IF(@val=5)
			BREAK
		SET @val=@val+1
	END
	PRINT 'THIS IS A LOOP EXAMPLE'
GO


/*
	GOTO
*/

DECLARE @totalOrder INT
SET @totalOrder=5

IF @totalOrder>=5
	GOTO Pass
IF @totalOrder<5
	GOTO Fail
Pass:
	PRINT 'Congratulation'
	PRINT 'You get a Discount!!'
	RETURN
Fail:
		PRINT 'SORRY!!!'
		PRINT 'Please One More Order!!'
	RETURN
GO


/*
	WAITFOR
*/

SELECT GETDATE() CurrentTime
WAITFOR DELAY '00:00:01'
SELECT GETDATE() CurrentTime
GO


/*
	--TRY CATCH
*/

BEGIN TRY
	SELECT 10/0
END TRY
BEGIN CATCH
	PRINT 'Error Occured!!'
END CATCH
GO

BEGIN TRY
	DECLARE @val INT
	SET @val=1

	WHILE @val<=10
		BEGIN
			PRINT @val
			IF(@val=5)
				BREAK
			SET @val=@val/0
		END
END TRY
BEGIN CATCH
	PRINT 'Error'
	PRINT 'THIS IS A TRY CATCH EXAMPLE'
END CATCH
GO


--------------------> VIEW

EXECUTE sp_helptext 'myView'
GO

SELECT* FROM myView
GO

---->>>> WITH ENCRYPTION

EXECUTE sp_helptext 'myViewEncryption'
GO

SELECT* FROM myViewEncryption
GO

---->>>> WITH ENCRYPTION AND SCHEMABINDING

EXECUTE sp_helptext 'myViewEncryptionSchemabinding'
GO

SELECT* FROM myViewEncryptionSchemabinding
GO


------------------------->>>>>>>  DATA INSERT VIA VIEW

INSERT INTO V_DEPARTMENT VALUES
('HOMEMADE')
GO

SELECT * FROM  [product].[Department]  
GO


-------------------------------- >>>>>>> STORE PROCEDURE

EXEC dbo.showProduct
GO


--------------------------------->>> *  STORE TABLE    
----------------------------------------------------->
-->>> INSERT WITH DEFAULT PARAMETER

EXEC  dbo.sp_insert_for_store_with_default_parameter @STORE_NAME = 'SUPER STORE', @ADDRESS='DHAKA', @PHONE='+8801703776655'
GO

--->>> DELETE

EXEC dbo.sp_delete_for_store 10102
GO

---------------------->>> * [product].[Department]   
----------------------------------------------------->

----- >>>>>>> RETURNING VALUE

DECLARE @id INT
EXEC @id= sp_for_insert_department_with_Return 'WOMEN','',''
PRINT 'New DEPARTMENT id : '+STR(@id)
GO


--->>>>> OUTPUT PARAMETER

DECLARE @productId INT
EXEC sp_for_insert_department_with_output_parameter 'MEN','','',@productId OUTPUT
SELECT @productId 'New Id'
GO


----------------------->>>>> CAST , CONVERT 

SELECT CONVERT(TIME,CREATED_DATE,1) AS 'TIME'
FROM product.PRODUCT
GO

SELECT CAST(CREATED_DATE AS DATE) AS 'DATE'
FROM product.PRODUCT
GO


-------------------------------------------------------------->>> UDF (USER DEFINE FUNCTION)   
--------------------------------------------------------------------------------------------->

-->>> SCALAR-VALUED FUNCTION -- sales.udfNetSale

SELECT sales.udfNetSale(10,10,5) net_Sale
GO

SELECT sales.udfNetSale1(100,10,0.05,0.10) AS NET_SALE
GO

SELECT sales.udfNetSale1(MRP,SQTY,DISC_PRCNT,VAT_PRCNT) AS 'SALE AMOUNT' 
FROM [sales].[SALE]
GO


--->>> USE  sales.udfNetSale1() ON A TABLE

SELECT C.CUSTOMAER_ID,C.CUSTOMER_NAME,SUM(sales.udfNetSale1(S.MRP,S.SQTY,S.DISC_PRCNT,S.VAT_PRCNT)) AS 'TOTAL SALE'
FROM [sales].[SALE] S 
INNER JOIN customer.CUSTOMER C
ON S.CUSTOMAER_ID=C.CUSTOMAER_ID
GROUP BY C.CUSTOMAER_ID,C.CUSTOMER_NAME
GO

-->>> TABLE_VALUED FUNCTION

SELECT * FROM sales.product_table_valued(10002) 
GO


SELECT * FROM sales.product_table_valued2(10002,10003) 
GO

--- MULTI STATEMENT TABLE-VALUED FUNCTION

SELECT * FROM sales.multistatement_table_valued_function(2022,7)
GO






----------------------- * THE END *
-----------------------------------