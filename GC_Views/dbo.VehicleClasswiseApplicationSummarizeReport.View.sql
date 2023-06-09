USE [GreencardLive]
GO
/****** Object:  View [dbo].[VehicleClasswiseApplicationSummarizeReport]    Script Date: 12-04-2023 12:50:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Select * from VehicleClasswiseApplicationSummarizeReport
CREATE 
VIEW [dbo].[VehicleClasswiseApplicationSummarizeReport] 
AS

SELECT * FROM   
(
    SELECT 
        Type, 
        applicationId,
		greencard_year
    FROM 
        GCLiveServer.dbo.GreenCardData where application_status_code IN ('G','R','A','S','P','O') 
		and regn_no<>'' 
) t 
PIVOT(
    COUNT(applicationId) 
    FOR Type IN (
        Maxi,Taxi,[Mini Bus],Bus)
) AS pivot_table
UNION ALL
SELECT * FROM   
(
    SELECT 
        Type, 
        applicationId,
		greencard_year
    FROM 
        GreenCardData where ApplicationStatus IN ('G','R','A','S','P','O') 
		and RegNo<>'' 
) t 
PIVOT(
    COUNT(applicationId) 
    FOR Type IN (
        Maxi,Taxi,[Mini Bus],Bus)
) AS pivot_table
GO
