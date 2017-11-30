-----------------------------------------------------------------------------------
---Name: Get all measures on a cube
---Description: Uses MDX to return all measures on a cube using OpenRowset. It uses OpenRowset instead of OpenQuery as it can be used when the cube and SQL server	are on the same local host.

Declare @CubeName nvarchar(250) = '<databasename>'

DECLARE @MDX nvarchar(max) =
	' 
		select *
		from OpenRowset
					(
						''MSOLAP'', 
						''Data Source=localhost;Initial Catalog=nationwide;Provider=MSOLAP.4;Integrated Security=SSPI;Format=Tabular;'',
						''SELECT
								[CATALOG_NAME] as [DATABASE]
								,CUBE_NAME AS [CUBE]
								,[MEASUREGROUP_NAME] AS [FOLDER]
								,[MEASURE_CAPTION] AS [MEASURE]
								,[MEASURE_IS_VISIBLE]
						FROM 
							$SYSTEM.MDSCHEMA_MEASURES
						WHERE 
							CUBE_NAME = ('''''+@CubeName+''''')
						ORDER BY 
							[MEASUREGROUP_NAME]''
					)
	';

EXECUTE (@MDX);
PRINT (@MDX)


