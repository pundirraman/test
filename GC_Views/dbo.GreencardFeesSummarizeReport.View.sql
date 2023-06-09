USE [GreencardLive]
GO
/****** Object:  View [dbo].[GreencardFeesSummarizeReport]    Script Date: 12-04-2023 12:50:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Select * from GreencardFeesSummarizeReport
CREATE 
VIEW [dbo].[GreencardFeesSummarizeReport] 
AS

SELECT * FROM   
(
    SELECT 
        purpose_cd,
		(cast(total_amt as decimal)) AS Fees,
		greencard_year
    FROM 
        GCLiveServer.dbo.GreencardFees where purpose_cd IN('EN','GA','VR') and payment_status='S'
) t 
PIVOT(
    SUM(Fees) 
    FOR purpose_cd IN (EN,GA,VR)
) AS pivot_table
UNION ALL
SELECT * FROM   
(
    SELECT 
        purpose_cd, 
        (cast(total_amt as decimal)) AS Fees,
		greencard_year
    FROM 
        GreencardFees where purpose_cd IN('EN','GA','VR') and payment_status='S'
) t 
PIVOT(
    SUM(Fees)
    FOR purpose_cd IN (EN,GA,VR)
) AS pivot_table

GO
