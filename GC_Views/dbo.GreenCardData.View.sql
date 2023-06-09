USE [GreencardLive]
GO
/****** Object:  View [dbo].[GreenCardData]    Script Date: 12-04-2023 12:50:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






-- select * from GreenCardData 
CREATE VIEW [dbo].[GreenCardData]
AS
SELECT applicationId,GreencardNo,Convert(varchar(10),CONVERT(date,GreencardValidFrom,106),103) as greencard_validfrom,Convert(varchar(10),CONVERT(date,GreencardValidUpto,106),103) as greencard_validupto,
permitValidity, applicantMobile, OwnerName, noOfseat,'TRANSPORT' as GreenCardType,PermitNo,PermitType,
RegNo,vehicleType,vehicleClass,AppliedRTO,vehicleRegisteredState,case when noOfseat<8 then 'Taxi' when  noOfseat between 8 and 13 then 'Maxi' when noOfseat between 14 and 25 then 'Mini Bus' else 'Bus' end as Type,
ApplicationStatus,ApplicationType,GreencardAppliedDate,Convert(varchar(10),CONVERT(date,GreenCardRenewDate,106),103) as GreenCardRenewDate,ApprovingDatetime,ApprovalAuthUser, greencard_year
FROM GreenCardApprovedData WHERE ApplicationStatus='G' 




GO
