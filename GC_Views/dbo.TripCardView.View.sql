USE [GreencardLive]
GO
/****** Object:  View [dbo].[TripCardView]    Script Date: 12-04-2023 12:50:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- SELECT * FROM TripCardView
CREATE VIEW [dbo].[TripCardView]
AS
	select G.GreencardNo,dl_number,temporary_AuthorizatioPermitNo,temporary_AuthorizatioPermitValidity,TripStartPlace,
	G.noOfseat,G.vehicleRegisteredState,VehicleClass as Type,
	TripCardSerial,G.AppliedRTO,dhamName,tripStartDate,tripEndDate,trip_status,uk_statetax_validfrom,uk_statetax_validupto,noOfPassangers, ISNULL(NUMBER,0) AS PASSENGER
	,appliedDate,scrutiny_date,scrutiny_username,scrutiny_remarks,approval_date,approval_remarks,approval_username,D.tripId,passanger_ListStatus,TotalDham,
   (
   select ','+S.DhamEng
   from MasterDham as S
   where ',' + D.TotalDham + ',' like '%,' + cast(S.id as nvarchar(20)) + ',%'
   for xml path(''), type
   ).value('substring(text()[1], 2)', 'varchar(max)') as Dham,g.greencard_year
from GreencardTripDetails as D 
LEFT JOIN (SELECT tripId,COUNT(1) AS NUMBER FROM (Select distinct [passengerID], [tripId] FROM GreencardPassangerDetail) as Trip GROUP BY tripId) AS P  ON D.tripId=P.tripId
INNER join GreenCardApprovedData G on D.greencard_no=G.GreencardNo





GO
