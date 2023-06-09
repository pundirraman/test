USE [GreencardLive]
GO
/****** Object:  View [dbo].[VehicleClasswiseGreencardSummarizeReport]    Script Date: 12-04-2023 12:50:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Select * from VehicleClasswiseGreencardSummarizeReport
CREATE 
VIEW [dbo].[VehicleClasswiseGreencardSummarizeReport] 
AS

SELECT * FROM   
(
    SELECT 
        Type, 
        applicationId,
		greencard_year
    FROM 
        GCLiveServer.dbo.GreenCardData where application_status_code='G' 
		and regn_no<>'' and greencard_no not like 'NT%'
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
        GreenCardData where ApplicationStatus='G' 
		and RegNo<>'' 
) t 
PIVOT(
    COUNT(applicationId) 
    FOR Type IN (
        Maxi,Taxi,[Mini Bus],Bus)
) AS pivot_table
GO
