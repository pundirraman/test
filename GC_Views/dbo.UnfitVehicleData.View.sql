USE [GreencardLive]
GO
/****** Object:  View [dbo].[UnfitVehicleData]    Script Date: 12-04-2023 12:50:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- select * from UnfitVehicleData 
CREATE VIEW [dbo].[UnfitVehicleData]
AS
Select regn_no,applied_rto_cd,vehicleType,case when noOfseat<8 then 'Taxi' when  noOfseat between 8 and 13 then 'Maxi' when noOfseat between 14 and 25 then 'Mini Bus' else 'Bus' end as Type,
owner_name,applicantMobile,scrutiny_officer_remarks,inspection_dt,O.officer_name as inspection_officer,vehicleModel,scrutiny_auth_user,scrutiny_datetime 
from GreenCardApplicationData G INNER JOIN GreencardOfficer O on G.inspection_officer=O.officerID 
where application_status_code='F' and greencard_year=YEAR(GETDATE())
UNION
Select regn_no,applied_rto_cd,vehicleType,case when noOfseat<8 then 'Taxi' when  noOfseat between 8 and 13 then 'Maxi' when noOfseat between 14 and 25 then 'Mini Bus' else 'Bus' end as Type,
owner_name,applicantMobile,scrutiny_officer_remarks,inspection_dt,O.officer_name as inspection_officer,vehicleModel,scrutiny_auth_user,scrutiny_datetime 
from GreenCardApplicationDataLog G INNER JOIN GreencardOfficer O on G.inspection_officer=O.officerID 
where application_status_code='F' and greencard_year=YEAR(GETDATE())
GO
