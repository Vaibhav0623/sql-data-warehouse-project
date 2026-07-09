/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

DROP PROCEDURE bronze.load_bronze;


EXEC bronze.load_bronze;


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME;
	DECLARE @pro_start_T DATETIME, @pro_end_T DATETIME;
	BEGIN TRY
		PRINT '========================';
		PRINT 'Loading Bronze Layer';
		PRINT '========================';

		-- Table - 01

		PRINT '--------------------------';
		PRINT 'Loading CRM Table';
		PRINT '--------------------------';

		SET @pro_start_T = GETDATE();	

		SET @start_time = GETDATE();
		-- Deleting the content of table
		PRINT 'TRUNCATE FROM TABLE >> bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		-- Inserting The Data in The Tables
		PRINT 'Inserting Data Into >> bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		
		PRINT '>> Loading Duration:' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' Second';
		PRINT '>> ----------------------';

		-- Table - 02
		
		SET @start_time = GETDATE()
		-- Deleting the content of table
	
		PRINT 'TRUNCATE FROM TABLE >> bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		-- Inserting The Data in The Tables
	
		PRINT 'Inserting Data Into>> bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		
		PRINT '>> Loading Duration:' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' Second';
		PRINT '>> ----------------------';

		-- Table - 03
		SET @start_time = GETDATE()
		-- Deleting the content of table
	
		PRINT 'TRUNCATE FROM TABLE >> bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		-- Inserting The Data in The Tables
	
		PRINT 'Inserting Data Into >> bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		
		PRINT '>> Loading Duration:' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' Second';
		PRINT '>> ----------------------';

		PRINT '--------------------------';
		PRINT 'Loading ERP Table';
		PRINT '--------------------------';


		-- Table - 04
		SET @start_time = GETDATE()
		-- Deleting the content of table
	
		PRINT 'TRUNCATE FROM TABLE >> bronze.erp_CUST_AZ12';
		TRUNCATE TABLE bronze.erp_CUST_AZ12;

		-- Inserting The Data in The Tables
	
		PRINT 'Inserting Data Into >> bronze.erp_CUST_AZ12';
		BULK INSERT bronze.erp_CUST_AZ12
		FROM 'C:\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		
		PRINT '>> Loading Duration:' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' Second';
		PRINT '>> ----------------------';
		
		-- Table - 05
		
		SET @start_time = GETDATE()
		-- Deleting the content of table
	
		PRINT 'TRUNCATE FROM TABLE >> bronze.erp_LOC_A101';
		TRUNCATE TABLE bronze.erp_LOC_A101;

		-- Inserting The Data in The Tables
	
		PRINT 'Inserting Data Into >> bronze.erp_LOC_A101';
		BULK INSERT bronze.erp_LOC_A101
		FROM 'C:\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		
		PRINT '>> Loading Duration:' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' Second';
		PRINT '>> ----------------------';

		-- Taable - 06
		SET @start_time = GETDATE()

		-- Deleting the content of table
		PRINT 'TRUNCATE FROM TABLE >> erp_PX_CAT_G1V2';
		TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;

		-- Inserting The Data in The Tables
		PRINT 'Inserting Data Into >> erp_PX_CAT_G1V2';
		BULK INSERT bronze.erp_PX_CAT_G1V2
		FROM 'C:\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		
		PRINT '>> Loading Duration:' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' Second';
		PRINT '>> ----------------------';

		SET @pro_end_T = GETDATE();
		PRINT '>> >>-->>>---->>-------';
		PRINT '>> Loading Time of Whole BATCH:' + CAST(DATEDIFF(SECOND, @pro_start_T, @pro_end_T) AS NVARCHAR) + ' Second';
		PRINT '>> >>-->>>---->>-------';


	END TRY 
	BEGIN CATCH
	PRINT '=========================================';
	PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
	PRINT 'ERROR MESSAGE' + Error_message();
	PRINT 'ERROR MESSAGE' + CAST (ERROR_NUMBER() AS NVARCHAR);
	PRINT 'ERROR MESSAGE' + CAST (ERROR_STATE() AS NVARCHAR);
	PRINT '=========================================';
	END CATCH
END
