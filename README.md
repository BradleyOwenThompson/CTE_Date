# CTE_Date
A recursive CTE to generate dates.


Set DATEFIRST to correspond with your first day of the week [Read More](https://learn.microsoft.com/en-us/sql/t-sql/statements/set-datefirst-transact-sql?view=sql-server-ver16).
``` SQL
-- Set the first day of week (1-7, 1=Monday, 7=Sunday)
SET DATEFIRST 1
```

Set @StartDate to be equal to your minimum date, and @EndDate to the maximum
``` SQL
-- Set the start and end period of date generation
DECLARE 
	@StartDate DATE = '2022-01-01',
	@EndDate DATE = EOMONTH(GETDATE());
 ```
