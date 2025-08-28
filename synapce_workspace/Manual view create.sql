CREATE OR ALTER VIEW vw_pcodes as
SELECT
    *
FROM
    OPENROWSET(
        BULK 'https://sadussbmwprod1.dfs.core.windows.net/gold/pcodes/',
        FORMAT = 'DELTA'
    -- )
    --  WITH (
    --     column1 INT,
    --     column2 VARCHAR(100),
    --     last_modified_date DATETIME2
    ) AS [result];

CREATE OR ALTER VIEW vw_parsed_dealers as
SELECT
    *
FROM
    OPENROWSET(
        BULK 'https://sadussbmwprod1.dfs.core.windows.net/gold/parsed_dealers/',
        FORMAT = 'DELTA'
    ) AS [result];