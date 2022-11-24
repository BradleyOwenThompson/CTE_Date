-- Set the first day of week (1-7, 1=Monday, 7=Sunday)
SET DATEFIRST 1

-- Set the start and end period of date generation
DECLARE 
	@StartDate DATE = '2022-01-01',
	@EndDate DATE = EOMONTH(GETDATE());


-- Run CTE loop
WITH dates as (
	SELECT 
		@StartDate								AS 'Date',
		DATEADD(DAY, -DAY(@StartDate)+1, @StartDate)				AS 'Month',
		DATENAME(MONTH, @StartDate)						AS 'MonthName',
		DATEPART(MONTH, @StartDate)						AS 'MonthNumber',
		DATEADD(DAY, -DATEPART(WEEKDAY, @StartDate) +1, @StartDate)		AS 'WeekStart',
		DATEADD(DAY, 7 - DATEPART(WEEKDAY, @StartDate), @StartDate)		AS 'WeekEnd',
		DATEPART(WEEKDAY, @StartDate)						AS 'WeekDayNumber',
		DATENAME(WEEKDAY, @StartDate)						AS 'WeekDayName',
		DATEPART(YEAR, @StartDate)						AS 'Year'

	UNION ALL

	SELECT 
		DATEADD(DAY, 1, [Date]),
		DATEADD(DAY, -DAY(DATEADD(DAY, 1, [Date])) + 1, DATEADD(DAY, 1, [Date])),
		DATENAME(WEEKDAY, DATEADD(DAY, 1, [Date])),
		DATEPART(WEEKDAY, DATEADD(DAY, 1, [Date])),
		DATEADD(DAY, -DATEPART(WEEKDAY, DATEADD(DAY, 1, [Date])) + 1, DATEADD(DAY, 1, [Date])),	
		DATEADD(DAY, 7 - DATEPART(WEEKDAY, DATEADD(DAY, 1, [Date])), DATEADD(DAY, 1, [Date])),
		DATEPART(MONTH, [Date]),
		DATENAME(MONTH, DATEADD(DAY, 1, [Date])),
		DATEPART(YEAR, DATEADD(DAY, 1, [Date]))
	FROM dates 
	WHERE
		[Date] < @EndDate
)


-- Show generated dates
SELECT * FROM dates option (maxrecursion 0)
