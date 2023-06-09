USE [GreencardLive]
GO
/****** Object:  View [dbo].[IssueRejectSummarizeReport]    Script Date: 12-04-2023 12:50:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[IssueRejectSummarizeReport]
AS

SELECT * FROM   
(
    SELECT 
        S.application_status_descr as Type, 
        applicationId,
		greencard_year
    FROM 
        GCLiveServer.dbo.GreenCardData G INNER JOIN GCLiveServer.dbo.GreenCardApplStatus S ON G.application_status_code=S.application_status_code where (greencard_no not like 'NT%' or greencard_no is null)  and regn_no<>''
) t 
PIVOT(
    COUNT(applicationId) 
    FOR Type IN (
        Granted,Blocked,Unfit)
) AS pivot_table
UNION ALL
SELECT * FROM   
(
    SELECT 
        S.application_status_descr as Type, 
        applicationId,
		greencard_year
    FROM GreenCardApplicationData G INNER JOIN GCLiveServer.dbo.GreenCardApplStatus S ON G.application_status_code=S.application_status_code where  regn_no<>''
) t 
PIVOT(
    COUNT(applicationId) 
    FOR Type IN (
        Granted,Blocked,Unfit)
) AS pivot_table
GO
