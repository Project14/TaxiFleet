--
-- File generated with SQLiteStudio v3.0.7 on Thu Apr 7 21:24:29 2016
--
-- Text encoding used: windows-1252
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: Trips
CREATE TABLE [Trips] (
	[TripId]	integer NOT NULL,
	[CustomerId]	integer NOT NULL,
	[StartLocationId]	integer NOT NULL,
	[EndLocationId]	integer NOT NULL,
	[DriverId]	integer,
	[CostType]	integer NOT NULL,
	[Active]	bit NOT NULL,
    PRIMARY KEY ([TripId])
,
    FOREIGN KEY ([CustomerId])
        REFERENCES [Customers]([CustomerId]),
    FOREIGN KEY ([StartLocationId])
        REFERENCES [Locations]([LocationId]),
    FOREIGN KEY ([EndLocationId])
        REFERENCES [Locations]([LocationId]),
    FOREIGN KEY ([DriverId])
        REFERENCES [Drivers]([DriverId]),
    FOREIGN KEY ([CostType])
        REFERENCES [Cost]([CostId])
);
INSERT INTO Trips (TripId, CustomerId, StartLocationId, EndLocationId, DriverId, CostType, Active) VALUES (1, 1, 2, 1, NULL, 1, 1);
INSERT INTO Trips (TripId, CustomerId, StartLocationId, EndLocationId, DriverId, CostType, Active) VALUES (2, 2, 4, 3, NULL, 1, 1);
INSERT INTO Trips (TripId, CustomerId, StartLocationId, EndLocationId, DriverId, CostType, Active) VALUES (3, 3, 2, 5, NULL, 1, 1);

-- Table: Cost
CREATE TABLE [Cost] (
	[CostId]	integer NOT NULL,
	[Type]	nvarchar NOT NULL COLLATE NOCASE,
	[AmountInCents]	integer NOT NULL,
    PRIMARY KEY ([CostId])

);
INSERT INTO Cost (CostId, Type, AmountInCents) VALUES (1, 'Standard', 550);

-- Table: Locations
CREATE TABLE [Locations] (
	[LocationId]	integer NOT NULL,
	[LocationName]	nvarchar NOT NULL COLLATE NOCASE,
	[GPSLat]	integer NOT NULL,
	[GPSLon]	integer NOT NULL,
    PRIMARY KEY ([LocationId])

);
INSERT INTO Locations (LocationId, LocationName, GPSLat, GPSLon) VALUES (1, 'The Prancing Pony', 1, 1);
INSERT INTO Locations (LocationId, LocationName, GPSLat, GPSLon) VALUES (2, 'Rivendell', 1, 43);
INSERT INTO Locations (LocationId, LocationName, GPSLat, GPSLon) VALUES (3, 'Mordor', 10, 10);
INSERT INTO Locations (LocationId, LocationName, GPSLat, GPSLon) VALUES (4, 'Hobbiton', 16, 10);
INSERT INTO Locations (LocationId, LocationName, GPSLat, GPSLon) VALUES (5, 'Helms Deep', 201, 43);

-- Table: Drivers
CREATE TABLE [Drivers] (
	[DriverId]	integer NOT NULL,
	[DriverName]	nvarchar NOT NULL COLLATE NOCASE,
	[CurrentlyAssigned]	bit NOT NULL,
	[CurrentLocationId]	integer,
	[CurrentlyActive]	bit NOT NULL,
    PRIMARY KEY ([DriverId])
,
    FOREIGN KEY ([CurrentLocationId])
        REFERENCES [Locations]([LocationId])
);
INSERT INTO Drivers (DriverId, DriverName, CurrentlyAssigned, CurrentLocationId, CurrentlyActive) VALUES (1, 'Bob', 0, 4, 1);

-- Table: Customers
CREATE TABLE [Customers] (
	[CustomerId]	integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	[CustomerName]	nvarchar NOT NULL COLLATE NOCASE,
	[PhoneNumber]	nvarchar NOT NULL COLLATE NOCASE

);
INSERT INTO Customers (CustomerId, CustomerName, PhoneNumber) VALUES (1, 'Aragorn', '08479101934');
INSERT INTO Customers (CustomerId, CustomerName, PhoneNumber) VALUES (2, 'Frodo', '07967387834');
INSERT INTO Customers (CustomerId, CustomerName, PhoneNumber) VALUES (3, 'Gimli', '07589431769');

