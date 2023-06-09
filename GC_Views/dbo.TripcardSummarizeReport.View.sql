USE [GreencardLive]
GO
/****** Object:  View [dbo].[TripcardSummarizeReport]    Script Date: 12-04-2023 12:50:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[TripcardSummarizeReport]
AS

SELECT * FROM   
(
    SELECT 
	CASE WHEN greencard_no like 'NT%' then 'Private' else 'Commercial' end as Type, 
        tripId,
		greencard_year
    FROM 
        GCLiveServer.dbo.GreencardTripDetails
) t 
PIVOT(
    COUNT(tripId) 
    FOR Type IN ( Commercial,Private)
) AS pivot_table
UNION ALL
SELECT * FROM   
(
    SELECT 
	CASE WHEN greencard_no like 'NT%' then 'Private' else 'Commercial' end as Type, 
        tripId,
		greencard_year
    FROM GreencardTripDetails
) t 
PIVOT(
    COUNT(tripId) 
    FOR Type IN ( Commercial,Private)
) AS pivot_table

GO
