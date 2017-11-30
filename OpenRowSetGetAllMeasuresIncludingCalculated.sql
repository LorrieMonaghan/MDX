-----------------------------------------------------------------------------------
---Name: Get all measures and calculated measures
---Description: Uses MDX to return all measures and calculated measures on a cube using OpenRowset. It uses OpenRowset instead of OpenQuery as it can be used when the cube and SQL server are on the same local host.

Declare @CubeName nvarchar(250) = '<cubename>'

DECLARE @MDX nvarchar(max) =
	' 
		select *
		from OpenRowset
					(
						''MSOLAP'', 
						''Data Source=localhost;Initial Catalog=nationwide;Provider=MSOLAP.4;Integrated Security=SSPI;Format=Tabular;'',
						''SELECT	
							[MEMBER_UNIQUE_NAME] AS [MEASURE]
							,[MEMBER_CAPTION] AS [CAPTION]
							,[EXPRESSION]
							,[MEMBER_TYPE]
						FROM 
							$system.MDSCHEMA_MEMBERS
						WHERE 
							CUBE_NAME = ('''''+@CubeName+''''')
							AND [MEMBER_TYPE] = 3
							OR [MEMBER_TYPE] = 4''
					)
	';

EXECUTE (@MDX);
PRINT (@MDX)
