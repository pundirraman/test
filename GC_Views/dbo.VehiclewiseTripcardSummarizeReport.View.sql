USE [GreencardLive]
GO
/****** Object:  View [dbo].[VehiclewiseTripcardSummarizeReport]    Script Date: 12-04-2023 12:50:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VehiclewiseTripcardSummarizeReport]
AS

SELECT * FROM   
(
    SELECT 
        Type, 
        tripId,
		greencard_year
    FROM 
        GCLiveServer.dbo.GreenCardTripPassengerView 
) t 
PIVOT(
    COUNT(tripId) 
    FOR Type IN (Maxi,Taxi,[Mini Bus],Bus)
) AS pivot_table
UNION ALL
SELECT * FROM   
(
    SELECT 
        Type, 
        tripId,
		greencard_year
    FROM GreenCardTripPassengerView 
) t 
PIVOT(
    COUNT(tripId) 
    FOR Type IN (Maxi,Taxi,[Mini Bus],Bus)
) AS pivot_table

GO
