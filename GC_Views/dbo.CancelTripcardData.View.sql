USE [GreencardLive]
GO
/****** Object:  View [dbo].[CancelTripcardData]    Script Date: 12-04-2023 12:50:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- select * from CancelTripcardData
CREATE VIEW [dbo].[CancelTripcardData]
AS
SELECT TripID,C.GreencardNo,RegNo,ApplicantMobile,TotalPassengers,TripStartDate,TripEndDate,Dhams,TripCancelRemark,EvidenceOrForm,AppliedOffice,CancelStatus,CancelDate,C.greencard_year
 FROM TripCancelRequestData C INNER JOIN GreenCardApprovedData G ON C.GreencardNo=G.GreencardNo
 UNION
 SELECT TripID,C.GreencardNo,regn_no,applicantMobile,TotalPassengers,TripStartDate,TripEndDate,Dhams,TripCancelRemark,EvidenceOrForm,AppliedOffice,CancelStatus,CancelDate,C.greencard_year
 FROM TripCancelRequestData C INNER JOIN PrivateVehicleRegApplication G ON C.GreencardNo=G.greencard_no


GO
