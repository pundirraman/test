USE [GreencardLive]
GO
/****** Object:  View [dbo].[GreenCardTripDetail]    Script Date: 12-04-2023 12:50:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- Select * from GreenCardTripDetail

CREATE VIEW [dbo].[GreenCardTripDetail]
AS
SELECT t.greencard_no AS greencard_no,t.applicationId,t.dl_number, t.tripId AS tripId,t.temporary_AuthorizatioPermitNo,t.temporary_AuthorizatioPermitValidity
      ,t.TripStartPlace,t.TripCardSerial,t.tripStartDate,t.tripEndDate,t.uk_statetax_validfrom
      ,t.uk_statetax_validupto, t.applied_rto_cd,t.noOfPassangers,t.trip_status,t.dhamName,t.passanger_ListStatus,t.appliedDate,CAST(Item AS varchar) as TotalDham,greencard_year
      FROM dbo.GreencardTripDetails t OUTER APPLY dbo.SplitString (t.TotalDham, ',') sp WHERE greencard_year=YEAR(GETDATE())

GO
