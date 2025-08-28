CREATE LOGIN MyTableauUser WITH PASSWORD = 'Cognicalrocks!1';

--Create the user in the database from the server login
CREATE USER MyTableauUser FOR LOGIN MyTableauUser;

--Give the user read-only access to the database
ALTER ROLE db_datareader ADD MEMBER MyTableauUser;

SELECT name FROM sys.sql_logins WHERE name = 'MyTableauUser';

