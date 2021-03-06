/****** Script for SelectTopNRows command from SSMS  ******/
SELECT _seller_id_ AS SELLERID
      ,_seller_zip_code_prefix_ AS SELLERZIPCODE
	  , (
			SELECT top 1 [_geolocation_zip_code_prefix_] AS ZIPCODE
			  ,[_geolocation_state_] AS [GEOSTATE]
		  FROM [eCommerce].[dbo].[geolocation] AS [LOCATION]
		  WHERE SELLER._seller_zip_code_prefix_ = [LOCATION]._geolocation_zip_code_prefix_
		  FOR JSON PATH
		) AS LOCATIONS
  FROM [eCommerce].[dbo].[seller] SELLER
  WHERE _seller_id_ IN (
	SELECT DISTINCT _seller_id_
	  FROM [eCommerce].[dbo].[order] AS [ORDER]
	  JOIN order_item ORDERITEM ON ORDERITEM._order_id_ = [ORDER]._order_id_
	  WHERE [_customer_id_] IN (
		SELECT TOP 500
		  _customer_id_
		FROM [eCommerce].[dbo].[customer]
  )
  )
  FOR JSON AUTO