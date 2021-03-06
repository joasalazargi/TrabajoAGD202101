/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [_order_id_] AS ORDERID
      ,[_customer_id_] AS CUSTOMERID
      ,[_order_status_] AS ORDERSTATUS
      ,[_order_purchase_timestamp_] AS TIMESTAMPPURCHASE
      ,[_order_approved_at_] AS DATEAPPOVED
      ,[_order_delivered_carrier_date_] AS DATEDLIVEREDCARRIER
      ,[_order_delivered_customer_date_] AS DATEORDERDELIVEREDCUSTO
      ,[_order_estimated_delivery_date_] AS ORDERESTIMATEDDELIVERY
	  ,(SELECT [_order_item_id_] AS ORDERITEMID
			,[_product_id_] AS PRODUCTID
			,[_seller_id_] AS SELLERID
			,[_shipping_limit_date_] AS DATESHIPPING
			,[_price_] AS PRICE
			,[_freight_value_] AS VALUEFREIGHT
			, (SELECT [product_id] AS PRODUCTID
				  ,[product_weight_g] AS PRODUCTWEIGHT
				  ,[product_category_name] AS CATEGORY
			  FROM [eCommerce].[dbo].[product] AS PRODUCT 
			  WHERE ORDERITEM._product_id_ = PRODUCT.product_id
			  FOR JSON PATH) AS PRODUCTS
             FROM [eCommerce].[dbo].[order_item] AS ORDERITEM
       WHERE [ORDER]._order_id_ = ORDERITEM._order_id_
        FOR JSON PATH) AS ORDERITEMS
  FROM [eCommerce].[dbo].[order] AS [ORDER]
  WHERE [_customer_id_] IN (
	SELECT TOP 500
      _customer_id_
	FROM [eCommerce].[dbo].[customer]
  )
  FOR JSON AUTO
