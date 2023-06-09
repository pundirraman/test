USE [GreencardLive]
GO
/****** Object:  View [dbo].[PvtTripCardDetailView]    Script Date: 12-04-2023 12:50:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- select * from PvtTripCardDetailView 
CREATE VIEW [dbo].[PvtTripCardDetailView]
AS
select T.greencard_no,G.regn_no,dl_number,T.applicationId,T.tripId,G.vehicleRegisteredState,G.vehicleClass,G.noOfseat,T.appliedDate,VehicleClass as Type,G.owner_name,G.owner_address,G.applicantMobile,
G.applied_rto_cd,G.application_status_code,T.noOfPassangers,G.requested_greencard_from_dt,isnull(P.Passenger,0) as Passenger,G.vehicleRegDate,vehicleColor
,T.dhamName,T.TripCardSerial,case when passanger_ListStatus='U' then 'Passengers list Uploaded.' else 'Passenger list not Uploaded' end as status,
--C.dham_eng as dham_name,
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
