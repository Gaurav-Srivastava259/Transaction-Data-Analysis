Create Database PGDCS
USE PGDCS
Select * from Trans_Tbl
SELECT * From Cust_Tbl

     DELETE FROM Trans_Tbl
	 WHERE MCN IS NULL OR Store_ID IS NULL
	 OR Cash_Memo_No IS NULL;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
    UPDATE Trans_Tbl
	SET MCN = REPLACE (MCN,'''','')
	WHERE CHARINDEX ('''',MCN) > 0;
--------------------------------------------------------------------------
--------------------------------------------------------------------------
   SELECT* FROM Trans_Tbl AS T
   JOIN Cust_Tbl AS C ON CAST(T.MCN AS FLOAT) = C.CustID

   SELECT A. Itemcount,A.Transactiondate,A.Totalamount,
   A.SaleAmount,A.Salepercent,A.Cash_Memo_No,A.Dep1Amount,
   A.Dep2Amount,A.Dep3Amount,A.Dep4Amount,A.Store_id,A.Mcn,
   B.Custid,B.Gender,B.[Location],B.Age,B.Cust_seg,B.Sample_flag
   INTO Final_Tbl FROM Trans_Tbl AS A
   LEFT JOIN Cust_Tbl AS B
   ON A.Mcn = B.CustID

-------------------------------------------------------------------
-------------------------------------------------------------------
  SELECT * FROM Final_Tbl

Q1 SELECT COUNT (*) 
   FROM Final_Tbl
   WHERE ItemCount IS NULL OR SalePercent IS NULL OR Cash_Memo_No IS NULL
   OR Dep1Amount IS NULL OR Dep3Amount IS NULL OR Store_ID IS NULL OR
   MCN IS NULL OR CustID IS NULL OR Gender IS NULL OR [Location] IS NULL OR
   AGE IS NULL OR Cust_seg IS NULL OR Sample_flag IS NULL
------------------------------------------------------------------
------------------------------------------------------------------
Q2. SELECT COUNT (DISTINCT mcn) As Tot_Cus_Shopped
    FROM Final_Tbl

------------------------------------------------------------------
------------------------------------------------------------------
Q3.  SELECT MCN, COUNT(DISTINCT STORE_ID) AS Store_Count
     FROM Final_Tbl
	 GROUP BY MCN
	 HAVING COUNT(DISTINCT STORE_ID) > 1;
  ------------------------------------------------------------------
  ------------------------------------------------------------------
Q4. SELECT DATENAME(WEEKDAY,TRANSACTIONDATE) AS [WEEKDAY],
    COUNT(CAST(CUSTID AS INT)) AS TOTAL_CUSTOMERS, COUNT(CAST(CASH_MEMO_NO AS FLOAT)) AS TRNSACTIONS
	SUM(CAST(SALEAMOUNT AS FLOAT))AS TOTAL_SALES,SUM(CAST(ITEMCOUNT AS FLOAT)) AS TOAL_QTY
	FROM Final_Tbl
	GROUP BY DATENAME(WEEKDAY,TRANSACTIONDATE);

-------------------------------------------------------------------------
-------------------------------------------------------------------------
Q5. SELECT AVG(TOTALAMOUNT) AS Overall_Avg_Rev_Per_Cust
    FROM Final_Tbl

    SELECT [LOCATION], AVG(SALEAMOUNT) AS Avg_Rev_Per_Cust_Location
    FROM Final_Tbl
	GROUP BY [LOCATION]
	ORDER BY Avg_Rev_Per_Cust_Location DESC
---------------------------------------------------------------------------
--------------------------------------------------------------------------

Q6.	SELECT STORE_ID,AVG(TOTALAMOUNT) AS Avg_Rev_Per_Cust
	FROM Final_Tbl
	GROUP BY STORE_ID
	ORDER BY Avg_Rev_Per_Cust DESC
-----------------------------------------------------------------------------
----------------------------------------------------------------------------
Q7. Select Store_id,
    SUM(CONVERT(DECIMAL(10,2), Dep1Amount))+
	SUM(CONVERT(DECIMAL(10,2), Dep2Amount))+
	SUM(CONVERT(DECIMAL(10,2), Dep3Amount))+
	SUM(CONVERT(DECIMAL(10,2), Dep4Amount)) AS Tot_Spent_Amt
	FROM Final_Tbl
	GROUP BY Store_id;
------------------------------------------------------------------------------
------------------------------------------------------------------------------
Q8.SELECT MAX(TransactionDate) AS Latest_Trans_Date
   FROM Final_Tbl

   SELECT MIN(TransactionDate) AS Oldest_Trans_Date
   FROM Final_Tbl
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
Q9.  SELECT DATEDIFF(MONTH,MIN(TRANSACTIONDATE),
     MAX(TRANSACTIONDATE))+ 1 AS Months_Data
     FROM Final_Tbl
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
Q10.SELECT * FROM Final_Tbl
    SELECT TOP 3 [LOCATION],SUM(SALEAMOUNT) AS TOT_SPENT,
	SUM(SALEAMOUNT)/(SELECT SUM(SALEAMOUNT) FROM Final_Tbl)*100 AS Tot_Contribution
	FROM Final_Tbl
	GROUP BY [LOCATION]
	ORDER BY SUM(SALEAMOUNT) DESC;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
Q11. SELECT GENDER,
     COUNT(DISTINCT MCN) AS CustomerCount,
	 SUM(SALEAMOUNT) AS TotalSales
	 FROM Final_Tbl
	 GROUP BY GENDER;
------------------------------------------------------------------------
------------------------------------------------------------------------
Q12. SELECT STORE_ID,
     SUM(TotalAmount - SaleAmount) AS TotalDiscount,
	 ROUND((SUM(TotalAmount - SaleAmount)/ SUM(TotalAmount))*100,2) AS Percent_Discount
	 FROM Final_Tbl
	 GROUP BY Store_ID;

-----------------------------------------------------------------------
-----------------------------------------------------------------------
Q13. WITH SegmentSales AS (
     SELECT Cust_Seg,SUM(SaleAmount) AS TotalSales
	 FROM Final_Tbl
	 GROUP BY Cust_Seg)
	 
	 SELECT Cust_Seg,TotalSales
	 FROM Segmentsales
	 WHERE TotalSales = (SELECT MAX(TotalSales) 
	 FROM SegmentSales);

--------------------------------------------------------------------
--------------------------------------------------------------------
Q14. SELECT Store_id,Gender,Cust_Seg,
     AVG(SaleAmount) AS Avg_Trans_Value
	 FROM Final_Tbl
	 GROUP BY Store_id,Gender,Cust_Seg;
------------------------------------------------------------------------
------------------------------------------------------------------------
Q15.CREATE TABLE Customer_360 (Customer_id int,Gender Varchar(6),
    [Location]varchar(200),Age int,Cust_Seg varchar(250),No_Of_Transaction int,No_of_items int,
	Total_sale_amount float,Average_Transaction_Value Float,TotalSpend_Dep1 float,
	TotalSpend_Dep2 float,TotalSpend_Dep3 float,TotalSpend_Dep4 float,No_Transactons_Dept1 int,
	No_Transactons_Dept2 int,No_Transactons_Dept3 int,No_Transactons_Dept4 int,
	No_Transactions_Weekdays int,No_Transactions_Weekends int,Rank_Based_On_Spent Int,
	Decile int);

	Select * from Customer_360

--Create a new table 'sample data' by selecting rows with sample_flag =1
   SELECT * INTO SAMPLE_DATA
   FROM Final_Tbl
   WHERE SAMPLE_FLAG=1;
   
   SELECT *FROM SAMPLE_DATA
---------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------