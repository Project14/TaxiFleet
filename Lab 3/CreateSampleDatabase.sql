ATTACH DATABASE 'taxiFleet.db' as 'TEMP';
CREATE DATABASE TaxiFleet
CREATE TABLE Cost(
	CostId int NOT NULL,
	Type nvarchar(max) NOT NULL,
	AmountInCents int NOT NULL,
 CONSTRAINT [PK_Cost] PRIMARY KEY CLUSTERED 
(
	[CostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


CREATE TABLE Customers(
	CustomerId int IDENTITY(1,1) NOT NULL,
	CustomerName TEXT NOT NULL,
	PhoneNumber TEXT NOT NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	CustomerId ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE TABLE Drivers(
	DriverId int NOT NULL,
	DriverName TEXT NOT NULL,
	CurrentlyAssigned bit NOT NULL,
	CurrentLocationId int NULL,
	CurrentlyActive bit NOT NULL,
 CONSTRAINT [PK_Drivers] PRIMARY KEY CLUSTERED 
(
	[DriverId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]



CREATE TABLE Locations(
	[LocationId] [int] NOT NULL,
	[LocationName] [nvarchar](max) NOT NULL,
	[GPSLat] [int] NOT NULL,
	[GPSLon] [int] NOT NULL,
 CONSTRAINT [PK_Locations] PRIMARY KEY CLUSTERED 
(
	[LocationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


CREATE TABLE Trips(
	TripId int NOT NULL,
	CustomerId int NOT NULL,
	StartLocationId int NOT NULL,
	EndLocationId int NOT NULL,
	DriverId int NULL,
	CostType int NOT NULL,
	Active bit NOT NULL,
 CONSTRAINT [PK_Trips] PRIMARY KEY CLUSTERED 
(
	[TripId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


INSERT [dbo].[Cost] ([CostId], [Type], [AmountInCents]) VALUES (1, N'Standard', 550)
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([CustomerId], [CustomerName], [PhoneNumber]) VALUES (1, N'Aragorn', N'08479101934')
INSERT [dbo].[Customers] ([CustomerId], [CustomerName], [PhoneNumber]) VALUES (2, N'Frodo', N'07967387834')
INSERT [dbo].[Customers] ([CustomerId], [CustomerName], [PhoneNumber]) VALUES (3, N'Gimli', N'07589431769')
SET IDENTITY_INSERT [dbo].[Customers] OFF
INSERT [dbo].[Drivers] ([DriverId], [DriverName], [CurrentlyAssigned], [CurrentLocationId], [CurrentlyActive]) VALUES (1, N'Bob', 0, 4, 1)
INSERT [dbo].[Locations] ([LocationId], [LocationName], [GPSLat], [GPSLon]) VALUES (1, N'The Prancing Pony', 1, 1)
INSERT [dbo].[Locations] ([LocationId], [LocationName], [GPSLat], [GPSLon]) VALUES (2, N'Rivendell', 1, 43)
INSERT [dbo].[Locations] ([LocationId], [LocationName], [GPSLat], [GPSLon]) VALUES (3, N'Mordor', 10, 10)
INSERT [dbo].[Locations] ([LocationId], [LocationName], [GPSLat], [GPSLon]) VALUES (4, N'Hobbiton', 16, 10)
INSERT [dbo].[Locations] ([LocationId], [LocationName], [GPSLat], [GPSLon]) VALUES (5, N'Helms Deep', 201, 43)
INSERT [dbo].[Trips] ([TripId], [CustomerId], [StartLocationId], [EndLocationId], [DriverId], [CostType], [Active]) VALUES (1, 1, 2, 1, NULL, 1, 1)
INSERT [dbo].[Trips] ([TripId], [CustomerId], [StartLocationId], [EndLocationId], [DriverId], [CostType], [Active]) VALUES (2, 2, 4, 3, NULL, 1, 1)
INSERT [dbo].[Trips] ([TripId], [CustomerId], [StartLocationId], [EndLocationId], [DriverId], [CostType], [Active]) VALUES (3, 3, 2, 5, NULL, 1, 1)
ALTER TABLE [dbo].[Drivers]  WITH CHECK ADD  CONSTRAINT [FK_Drivers_Locations] FOREIGN KEY([CurrentLocationId])
REFERENCES [dbo].[Locations] ([LocationId])
GO
ALTER TABLE [dbo].[Drivers] CHECK CONSTRAINT [FK_Drivers_Locations]
GO
ALTER TABLE [dbo].[Trips]  WITH CHECK ADD  CONSTRAINT [FK_Trips_Cost] FOREIGN KEY([CostType])
REFERENCES [dbo].[Cost] ([CostId])
GO
ALTER TABLE [dbo].[Trips] CHECK CONSTRAINT [FK_Trips_Cost]
GO
ALTER TABLE [dbo].[Trips]  WITH CHECK ADD  CONSTRAINT [FK_Trips_Customers] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([CustomerId])
GO
ALTER TABLE [dbo].[Trips] CHECK CONSTRAINT [FK_Trips_Customers]
GO
ALTER TABLE [dbo].[Trips]  WITH CHECK ADD  CONSTRAINT [FK_Trips_Drivers] FOREIGN KEY([DriverId])
REFERENCES [dbo].[Drivers] ([DriverId])
GO
ALTER TABLE [dbo].[Trips] CHECK CONSTRAINT [FK_Trips_Drivers]
GO
ALTER TABLE [dbo].[Trips]  WITH CHECK ADD  CONSTRAINT [FK_Trips_Locations] FOREIGN KEY([StartLocationId])
REFERENCES [dbo].[Locations] ([LocationId])
GO
ALTER TABLE [dbo].[Trips] CHECK CONSTRAINT [FK_Trips_Locations]
GO
ALTER TABLE [dbo].[Trips]  WITH CHECK ADD  CONSTRAINT [FK_Trips_Locations1] FOREIGN KEY([EndLocationId])
REFERENCES [dbo].[Locations] ([LocationId])
GO
ALTER TABLE [dbo].[Trips] CHECK CONSTRAINT [FK_Trips_Locations1]
GO
USE [master]
GO
ALTER DATABASE [TaxiFleet] SET  READ_WRITE 
GO
