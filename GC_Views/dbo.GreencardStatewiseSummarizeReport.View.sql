USE [GreencardLive]
GO
/****** Object:  View [dbo].[GreencardStatewiseSummarizeReport]    Script Date: 12-04-2023 12:50:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Select * from GreencardStatewiseSummarizeReport
CREATE VIEW [dbo].[GreencardStatewiseSummarizeReport]
AS

SELECT * FROM   
(
    SELECT 
        Case when vehicleRegisteredState like '%Uttarakhand%' then 'InState' else 'OutState' end as Type, 
        greencard_no,
		greencard_year
    FROM 
        GCLiveServer.dbo.GreenCardData  where application_status_code='G' and greencard_no like 'UK%'
) t 
PIVOT(
    COUNT(greencard_no) 
    FOR Type IN (InState,OutState)
) AS pivot_table
UNION ALL
SELECT * FROM   
(
    SELECT 
         Case when vehicleRegisteredState like '%Uttarakhand%' then 'InState' else 'OutState' end as Type, 
        GreencardNo,
		greencard_year 
    FROM GreenCardData 
) t 
PIVOT(
    COUNT(GreencardNo) 
    FOR Type IN (InState,OutState)
) AS pivot_table
GO
