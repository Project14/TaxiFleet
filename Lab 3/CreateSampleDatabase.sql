USE [master]
GO
/****** Object:  Database [TaxiFleet]    Script Date: 2016/04/07 5:21:52 PM ******/
CREATE DATABASE [TaxiFleet]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TaxiFleet', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\TaxiFleet.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TaxiFleet_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\TaxiFleet_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [TaxiFleet] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TaxiFleet].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TaxiFleet] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TaxiFleet] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TaxiFleet] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TaxiFleet] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TaxiFleet] SET ARITHABORT OFF 
GO
ALTER DATABASE [TaxiFleet] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TaxiFleet] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TaxiFleet] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TaxiFleet] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TaxiFleet] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TaxiFleet] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TaxiFleet] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TaxiFleet] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TaxiFleet] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TaxiFleet] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TaxiFleet] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TaxiFleet] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TaxiFleet] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TaxiFleet] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TaxiFleet] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TaxiFleet] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TaxiFleet] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TaxiFleet] SET RECOVERY FULL 
GO
ALTER DATABASE [TaxiFleet] SET  MULTI_USER 
GO
ALTER DATABASE [TaxiFleet] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TaxiFleet] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TaxiFleet] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TaxiFleet] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [TaxiFleet] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'TaxiFleet', N'ON'
GO
USE [TaxiFleet]
GO
/****** Object:  Table [dbo].[Cost]    Script Date: 2016/04/07 5:21:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cost](
	[CostId] [int] NOT NULL,
	[Type] [nvarchar](max) NOT NULL,
	[AmountInCents] [int] NOT NULL,
 CONSTRAINT [PK_Cost] PRIMARY KEY CLUSTERED 
(
	[CostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customers]    Script Date: 2016/04/07 5:21:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [nvarchar](max) NOT NULL,
	[PhoneNumber] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Drivers]    Script Date: 2016/04/07 5:21:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Drivers](
	[DriverId] [int] NOT NULL,
	[DriverName] [nvarchar](max) NOT NULL,
	[CurrentlyAssigned] [bit] NOT NULL,
	[CurrentLocationId] [int] NULL,
	[CurrentlyActive] [bit] NOT NULL,
 CONSTRAINT [PK_Drivers] PRIMARY KEY CLUSTERED 
(
	[DriverId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Locations]    Script Date: 2016/04/07 5:21:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Locations](
	[LocationId] [int] NOT NULL,
	[LocationName] [nvarchar](max) NOT NULL,
	[GPSLat] [int] NOT NULL,
	[GPSLon] [int] NOT NULL,
 CONSTRAINT [PK_Locations] PRIMARY KEY CLUSTERED 
(
	[LocationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Trips]    Script Date: 2016/04/07 5:21:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trips](
	[TripId] [int] NOT NULL,
	[CustomerId] [int] NOT NULL,
	[StartLocationId] [int] NOT NULL,
	[EndLocationId] [int] NOT NULL,
	[DriverId] [int] NULL,
	[CostType] [int] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Trips] PRIMARY KEY CLUSTERED 
(
	[TripId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
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
