-- Adding quick information to check later... Maybe now?

/************************************************
				QUERYING XEs
***********************************************/

SELECT * FROM sys.dm_xe_packages
go

SELECT p.name AS package_name,
	   p.description,
		o.name AS NAME,
		o.object_type,
		o.description
FROM sys.dm_xe_packages AS p
JOIN sys.dm_xe_objects AS o 
ON p.guid = o.package_guid
WHERE (1=0
	--OR o.object_type = 'TARGET'
	OR o.object_type = 'EVENT'
	--OR o.object_type = 'ACTION'
	--OR o.object_type = 'MAP'
	--OR o.object_type = 'message'
	--OR o.object_type = 'pred_compare'
	--OR o.object_type = 'pred_source'
	--OR o.object_type = 'type'
	)
	AND
	O.name LIKE '%ESCALATION%'
ORDER BY P.name, O.name
GO

SELECT 
		p.name AS package_name,
	    o.name AS NAME,
		oc.name AS column_name,
	    oc.column_type AS column_type,
	    oc.column_value AS column_value,
	    oc.description AS column_description
FROM sys.dm_xe_packages AS p
JOIN sys.dm_xe_objects AS o
	    ON p.guid = o.package_guid
JOIN sys.dm_xe_object_columns AS oc
	    ON o.name = oc.OBJECT_NAME
	    AND o.package_guid = oc.object_package_guid
WHERE 1=1 
	AND o.object_type = 'event'
	AND o.name LIKE '%ESCALATION%'
GO

-- Maps...
SELECT name, map_key, map_value 
FROM sys.dm_xe_map_values
WHERE name = 'lock_escalation_cause'
GO

SELECT name, map_key, map_value 
FROM sys.dm_xe_map_values
WHERE name = 'page_compression_failure_reason' -- 
GO

-- WAIT Types
SELECT name, map_key, map_value 
FROM sys.dm_xe_map_values
WHERE name = 'wait_types'
ORDER BY map_value
GO

-- Elementos customizáveis
SELECT
	p.name AS package_name,
	o.name AS NAME,
	o.description,	
	oc.name AS column_name,
	oc.column_type AS column_type,
	oc.column_value AS column_value,
	oc.description AS column_description
FROM sys.dm_xe_packages AS p
JOIN sys.dm_xe_objects AS o
	    ON p.guid = o.package_guid
JOIN sys.dm_xe_object_columns AS oc
	    ON o.name = oc.OBJECT_NAME
	    AND o.package_guid = oc.object_package_guid
WHERE 1=1 
	AND o.object_type = 'event'
	--AND o.name = 'file_write_completed'
	AND oc.column_type = 'customizable'
GO

-- Target Configurable Fields
SELECT 
	p.name AS package_name,
	o.name AS NAME,
	o.description,	
	oc.name AS column_name,
	oc.column_type AS column_type,
	oc.column_value AS column_value,
	oc.description AS column_description
FROM sys.dm_xe_packages AS p
JOIN sys.dm_xe_objects AS o
	    ON p.guid = o.package_guid
JOIN sys.dm_xe_object_columns AS oc
	    ON o.name = oc.OBJECT_NAME
	    AND o.package_guid = oc.object_package_guid
WHERE 1=1
	AND o.object_type = 'target'
GO