-- Trigger: fkd_Drivers_CurrentLocationId_Locations_LocationId
CREATE TRIGGER [fkd_Drivers_CurrentLocationId_Locations_LocationId] Before Delete ON [Locations] BEGIN SELECT RAISE(ROLLBACK, 'delete on table Locations violates foreign key constraint fkd_Drivers_CurrentLocationId_Locations_LocationId') WHERE (SELECT CurrentLocationId FROM Drivers WHERE CurrentLocationId = OLD.LocationId) IS NOT NULL;  END;

-- Trigger: fku_Trips_EndLocationId_Locations_LocationId
CREATE TRIGGER [fku_Trips_EndLocationId_Locations_LocationId] Before Update ON [Trips] BEGIN SELECT RAISE(ROLLBACK, 'update on table Trips violates foreign key constraint fku_Trips_EndLocationId_Locations_LocationId') WHERE (SELECT LocationId FROM Locations WHERE LocationId = NEW.EndLocationId) IS NULL;  END;

-- Trigger: fki_Trips_DriverId_Drivers_DriverId
CREATE TRIGGER [fki_Trips_DriverId_Drivers_DriverId] Before Insert ON [Trips] BEGIN SELECT RAISE(ROLLBACK, 'insert on table Trips violates foreign key constraint fki_Trips_DriverId_Drivers_DriverId') WHERE NEW.DriverId IS NOT NULL AND (SELECT DriverId FROM Drivers WHERE DriverId = NEW.DriverId) IS NULL;  END;

-- Trigger: fki_Trips_StartLocationId_Locations_LocationId
CREATE TRIGGER [fki_Trips_StartLocationId_Locations_LocationId] Before Insert ON [Trips] BEGIN SELECT RAISE(ROLLBACK, 'insert on table Trips violates foreign key constraint fki_Trips_StartLocationId_Locations_LocationId') WHERE (SELECT LocationId FROM Locations WHERE LocationId = NEW.StartLocationId) IS NULL;  END;

-- Trigger: fku_Trips_DriverId_Drivers_DriverId
CREATE TRIGGER [fku_Trips_DriverId_Drivers_DriverId] Before Update ON [Trips] BEGIN SELECT RAISE(ROLLBACK, 'update on table Trips violates foreign key constraint fku_Trips_DriverId_Drivers_DriverId') WHERE NEW.DriverId IS NOT NULL AND (SELECT DriverId FROM Drivers WHERE DriverId = NEW.DriverId) IS NULL;  END;

-- Trigger: fki_Drivers_CurrentLocationId_Locations_LocationId
CREATE TRIGGER [fki_Drivers_CurrentLocationId_Locations_LocationId] Before Insert ON [Drivers] BEGIN SELECT RAISE(ROLLBACK, 'insert on table Drivers violates foreign key constraint fki_Drivers_CurrentLocationId_Locations_LocationId') WHERE NEW.CurrentLocationId IS NOT NULL AND (SELECT LocationId FROM Locations WHERE LocationId = NEW.CurrentLocationId) IS NULL;  END;

-- Trigger: fki_Trips_CustomerId_Customers_CustomerId
CREATE TRIGGER [fki_Trips_CustomerId_Customers_CustomerId] Before Insert ON [Trips] BEGIN SELECT RAISE(ROLLBACK, 'insert on table Trips violates foreign key constraint fki_Trips_CustomerId_Customers_CustomerId') WHERE (SELECT CustomerId FROM Customers WHERE CustomerId = NEW.CustomerId) IS NULL;  END;

-- Trigger: fkd_Trips_CostType_Cost_CostId
CREATE TRIGGER [fkd_Trips_CostType_Cost_CostId] Before Delete ON [Cost] BEGIN SELECT RAISE(ROLLBACK, 'delete on table Cost violates foreign key constraint fkd_Trips_CostType_Cost_CostId') WHERE (SELECT CostType FROM Trips WHERE CostType = OLD.CostId) IS NOT NULL;  END;

-- Trigger: fku_Trips_CustomerId_Customers_CustomerId
CREATE TRIGGER [fku_Trips_CustomerId_Customers_CustomerId] Before Update ON [Trips] BEGIN SELECT RAISE(ROLLBACK, 'update on table Trips violates foreign key constraint fku_Trips_CustomerId_Customers_CustomerId') WHERE (SELECT CustomerId FROM Customers WHERE CustomerId = NEW.CustomerId) IS NULL;  END;

