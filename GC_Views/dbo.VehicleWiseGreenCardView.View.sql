USE [GreencardLive]
GO
/****** Object:  View [dbo].[VehicleWiseGreenCardView]    Script Date: 12-04-2023 12:50:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Select * from VehicleWiseGreenCardView

CREATE VIEW [dbo].[VehicleWiseGreenCardView]
AS
SELECT UK.Type,UKGC,OSGC FROM(select 'Bus' as Type,ISNULL(sum(greencard_no),0) as UKGC from 
(select cast(ApprovingDatetime as date) as appliedDate,vehicleClass,ISNULL(count(GreencardNo),0) as greencard_no FROM GreenCardData 
where greencard_year=year(GETDATE()) and noOfseat > 25 and vehicleRegisteredState like '%Uttarakhand%'  group by vehicleClass,ApprovingDatetime) as bus ) as UK
INNER JOIN
(select 'Bus' as Type,ISNULL(sum(greencard_no),0) as OSGC from (select cast(ApprovingDatetime as date) as appliedDate,vehicleClass,ISNULL(count(GreencardNo),0) as greencard_no FROM GreenCardData 
where greencard_year=year(GETDATE()) and noOfseat > 25 and vehicleRegisteredState not like '%Uttarakhand%'  group by vehicleClass,ApprovingDatetime) as bus ) as OS ON UK.Type=OS.Type
UNION ALL
SELECT UK.Type,UKGC,OSGC FROM(select 'Mini Bus' as Type,ISNULL(sum(greencard_no),0) as UKGC from (select cast(ApprovingDatetime as date) as appliedDate,vehicleClass,ISNULL(count(GreencardNo),0) as greencard_no FROM GreenCardData 
where greencard_year=year(GETDATE()) and noOfseat between 14 and 25 and vehicleRegisteredState like '%Uttarakhand%'  group by vehicleClass,ApprovingDatetime) as mini ) as UK
INNER JOIN
(select 'Mini Bus' as Type,ISNULL(sum(greencard_no),0) as OSGC from (select cast(ApprovingDatetime as date) as appliedDate,vehicleClass,ISNULL(count(GreencardNo),0) as greencard_no FROM GreenCardData 
where greencard_year=year(GETDATE()) and noOfseat between 14 and 25 and vehicleRegisteredState not like '%Uttarakhand%'  group by vehicleClass,ApprovingDatetime) as mini ) as OS ON UK.Type=OS.Type
UNION ALL
SELECT UK.Type,UKGC,OSGC FROM(select 'Taxi' as Type,ISNULL(sum(greencard_no),0) as UKGC from (select cast(ApprovingDatetime as date) as appliedDate,vehicleClass,ISNULL(count(GreencardNo),0) as greencard_no FROM GreenCardData 
where greencard_year=year(GETDATE()) and noOfseat<=7 and vehicleRegisteredState like '%Uttarakhand%'  group by vehicleClass,ApprovingDatetime) as taxi ) as UK
INNER JOIN
(select 'Taxi' as Type,ISNULL(sum(greencard_no),0) as OSGC from (select cast(ApprovingDatetime as date) as appliedDate,vehicleClass,ISNULL(count(GreencardNo),0) as greencard_no FROM GreenCardData 
where greencard_year=year(GETDATE()) and noOfseat<=7 and vehicleRegisteredState not like '%Uttarakhand%'  group by vehicleClass,ApprovingDatetime) as taxi ) as OS ON UK.Type=OS.Type
UNION ALL
SELECT UK.Type,UKGC,OSGC FROM(select 'Maxi' as Type,ISNULL(sum(greencard_no),0) as UKGC from (select cast(ApprovingDatetime as date) as appliedDate,vehicleClass,ISNULL(count(GreencardNo),0) as greencard_no FROM GreenCardData 
where greencard_year=year(GETDATE()) and noOfseat between 8 and 13 and vehicleRegisteredState like '%Uttarakhand%'  group by vehicleClass,ApprovingDatetime) as Maxi ) as UK
INNER JOIN
(select 'Maxi' as Type,ISNULL(sum(greencard_no),0) as OSGC from (select cast(ApprovingDatetime as date) as appliedDate,vehicleClass,ISNULL(count(GreencardNo),0) as greencard_no FROM GreenCardData 
where greencard_year=year(GETDATE()) and noOfseat between 8 and 13 and vehicleRegisteredState not like '%Uttarakhand%'  group by vehicleClass,ApprovingDatetime) as Maxi ) as OS ON UK.Type=OS.Type

GO
