USE gold_dussbmw_db
GO

CREATE OR ALTER PROC sp_createview_gold @ViewName nvarchar(100)
AS 
BEGIN
    DECLARE @statement VARCHAR(MAX)
    SET @statement = N'CREATE OR ALTER VIEW ' + 'vw_' + @ViewName + ' AS
        SELECT
            *
        FROM
            OPENROWSET(
                BULK ''https://sadussbmwprod1.dfs.core.windows.net/gold/' + @ViewName + '/'',
                FORMAT = ''DELTA''
            ) AS [result]'

    EXEC (@statement)
END
GO