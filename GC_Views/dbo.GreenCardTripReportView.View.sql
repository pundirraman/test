USE [GreencardLive]
GO
/****** Object:  View [dbo].[GreenCardTripReportView]    Script Date: 12-04-2023 12:50:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- select * from GreenCardTripReportView where greencard_year='2022'
CREATE VIEW [dbo].[GreenCardTripReportView]
AS
select T.greencard_no,G.RegNo,G.vehicleRegisteredState,G.vehicleClass,G.noOfseat,
VehicleClass as Type,OwnerName,ApplicantMobile,VehicleColor,
G.AppliedRTO,G.ApplicationStatus,T.applicationId,T.tripId,T.noOfPassangers,G.GreencardAppliedDate,P.Passenger,T.appliedDate
,T.dhamName,C.dham_eng as dham_name,T.trip_status,T.tripStartDate,T.tripEndDate,t.passanger_ListStatus,G.greencard_year from GreenCardTripDetails T 
right join (SELECT tripId,COUNT(1) AS Passenger FROM (Select distinct [passengerID], [tripId] FROM GreencardPassangerDetail) as Trip group by tripId) P on T.tripId=P.tripId
INNER join GreenCardApprovedData G on T.greencard_no=G.GreencardNo
inner join CharDhams C on C.dhamID=T.dhamName
GO
