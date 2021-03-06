select Cu.CustomerName Name
      ,EL.LocationName Destination
      ,SL.LocationName as CurrentLocation  
	,((SL.GPSLat - EL.GPSLat) * (SL.GPSLat - EL.GPSLat))
		+ ((SL.GPSLon - EL.GPSLon) * (SL.GPSLon - EL.GPSLon))			as DistanceSquared
      ,((SL.GPSLat - EL.GPSLat) * (SL.GPSLat - EL.GPSLat)
		+ (SL.GPSLon - EL.GPSLon) * (SL.GPSLon - EL.GPSLon))
		 * Co.AmountInCents * Co.AmountInCents /10000 as 				PriceSquared    
      ,T.Active as JobActive
	,IFNULL(T.DriverId,0) as DriverAssigned
  FROM Trips as T
  inner join Cost as Co
  on Co.CostId = T.CostType
  inner join Customers as Cu
  on Cu.CustomerId = T.CustomerId
  inner join Locations as SL
  on SL.LocationId = T.StartLocationId
  inner join Locations as EL
  on EL.LocationId = T.EndLocationId
  where T.Active = 1;
