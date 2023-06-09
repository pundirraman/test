USE [GreencardLive]
GO
/****** Object:  View [dbo].[PrivateVehicleDetail]    Script Date: 12-04-2023 12:50:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- select * from PrivateVehicleDetail
CREATE VIEW [dbo].[PrivateVehicleDetail]
AS
Select  applicationId,greencard_no,Convert(varchar(10),CONVERT(date,requested_greencard_from_dt,106),103) as appliedDate,regn_no,vehicleRegisteredState,vehicleRegDate,chassis_no,engine_no,
registaringAuthorityName,vehicleClass,vehicleModel,vehicleColor,validityOfInsurance,validityOfFitnessCeritificate,validityOfPollutionCertificate,owner_name,owner_address,noOfseat,
application_dt,requested_greencard_from_dt,applied_rto_cd,application_status_code,applicantMobile,
vahanDataFrom,greencard_year from PrivateVehicleRegApplication

GO
