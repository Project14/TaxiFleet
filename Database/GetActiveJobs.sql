/****** Script for SelectTopNRows command from SSMS  ******/
SELECT Cu.CustomerName as Name
      ,EL.LocationName as Destination
      ,SL.LocationName as CurrentLocation
      ,SQRT(POWER(SL.GPSLat - EL.GPSLat,2)
		+ POWER(SL.GPSLon - EL.GPSLon,2)) as Distance
      ,(SQRT(POWER(SL.GPSLat - EL.GPSLat,2)
		+ POWER(SL.GPSLon - EL.GPSLon,2))
		 * Co.AmountInCents) /100 as Price
      ,T.Active as JobActive
	  ,ISNULL(T.DriverId,0) as DriverAssigned
  FROM Trips as T
  inner join Cost as Co
  on Co.CostId = T.CostType
  inner join Customers as Cu
  on Cu.CustomerId = T.CustomerId
  inner join Locations as SL
  on SL.LocationId = T.StartLocationId
  inner join Locations as EL
  on EL.LocationId = T.EndLocationId
  where T.Active = 1
