USE [GreencardLive]
GO
/****** Object:  View [dbo].[GreenCardTripPassengerView]    Script Date: 12-04-2023 12:50:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- select * from GreenCardTripPassengerView where greencard_year=year(GETDATE()) and application_status_code='G' and Dham='Hem khund'
CREATE VIEW [dbo].[GreenCardTripPassengerView]
AS
select T.greencard_no,G.RegNo,dl_number,G.vehicleRegisteredState,G.vehicleClass,G.noOfseat,T.appliedDate,VehicleClass as Type,ApplicantMobile,
G.AppliedRTO,G.ApplicationStatus,T.applicationId,T.tripId,T.noOfPassangers,G.GreencardAppliedDate,isnull(P.Passenger,0) as Passenger
,T.dhamName,T.TripCardSerial,case when passanger_ListStatus='U' then 'Passengers list Uploaded.' else 'Passenger list not Uploaded' end as status,
--C.dham_eng as dham_name,
T.TripCloseStatus,
T.trip_status,T.tripStartDate,T.tripEndDate,t.passanger_ListStatus,T.greencard_year,
TotalDham,
   (
   select ','+S.DhamEng
   from MasterDham as S
   where ',' + T.TotalDham + ',' like '%,' + cast(S.id as nvarchar(20)) + ',%'
   for xml path(''), type
   ).value('substring(text()[1], 2)', 'varchar(max)') as Dham

 from GreenCardTripDetails T 
left join (SELECT tripId,COUNT(1) AS Passenger FROM (Select distinct [passengerID], [tripId] FROM GreencardPassangerDetail) as Trip group by tripId) P on T.tripId=P.tripId
INNER join GreenCardApprovedData G on T.greencard_no=G.GreencardNo
UNION
select T.greencard_no,G.regn_no,dl_number,G.vehicleRegisteredState,G.vehicleClass,G.noOfseat,T.appliedDate,VehicleClass as Type,applicantMobile,
G.applied_rto_cd,G.application_status_code,T.applicationId,T.tripId,T.noOfPassangers,G.application_dt,isnull(P.Passenger,0) as Passenger
,T.dhamName,T.TripCardSerial,case when passanger_ListStatus='U' then 'Passengers list Uploaded.' else 'Passenger list not Uploaded' end as status,
--C.dham_eng as dham_name,
T.TripCloseStatus,
T.trip_status,T.tripStartDate,T.tripEndDate,t.passanger_ListStatus,T.greencard_year,
TotalDham,
   (
   select ','+S.DhamEng
   from MasterDham as S
   where ',' + T.TotalDham + ',' like '%,' + cast(S.id as nvarchar(20)) + ',%'
   for xml path(''), type
   ).value('substring(text()[1], 2)', 'varchar(max)') as Dham

 from GreenCardTripDetails T 
left join (SELECT tripId,COUNT(1) AS Passenger FROM (Select distinct [passengerID], [tripId] FROM GreencardPassangerDetail) as Trip group by tripId) P on T.tripId=P.tripId
INNER join PrivateVehicleRegApplication G on T.greencard_no=G.greencard_no


GO