-- Trigger: fkd_Trips_CustomerId_Customers_CustomerId
CREATE TRIGGER [fkd_Trips_CustomerId_Customers_CustomerId] Before Delete ON [Customers] BEGIN SELECT RAISE(ROLLBACK, 'delete on table Customers violates foreign key constraint fkd_Trips_CustomerId_Customers_CustomerId') WHERE (SELECT CustomerId FROM Trips WHERE CustomerId = OLD.CustomerId) IS NOT NULL;  END;

-- Trigger: fki_Trips_EndLocationId_Locations_LocationId
CREATE TRIGGER [fki_Trips_EndLocationId_Locations_LocationId] Before Insert ON [Trips] BEGIN SELECT RAISE(ROLLBACK, 'insert on table Trips violates foreign key constraint fki_Trips_EndLocationId_Locations_LocationId') WHERE (SELECT LocationId FROM Locations WHERE LocationId = NEW.EndLocationId) IS NULL;  END;

-- Trigger: fku_Trips_CostType_Cost_CostId
CREATE TRIGGER [fku_Trips_CostType_Cost_CostId] Before Update ON [Trips] BEGIN SELECT RAISE(ROLLBACK, 'update on table Trips violates foreign key constraint fku_Trips_CostType_Cost_CostId') WHERE (SELECT CostId FROM Cost WHERE CostId = NEW.CostType) IS NULL;  END;

-- Trigger: fkd_Trips_DriverId_Drivers_DriverId
CREATE TRIGGER [fkd_Trips_DriverId_Drivers_DriverId] Before Delete ON [Drivers] BEGIN SELECT RAISE(ROLLBACK, 'delete on table Drivers violates foreign key constraint fkd_Trips_DriverId_Drivers_DriverId') WHERE (SELECT DriverId FROM Trips WHERE DriverId = OLD.DriverId) IS NOT NULL;  END;

-- Trigger: fkd_Trips_StartLocationId_Locations_LocationId
CREATE TRIGGER [fkd_Trips_StartLocationId_Locations_LocationId] Before Delete ON [Locations] BEGIN SELECT RAISE(ROLLBACK, 'delete on table Locations violates foreign key constraint fkd_Trips_StartLocationId_Locations_LocationId') WHERE (SELECT StartLocationId FROM Trips WHERE StartLocationId = OLD.LocationId) IS NOT NULL;  END;

-- Trigger: fku_Drivers_CurrentLocationId_Locations_LocationId
CREATE TRIGGER [fku_Drivers_CurrentLocationId_Locations_LocationId] Before Update ON [Drivers] BEGIN SELECT RAISE(ROLLBACK, 'update on table Drivers violates foreign key constraint fku_Drivers_CurrentLocationId_Locations_LocationId') WHERE NEW.CurrentLocationId IS NOT NULL AND (SELECT LocationId FROM Locations WHERE LocationId = NEW.CurrentLocationId) IS NULL;  END;

-- Trigger: fku_Trips_StartLocationId_Locations_LocationId
CREATE TRIGGER [fku_Trips_StartLocationId_Locations_LocationId] Before Update ON [Trips] BEGIN SELECT RAISE(ROLLBACK, 'update on table Trips violates foreign key constraint fku_Trips_StartLocationId_Locations_LocationId') WHERE (SELECT LocationId FROM Locations WHERE LocationId = NEW.StartLocationId) IS NULL;  END;

-- Trigger: fkd_Trips_EndLocationId_Locations_LocationId
CREATE TRIGGER [fkd_Trips_EndLocationId_Locations_LocationId] Before Delete ON [Locations] BEGIN SELECT RAISE(ROLLBACK, 'delete on table Locations violates foreign key constraint fkd_Trips_EndLocationId_Locations_LocationId') WHERE (SELECT EndLocationId FROM Trips WHERE EndLocationId = OLD.LocationId) IS NOT NULL;  END;

-- Trigger: fki_Trips_CostType_Cost_CostId
CREATE TRIGGER [fki_Trips_CostType_Cost_CostId] Before Insert ON [Trips] BEGIN SELECT RAISE(ROLLBACK, 'insert on table Trips violates foreign key constraint fki_Trips_CostType_Cost_CostId') WHERE (SELECT CostId FROM Cost WHERE CostId = NEW.CostType) IS NULL;  END;

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
