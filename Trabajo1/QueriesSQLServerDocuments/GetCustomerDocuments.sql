SELECT TOP 500
      _customer_id_ AS CUSTOMERID
      ,[_customer_zip_code_prefix_] AS CUSTOMERZIPCODE
	  , (
			SELECT top 1 [_geolocation_zip_code_prefix_] AS ZIPCODE
			  ,[_geolocation_state_] AS [GEOSTATE]
		  FROM [eCommerce].[dbo].[geolocation] AS [LOCATION]
		  WHERE CUSTOMER._customer_zip_code_prefix_ = LOCATION._geolocation_zip_code_prefix_
		  FOR JSON PATH
		) AS LOCATIONS
  FROM [eCommerce].[dbo].[customer] AS CUSTOMER
  FOR JSON AUTO