--**********************************************************************************************--
-- Title: Project Database A Group 6
-- Author: Erika Sundstrom, Larry Tian, Fran Dukic, Anhad Dhillon
-- Desc: Our complete project database
--***********************************************************************************************--

---------------------
-- Create database --
---------------------

BEGIN TRY
	USE MASTER;
	IF EXISTS(SELECT NAME FROM SysDatabases WHERE NAME = 'Proj_INFO_430_A6')
	 BEGIN 
	  ALTER DATABASE [Proj_INFO_430_A6] SET Single_user WITH ROLLBACK IMMEDIATE;
	  DROP DATABASE Proj_INFO_430_A6;
	 END
	CREATE DATABASE Proj_INFO_430_A6;
END TRY
BEGIN CATCH
	PRINT Error_Number();
END CATCH
GO

-- Use the created database

USE Proj_INFO_430_A6;

-------------------
-- Create Tables --
-------------------
CREATE TABLE SUPPLY_TYPE
	(SupplyTypeID INT
	CONSTRAINT SupplyTypeIDPKIdentity PRIMARY KEY IDENTITY(1,1),
	SupplyTypeName NVARCHAR(50)
	CONSTRAINT SuppyTypeNameNotNull NOT NULL,
	SupplyTypeDesc NVARCHAR(100)
	CONSTRAINT SuppyTypeDescNull NULL
	);
GO

CREATE TABLE SUPPLY
	(SupplyID INT
	CONSTRAINT SupplyIDPKIdentity PRIMARY KEY IDENTITY(1,1),
	SupplyTypeID INT
	CONSTRAINT SupplyTypeIDFK Foreign Key references Supply_TYPE(SupplyTypeID),
	SupplyName NVARCHAR(50)
	CONSTRAINT SuppyNameNotNull NOT NULL
	);
GO

CREATE TABLE DONOR
	(DonorID INT
	CONSTRAINT DonorIDPKIdentity PRIMARY KEY IDENTITY(1,1),
	DonorFname NVARCHAR(50)
	CONSTRAINT DonorFNameNotNull NOT NULL,
	DonorLname NVARCHAR(50)
	CONSTRAINT DonorLNameNotNull NOT NULL,
	DonorDOB DATE
	CONSTRAINT DonorDOBNotNull NOT NULL
	);
GO

CREATE TABLE REGION
	(RegionID INT
	CONSTRAINT RegionIDPKIdentity PRIMARY KEY IDENTITY(1,1),
	RegionName NVARCHAR(50)
	CONSTRAINT RegionNameNotNull NOT NULL,
	RegionDesc NVARCHAR(100)
	CONSTRAINT RegionDescNull NULL
	);
GO

CREATE TABLE COUNTRY
	(CountryID INT
	CONSTRAINT CountryIDPKIdentity PRIMARY KEY IDENTITY(1,1),
	RegionID INT
	CONSTRAINT RegionIDFK Foreign Key references REGION(RegionID),
	CountryName NVARCHAR(50)
	CONSTRAINT CountryNameNotNull NOT NULL,
	CountryDesc NVARCHAR(100)
	CONSTRAINT CountryDescNull NULL
	);
GO

CREATE TABLE CITY
	(CityID INT
	CONSTRAINT CityIDPKIdentity PRIMARY KEY IDENTITY(1,1),
	CountryID INT
	CONSTRAINT CountryIDFK Foreign Key references COUNTRY(CountryID),
	CityName NVARCHAR(50)
	CONSTRAINT CityNameNotNull NOT NULL
	);
GO

CREATE TABLE ORG_TYPE
	(OrgTypeID INT
	CONSTRAINT OrgTypeIDPKIdentity PRIMARY KEY IDENTITY(1,1),
	OrgTypeName NVARCHAR(50)
	CONSTRAINT OrgTypeNameNotNull NOT NULL,
	OrgTypeDesc NVARCHAR(100)
	CONSTRAINT OrgTypeDescNull NULL
	);
GO

CREATE TABLE ORGANIZATION
	(OrgID INT
	CONSTRAINT OrgIDPKIdentity PRIMARY KEY IDENTITY(1,1),
	CityID INT
	CONSTRAINT CityIDFK Foreign Key references CITY(CityID),
	OrgTypeID INT
	CONSTRAINT OrgTypeIDFK Foreign Key references ORG_TYPE(OrgTypeID),
	OrgName NVARCHAR(50)
	CONSTRAINT OrgNameNotNull NOT NULL
	);
GO

CREATE TABLE VOLUNTEER
	(VolunteerID INT
	CONSTRAINT VolunteerIDPKIdentity PRIMARY KEY IDENTITY(1,1),
	OrgID INT
	CONSTRAINT OrgIDFK Foreign Key references ORGANIZATION(OrgID),
	VolunteerFname NVARCHAR(50)
	CONSTRAINT VolunteerFNameNotNull NOT NULL,
	VolunteerLname NVARCHAR(50)
	CONSTRAINT VolunteerLNameNotNull NOT NULL,
	VolunteerDOB DATE
	CONSTRAINT VolunteerDOBNotNull NOT NULL
	);
GO

CREATE TABLE EVENT_TYPE
	(EventTypeID INT
	CONSTRAINT EventTypeIDPKIdentity PRIMARY KEY IDENTITY(1,1),
	EventTypeName NVARCHAR(50)
	CONSTRAINT EventTypeNameNotNull NOT NULL,
	EventTypeDesc NVARCHAR(100)
	CONSTRAINT EventTypeDescNull NULL
	);
GO

CREATE TABLE LOCATION_TYPE
	(LocationTypeID INT
	CONSTRAINT LocationTypeIDPKIdentity PRIMARY KEY IDENTITY(1,1),
	LocationTypeName NVARCHAR(50)
	CONSTRAINT LocationTypeNameNotNull NOT NULL,
	LocationTypeDesc NVARCHAR(100)
	CONSTRAINT LocationTypeDescNull NULL
	);
GO

CREATE TABLE [LOCATION]
	(LocationID INT
	CONSTRAINT LocationIDPKIdentity PRIMARY KEY IDENTITY(1,1),
	LocationTypeID INT
	CONSTRAINT LocationTypeIDFK Foreign Key references LOCATION_TYPE(LocationTypeID),
	LocationName NVARCHAR(50)
	CONSTRAINT LocationNameNotNull NOT NULL,
	LocationDesc NVARCHAR(100)
	CONSTRAINT LocationDescNull NULL
	);
GO

CREATE TABLE [EVENT]
	(EventID INT
	CONSTRAINT EventIDPKIdentity PRIMARY KEY IDENTITY(1,1),
	EventTypeID INT
	CONSTRAINT EventTypeIDFK Foreign Key references EVENT_TYPE(EventTypeID),
	LocationID INT
	CONSTRAINT LocationIDFK Foreign Key references [LOCATION](LocationID),
	EventName NVARCHAR(100)
	CONSTRAINT EventNameNotNull NOT NULL,
	EventDate NVARCHAR(100)
	CONSTRAINT EventDateNotNull NOT NULL
	);
GO

CREATE TABLE [ROLE]
	(RoleID INT
	CONSTRAINT RoleIDPKIdentity PRIMARY KEY IDENTITY(1,1),
	RoleName NVARCHAR(50)
	CONSTRAINT RoleNameNotNull NOT NULL,
	RoleDesc NVARCHAR(100)
	CONSTRAINT RoleDescNull NULL
	);
GO

CREATE TABLE HOME
	(HomeID INT
	CONSTRAINT HomeIDPKIdentity PRIMARY KEY IDENTITY(1,1),
	CityID INT
	CONSTRAINT HomeCityIDFK Foreign Key references CITY(CityID),
	HomeName NVARCHAR(50)
	CONSTRAINT HomeNameNotNull NOT NULL,
	HomeDesc NVARCHAR(100)
	CONSTRAINT HomeDescNull NULL
	);
GO

CREATE TABLE WTO_STATUS
	(WTOStatusID INT
	CONSTRAINT WTOStatusIDPKIdentity PRIMARY KEY IDENTITY(1,1),
	WTOStatusName NVARCHAR(50)
	CONSTRAINT WTOStatusNameNotNull NOT NULL,
	WTOStatusDesc NVARCHAR(100)
	CONSTRAINT WTOStatusDescNull NULL
	);
GO

CREATE TABLE COUNTRY_STATUS
	(CountryStatusID INT
	CONSTRAINT CountryStatusIDPKIdentity PRIMARY KEY IDENTITY(1,1),
	CountryID INT
	CONSTRAINT CountryStatusCountryIDFK Foreign Key references COUNTRY(CountryID),
	WTOStatusID INT
	CONSTRAINT WTOStatusIDFK Foreign Key references WTO_STATUS(WTOStatusID),
	Total AS WTOStatusID + CountryID + CountryStatusID
	);
GO

CREATE TABLE CLIENT
	(ClientID INT
	CONSTRAINT ClientIDPKIdentity PRIMARY KEY IDENTITY(1,1),
	HomeID INT 
	CONSTRAINT HomeIDFK Foreign Key references HOME(HomeID),
	ClientFname NVARCHAR(50)
	CONSTRAINT ClientFnameNotNull NOT NULL,
	ClientLname NVARCHAR(50)
	CONSTRAINT ClientFNameNotNull NOT NULL,
	ClientDOB DATE
	CONSTRAINT ClientDOBNotNull NOT NULL,
	ClientDisplaceDate DATE
	CONSTRAINT ClientDisplaceDateNotNull NOT NULL
	);
GO

CREATE TABLE DETAIL_TYPE
	(DetailTypeID INT
	CONSTRAINT DetailTypeIDPKIdentity PRIMARY KEY IDENTITY(1,1),
	DetailTypeName NVARCHAR(50)
	CONSTRAINT DetailTypeNameNotNull NOT NULL,
	DetailTypeDesc NVARCHAR(100)
	CONSTRAINT DetailTypeDescNull NULL
	);
GO

CREATE TABLE DETAIL
	(DetailID INT
	CONSTRAINT DetailIDPKIdentity PRIMARY KEY IDENTITY(1,1),
	DetailTypeID INT
	CONSTRAINT DetailTypeIDFK Foreign Key references DETAIL_TYPE(DetailTypeID),
	DetailName NVARCHAR(50)
	CONSTRAINT DetailNameNotNull NOT NULL,
	DetailDesc NVARCHAR(100)
	CONSTRAINT DetailDescNull NULL
	);
GO


CREATE TABLE CLIENT_DETAIL
	(ClientDetailID INT
	CONSTRAINT ClientDetailIDPKIdentity PRIMARY KEY IDENTITY(1,1),
	ClientID INT
	CONSTRAINT ClientIDFK Foreign Key references CLIENT(ClientID),
	DetailID INT
	CONSTRAINT DetailIDFK Foreign Key references DETAIL(DetailID),
	);
GO

CREATE TABLE SEVERITY
	(SeverityID INT
	CONSTRAINT SeverityIDPKIdentity PRIMARY KEY IDENTITY(1,1),
	SeverityName NVARCHAR(50)
	CONSTRAINT SeverityNameNotNull NOT NULL,
	SeverityDesc NVARCHAR(100)
	CONSTRAINT SeverityDescNull NULL
	);
GO

CREATE TABLE CHALLENGE_TYPE
	(ChallengeTypeID INT
	CONSTRAINT ChallengeTypeIDPKIdentity PRIMARY KEY IDENTITY(1,1),
	ChallengeTypeName NVARCHAR(50)
	CONSTRAINT ChallengeTypeNameNotNull NOT NULL,
	ChallengeTypeDesc NVARCHAR(100)
	CONSTRAINT ChallengeTypeDescNull NULL
	);
GO

CREATE TABLE CHALLENGE
	(ChallengeID INT
	CONSTRAINT ChallengeIDPKIdentity PRIMARY KEY IDENTITY(1,1),
	ChallengeTypeID INT
	CONSTRAINT ChallengeTypeIDFK Foreign Key references CHALLENGE_TYPE(ChallengeTypeID),
	ChallengeName NVARCHAR(50)
	CONSTRAINT ChallengeNameNotNull NOT NULL,
	ChallengeDesc NVARCHAR(100)
	CONSTRAINT ChallengeDescNull NULL
	);
GO

CREATE TABLE CLIENT_CHALLENGE_SEVERITY
	(ClientChallengeSeverityID INT
	CONSTRAINT CCSIDPKIdentity PRIMARY KEY IDENTITY(1,1),
	ClientID INT
	CONSTRAINT CCSClientIDFK Foreign Key references CLIENT(ClientID),
	ChallengeID INT
	CONSTRAINT CCSChallengeIDFK Foreign Key references CHALLENGE(ChallengeID),
	SeverityID INT
	CONSTRAINT CCSSeverityIDFK Foreign Key references SEVERITY(SeverityID)
	);
GO

CREATE TABLE DEMOGRAPHIC_TYPE
	(DemoTypeID INT
	CONSTRAINT DemoTypeIDPKIdentity PRIMARY KEY IDENTITY(1,1),
	DemoTypeName NVARCHAR(50)
	CONSTRAINT DemoTypeNameNotNull NOT NULL,
	DemoTypeDesc NVARCHAR(100)
	CONSTRAINT DemoTypeDescNull NULL
	);
GO

CREATE TABLE DEMOGRAPHIC
	(DemoID INT
	CONSTRAINT DemoIDPKIdentity PRIMARY KEY IDENTITY(1,1),
	DemoTypeID INT
	CONSTRAINT DemoTypeIDFK Foreign Key references DEMOGRAPHIC_TYPE(DemoTypeID),
	DemoName NVARCHAR(50)
	CONSTRAINT ChallengeNameNotNull NOT NULL,
	DemoDesc NVARCHAR(100)
	CONSTRAINT DemoDescNull NULL
	);
GO

CREATE TABLE CLIENT_DEMOGRAPHIC
	(ClientDemographicID INT
	CONSTRAINT ClientDemographicIDPKIdentity PRIMARY KEY IDENTITY(1,1),
	ClientID INT
	CONSTRAINT ClientDemographicClientIDFK Foreign Key references CLIENT(ClientID),
	DemoID INT
	CONSTRAINT ClientDemographicDemoIDFK Foreign Key references DEMOGRAPHIC(DemoID)
	);
GO

CREATE TABLE DONATION
	(DonationID INT
	CONSTRAINT DonationIDPKIdentity PRIMARY KEY IDENTITY(1,1),
	SupplyID INT
	CONSTRAINT DonationSupplyIDFK Foreign Key references SUPPLY(SupplyID),
	DonorID INT
	CONSTRAINT DonationDonorIDFK Foreign Key references DONOR(DonorID),
	OrgID INT
	CONSTRAINT OrganizationIDFK Foreign Key references ORGANIZATION(OrgID),
	DonationDate DATE
	CONSTRAINT DonationDateNotNull DEFAULT GetDate() NOT NULL,
	Quantity INT
	CONSTRAINT QuantityNotNull NOT NULL,
	DollarAmount NUMERIC(8, 2)
	CONSTRAINT DollarAmountNotNull NOT NULL,
	DonationTaxBreak NUMERIC(8, 2)
	CONSTRAINT DonationTaxBreakNull NULL
	);
GO

CREATE TABLE VOLUNTEER_EVENT_ROLE
	(VolunteerEventRoleID INT
	CONSTRAINT VolunteerEventRoleIDPKIdentity PRIMARY KEY IDENTITY(1,1),
	VolunteerID INT
	CONSTRAINT VolunteerIDFK Foreign Key references VOLUNTEER(VolunteerID),
	EventID INT
	CONSTRAINT EventIDFK Foreign Key references [EVENT](EventID),
	RoleID INT
	CONSTRAINT RoleIDFK Foreign Key references [ROLE](RoleID)
	);
GO

---------------------
-- Populate Look Up Tables --
---------------------
INSERT INTO SUPPLY_TYPE 
(SupplyTypeName, SupplyTypeDesc) 
VALUES
('Food', 'Substances that provide nutritional support for an organism'),
('Drink', 'Liquid intended for human consumption'),
('Clothing', 'Items worn on the body'),
('Household Item', 'Products used within households'),
('Cleaning Supply', 'Products used for cleaning'),
('Other', '')
GO 

INSERT INTO DONOR 
(DonorFname, DonorLname, DonorDOB) 
VALUES
('Riyad', 'Mccormick', '1986-03-28'),
('Penny', 'Jarvis', '1975-02-12'),
('Harriette', 'Spencer', '1992-04-28'),
('Vlad', 'Berger', '1971-08-26'),
('Zakaria', 'Blundell', '1985-10-03')
GO 

INSERT INTO REGION 
(RegionName, RegionDesc) 
Values 
('Europe', 'Northern Hemisphere'),
('Middle East', 'Transcontinental region in Afro-Eurasia'),
('Asia & Pacific', 'Near the Western Pacific Ocean'),
('Africa', 'Between the Atlantic Ocean and the Indian Ocean'),
('North America', 'Northern Hemisphere'),
('South America', ''),
('Australia', ''),
('The Caribbean', 'A tropical area located between North and South America')

INSERT INTO WTO_Status 
(WTOStatusName, WTOStatusDesc)
VALUES 
('Developed Nation', 'Countries that are more industrialized'),
('Developing Nation', 'Countries that are less industrialized')
GO 

INSERT INTO LOCATION_TYPE 
(LocationTypeName, LocationTypeDesc) 
VALUES
('Convention Center', 'Large building that is designed to hold a convention'),
('Art Gallerie', 'Physical art galleries'),
('Restaurant', 'Physical restaurant'),
('Business Center', 'Hotel room that allows guests to work'),
('School', 'Educational institution')
GO 


DECLARE @LT_ID1 INT, @LT_ID2 INT, @LT_ID3 INT, @LT_ID4 INT, @LT_ID5 INT
SET @LT_ID1 = (SELECT LocationTypeID FROM LOCATION_TYPE WHERE LocationTypeName = 'Convention Center')
SET @LT_ID2 = (SELECT LocationTypeID FROM LOCATION_TYPE WHERE LocationTypeName = 'Art Gallerie')
SET @LT_ID3 = (SELECT LocationTypeID FROM LOCATION_TYPE WHERE LocationTypeName = 'Restaurant')
SET @LT_ID4 = (SELECT LocationTypeID FROM LOCATION_TYPE WHERE LocationTypeName = 'Business Center')
SET @LT_ID5 = (SELECT LocationTypeID FROM LOCATION_TYPE WHERE LocationTypeName = 'School')
INSERT INTO LOCATION
(LocationTypeID, LocationName, LocationDesc)
VALUES 
(@LT_ID5, 'East Ridge Elementary', 'An elementary school in Woodinville'),
(@LT_ID2, 'Henry Art Gallery', 'An art gallery in Seattle'),
(@LT_ID4, 'University Business Center', ''),
(@LT_ID5, 'Bothell High School', 'A high school in Bothell'),
(@LT_ID3, 'Italianissimo', 'A higher end Italian restaurant'),
(@LT_ID1, 'Orange County Convention Center', '')
GO

INSERT INTO EVENT_TYPE 
(EventTypeName)
VALUES 
('Party'),
('Conferences'),
('Seminar'),
('Trade Shows'),
('Auction')
GO 

INSERT INTO [ROLE] 
(RoleName, RoleDesc)
VALUES
('Server', 'Provide service to others'),
('Economic Manager', 'Responsible for counting and handling the money'),
('Lead', 'Leading or managing a group'),
('Material Manager', 'Managing event materials'),
('Helper', 'Helping the event')
GO 

INSERT INTO CHALLENGE_TYPE 
(ChallengeTypeName, ChallengeTypeDesc)
VALUES
('Housing', 'Finding affordable housing'),
('Employment', 'Finding employment'),
('Education', 'Disrupted eudcation on schooling'),
('Resources', 'Lack of daily necessities'),
('Discrimination', 'Have a discrimination problem')
GO 

INSERT INTO DEMOGRAPHIC_TYPE 
(DemoTypeName, DemoTypeDesc)
VALUES 
('Gender', ''),
('Age', ''),
('Ethinicity', 'The fact or state of belonging to a social group that has a common national or cultural tradition'),
('Race', ''),
('Level of education', 'The level of education that person completed')
GO 

INSERT INTO SEVERITY 
(SeverityName)
VALUES 
('No effect'),
('Low'),
('Medium'),
('High'),
('Critical')
GO 

INSERT INTO DETAIL_TYPE 
(DetailTypeName)
Values 
('Income'),
('Health'),
('Education'),
('Safety'),
('Immigration')
GO 

INSERT INTO ORG_TYPE 
(OrgTypeName)
Values 
('NonProfit'),
('Religious'),
('Government'),
('School'),
('International')
GO

---------------------
-- Populate People Tables --
---------------------

INSERT INTO DONOR (DonorFname, DonorLname, DonorDOB)
SELECT TOP 100000 CustomerFname, CustomerLname, DateOfBirth
FROM peeps.dbo.tblCUSTOMER

INSERT INTO CLIENT (ClientFname, ClientLname, ClientDOB, ClientDisplaceDate)
SELECT TOP 100000 CustomerFname, CustomerLname, DateOfBirth, DateOfBirth
FROM peeps.dbo.tblCUSTOMER
WHERE CustomerID > 100000

INSERT INTO VOLUNTEER (VolunteerFname, VolunteerLname, VolunteerDOB)
SELECT TOP 100000 CustomerFname, CustomerLname, DateOfBirth
FROM peeps.dbo.tblCUSTOMER
WHERE CustomerID > 200000
GO

-----------------------
-- Stored Procedures --
-----------------------

-- GET IDs

-- Fran
CREATE PROCEDURE GetSupplyTypes
	@TypeName nvarchar(50),
	@ID int Output 
AS 
SET @ID = (
	SELECT SupplyTypeID
	FROM SUPPLY_TYPE
	WHERE SupplyTypeName = @TypeName
);
GO 

CREATE PROCEDURE GetDonor
	@Fname nvarchar(50),
	@Lname nvarchar(50),
	@ID int Output
AS 
SET @ID = (
	SELECT DonorID
	FROM DONOR 
	WHERE DonorFname = @Fname
	AND DonorLname = @Lname 
);
GO

CREATE PROCEDURE GetRegion
	@Name nvarchar(50),
	@ID int Output 
AS 
SET @ID = (
	SELECT RegionID 
	FROM REGION 
	WHERE RegionName = @Name 
);
GO 

CREATE PROCEDURE GetWTOStatus 
	@StatusName nvarchar(50),
	@ID int Output 
AS 
SET @ID = (
	SELECT WTOStatusID 
	FROM WTO_STATUS
	WHERE WTOStatusName = @StatusName
);
GO 

-- Anhad
CREATE PROCEDURE GetLocationType 
	@TypeName nvarchar(50),
	@ID int Output 
AS 
SET @ID = (
	SELECT LocationTypeID 
	FROM LOCATION_TYPE 
	WHERE LocationTypeName = @TypeName
);
GO 

CREATE PROCEDURE GetEventType 
	@TypeName nvarchar(50),
	@ID int Output 
AS 
SET @ID = (
	SELECT EventTypeID
	FROM EVENT_TYPE 
	WHERE EventTypeName = @TypeName
);
GO 

CREATE PROCEDURE GetRole
	@Name nvarchar(50),
	@ID int Output 
AS 
SET @ID = (
	SELECT RoleID
	FROM [ROLE]
	WHERE RoleName = @Name
);
GO 

CREATE PROCEDURE GetChallengeType
	@TypeName nvarchar(50),
	@ID int Output 
AS 
SET @ID = (
	SELECT ChallengeTypeID
	FROM CHALLENGE_TYPE
	WHERE ChallengeTypeName = @TypeName
);
GO 

-- Erika
CREATE PROCEDURE GetDemographicType
	@TypeName nvarchar(50),
	@ID int Output 
AS 
SET @ID = (
	SELECT DemoTypeID
	FROM DEMOGRAPHIC_TYPE
	WHERE DemoTypeName = @TypeName
);
GO 

CREATE PROCEDURE GetSeverity
	@Name nvarchar(50),
	@ID int Output 
AS 
SET @ID = (
	SELECT SeverityID
	FROM SEVERITY
	WHERE SeverityName = @Name
);
GO

CREATE PROCEDURE GetDetailType
	@TypeName nvarchar(50),
	@ID int Output 
AS 
SET @ID = (
	SELECT DetailTypeID
	FROM DETAIL_TYPE
	WHERE DetailTypeName= @TypeName
);
GO 

CREATE PROCEDURE GetCountry
	@Name nvarchar(50),
	@ID int Output 
AS 
SET @ID = (
	SELECT CountryID
	FROM COUNTRY
	WHERE CountryName = @Name
);
GO

CREATE PROCEDURE GetLocation
	@Name nvarchar(50),
	@ID int Output 
AS 
SET @ID = (
	SELECT LocationID 
	FROM [LOCATION]
	WHERE LocationName = @Name
);
GO 

-- Larry
CREATE PROCEDURE GetEvent 
	@Name nvarchar(50),
	@Date date,
	@ID int Output 
AS 
SET @ID = (
	SELECT EventID 
	FROM [EVENT]
	WHERE EventName = @Name 
	AND EventDate = @Date
);
GO 

CREATE PROCEDURE GetCity 
	@Name nvarchar(50),
	@ID int Output
AS  
SET @ID = (
	SELECT TOP 1 CityID 
	FROM CITY 
	WHERE CityName = @Name
);
GO 

CREATE PROCEDURE GetOrganization
	@Name nvarchar(50),
	@ID int Output 
AS 
SET @ID = (
	SELECT TOP 1 OrgID 
	FROM ORGANIZATION
	WHERE OrgName = @Name 
);
GO 

CREATE PROCEDURE GetOrgType
	@TypeName nvarchar(50),
	@ID int Output 
AS 
SET @ID = (
	SELECT OrgTypeID
	FROM ORG_TYPE
	WHERE OrgTypeName= @TypeName
);
GO 

CREATE PROCEDURE GetSupply 
	@Name nvarchar(50),
	@ID int Output 
AS 
SET @ID = (
	SELECT TOP 1 SupplyID 
	FROM SUPPLY 
	WHERE SupplyName = @Name
);
GO 

CREATE PROCEDURE GetVolunteer 
	@Fname nvarchar(50),
	@Lname nvarchar(50),
	@ID int Output 
AS 
SET @ID = (
	SELECT VolunteerID
	FROM VOLUNTEER
	WHERE VolunteerFname = @Fname
	AND VolunteerLname = @Lname
);
GO 

CREATE PROCEDURE GetHome 
	@Name nvarchar(50),
	@ID int Output 
AS 
SET @ID = (
	SELECT HomeID 
	FROM HOME 
	WHERE HomeName = @Name 
);
GO 

CREATE PROCEDURE GetClient 
	@Fname nvarchar(50),
	@Lname nvarchar(50),
	@Date date,
	@ID int Output 
AS 
SET @ID = (
	SELECT ClientID 
	FROM CLIENT 
	WHERE ClientFname = @Fname
	AND ClientLname = @Lname
	AND ClientDOB = @Date
);
GO 

CREATE PROCEDURE GetChallenge 
	@Name nvarchar(50),
	@ID int Output 
AS 
SET @ID = (
	SELECT ChallengeID 
	FROM CHALLENGE
	WHERE ChallengeName = @Name
);
GO

CREATE PROCEDURE GetDemographic 
	@Name nvarchar(50),
	@ID int Output 
AS 
SET @ID = (
	SELECT DemoID
	FROM DEMOGRAPHIC
	WHERE DemoName = @Name
);
GO 

CREATE PROCEDURE GetDetail 
	@Name nvarchar(50),
	@ID int Output 
AS  
SET @ID = (
	SELECT DetailID 
	FROM DETAIL 
	WHERE DetailName = @Name 
);
GO 

-- INSERT PROCEDURES

-- Erika
-- (Supply)
CREATE PROCEDURE InsertSupplyType 
	@SupplyTypeName1 nvarchar(50),
	@SupplyTypeDesc1 nvarchar(50)
AS 
BEGIN 
	
	BEGIN TRAN 
		INSERT INTO SUPPLY_TYPE (
			SupplyTypeName,
			SupplyTypeDesc
		) VALUES (
			@SupplyTypeName1,
			@SupplyTypeDesc1
		)
	COMMIT TRAN 
END 
GO 

CREATE PROCEDURE InsertSupply
	@SupplyTypeName1 nvarchar(50),
	@SupplyName1 nvarchar(50)
AS 
BEGIN 
	DECLARE @ST_ID int 

	EXEC GetSupplyTypes
	@TypeName = @SupplyTypeName1,
	@ID = @ST_ID Output

	-- Error Handling -- 

	IF @ST_ID IS NULL
	BEGIN
	PRINT '@ST_ID IS NULL and that is a problem'
	RAISERROR ('@ST_ID cannot be NULL; check spelling because transaction is failing', 11,1)
	RETURN
  END

	BEGIN TRAN 
		INSERT INTO SUPPLY (
			SupplyTypeID,
			SupplyName
		) VALUES (
			@ST_ID,
			@SupplyName1
		)
	COMMIT TRAN

END 
GO 

-- (Country)
CREATE PROCEDURE InsertCountry
	@RegionName1 nvarchar(50),
	@CountryName1 nvarchar(50)
AS 
BEGIN 
	DECLARE @R_ID int 

	EXEC GetRegion
	@Name = @RegionName1,
	@ID = @R_ID Output


	-- Error Handling -- 

	IF @R_ID IS NULL
	BEGIN
	PRINT '@R_ID IS NULL and that is a problem'
	RAISERROR ('@R_ID cannot be NULL; check spelling because transaction is failing', 11,1)
	RETURN
  END

	BEGIN TRAN 
		INSERT INTO COUNTRY (
			RegionID,
			CountryName
		) VALUES (
			@R_ID,
			@CountryName1
		)
	COMMIT TRAN

END 
GO 


-- (WTO Status)
CREATE PROCEDURE InsertCountryStatus
	@CountryName1 nvarchar(50),
	@WTOStatusName1 nvarchar(50)
AS 
BEGIN 
	DECLARE @C_ID int, @WTO_ID int

	EXEC GETCountry 
	@Name = @CountryName1,
	@ID = @C_ID Output

	EXEC GetWTOStatus
	@StatusName = @WTOStatusName1,
	@ID = @WTO_ID Output


	-- Error Handling -- 

	IF @C_ID IS NULL
	BEGIN
	PRINT '@C_ID IS NULL and that is a problem'
	RAISERROR ('@C_ID cannot be NULL; check spelling because transaction is failing', 11,1)
	RETURN
  END

  IF @WTO_ID IS NULL
	BEGIN
	PRINT '@WTO_ID IS NULL and that is a problem'
	RAISERROR ('@WTO_ID cannot be NULL; check spelling because transaction is failing', 11,1)
	RETURN
  END

	BEGIN TRAN 
		INSERT INTO COUNTRY_STATUS (
			CountryID,
			WTOStatusID
		) VALUES (
			@C_ID,
			@WTO_ID
		)
	COMMIT TRAN

END 
GO 

-- Fran
CREATE PROCEDURE InsertWTOStatus 
	@StatusName1 nvarchar(50),
	@StatusDesc1 nvarchar(50)
AS 
BEGIN 

	BEGIN TRAN 
		INSERT INTO WTO_STATUS (
			WTOStatusName,
			WTOStatusDesc
		) VALUES (
			@StatusName1,
			@StatusDesc1
		)
	COMMIT TRANSACTION
END 
GO 

-- (Event)
CREATE PROCEDURE InsertLocationType 
	@LocationTypeName1 nvarchar(50),
	@LocationTypeDesc1 nvarchar(50)
AS 
BEGIN 

	BEGIN TRAN 
		INSERT INTO LOCATION_TYPE (
			LocationTypeName,
			LocationTypeDesc
		) VALUES (
			@LocationTypeName1,
			@LocationTypeDesc1
		)
	COMMIT TRAN 
END 
GO 

CREATE PROCEDURE InsertLocation
	@LocationTypeName1 nvarchar(50),
	@LocationName1 nvarchar(50),
	@LocationDesc1 nvarchar(50)
AS 
BEGIN 
	DECLARE @LT_ID int 

	EXEC GetLocationType 
	@TypeName = @LocationTypeName1,
	@ID = @LT_ID Output 

	-- Error Handling -- 

	IF @LT_ID IS NULL
	BEGIN
	PRINT '@LT_ID IS NULL and that is a problem'
	RAISERROR ('@LT_ID cannot be NULL; check spelling because transaction is failing', 11,1)
	RETURN
  END

	BEGIN TRAN 
		INSERT INTO [LOCATION] (
			LocationTypeID,
			LocationName,
			LocationDesc
		) VALUES (
			@LT_ID,
			@LocationName1,
			@LocationDesc1
		)
	COMMIT TRAN 
END 
GO 

-- Anhad
CREATE PROCEDURE InsertEventType 
	@EventTypeName1 nvarchar(50),
	@EventTypeDesc1 nvarchar(50)
AS 
BEGIN 
	
	BEGIN TRAN 
		INSERT INTO EVENT_TYPE (
			EventTypeName,
			EventTypeDesc
		) VALUES (
			@EventTypeName1,
			@EventTypeDesc1
		)
	COMMIT TRAN
END 
GO 

CREATE PROCEDURE InsertEvent 
	@EventTypeName1 nvarchar(50), 
	@LocationName1 nvarchar(50),
	@EventName1 nvarchar(50),
	@EventDate date 
AS 

BEGIN 
	DECLARE @ET_ID int, @L_ID int 

	EXEC GetEventType 
	@TypeName = @EventTypeName1,
	@ID = @ET_ID Output

	EXEC GetLocation
	@Name = @LocationName1,
	@ID = @L_ID OUtput 

	-- Error Handling -- 

	IF @ET_ID IS NULL
	BEGIN
	PRINT '@ET_ID IS NULL and that is a problem'
	RAISERROR ('@ET_ID cannot be NULL; check spelling because transaction is failing', 11,1)
	RETURN
  END

  IF @L_ID IS NULL
	BEGIN
	PRINT '@L_ID IS NULL and that is a problem'
	RAISERROR ('@L_ID cannot be NULL; check spelling because transaction is failing', 11,1)
	RETURN
  END

	BEGIN TRAN 
		INSERT INTO EVENT (
			EventTypeID,
			LocationID,
			EventName,
			EventDate
		) VALUES (
			@ET_ID,
			@L_ID,
			@EventName1,
			@EventDate
		)
	COMMIT TRAN 

END 
GO 

-- (Demographic)
CREATE PROCEDURE InsertDemographicType
	@DemoTypeName1 nvarchar(50),
	@DemoTypeDesc1 nvarchar(50)
AS 
BEGIN 

	BEGIN TRAN 
		INSERT INTO DEMOGRAPHIC_TYPE (
			DemoTypeName,
			DemoTypeDesc
		) VALUES (
			@DemoTypeName1,
			@DemoTypeDesc1
		)
	COMMIT TRAN 

END 
GO 

-- Larry
CREATE PROCEDURE InsertDemographic 
	@DemographicTypeName1 nvarchar(50),
	@DemographicName1 nvarchar(50), 
	@DemographicDesc1 nvarchar(50)
AS 
BEGIN 
	DECLARE @DT_ID int 

	EXEC GetDemographicType
	@TypeName = @DemographicTypeName1,
	@ID = @DT_ID Output 

	-- Error Handling -- 

	IF @DT_ID IS NULL
	BEGIN
	PRINT '@DT_ID IS NULL and that is a problem'
	RAISERROR ('@DT_ID cannot be NULL; check spelling because transaction is failing', 11,1)
	RETURN
  END

	BEGIN TRAN 
		INSERT INTO DEMOGRAPHIC (
			DemoTypeID,
			DemoName,
			DemoDesc
		) VALUES (
			@DT_ID,
			@DemographicName1,
			@DemographicDesc1
		)
	COMMIT TRAN 

END 
GO 

-- (Detail)
CREATE PROCEDURE InsertDetailType 
	@DetailTypeName1 nvarchar(50),
	@DetailTypeDesc1 nvarchar(50)
AS
BEGIN 

	BEGIN TRAN 
		INSERT INTO DETAIL_TYPE(
			DetailTypeName,
			DetailTypeDesc
		) VALUES (
			@DetailTypeName1,
			@DetailTypeDesc1
		)
	COMMIT TRAN 

END 
GO 

CREATE PROCEDURE InsertDetail 
	@DetailTypeName1 nvarchar(50),
	@DetailName1 nvarchar(50),
	@DetailDesc1 nvarchar(50)
AS 
BEGIN 
	DECLARE @DET_ID int 

	EXEC GetDetailType
	@TypeName = @DetailTypeName1,
	@ID = @DET_ID Output 

	-- Error Handling -- 

	IF @DET_ID IS NULL
	BEGIN
	PRINT '@DET_ID IS NULL and that is a problem'
	RAISERROR ('@DET_ID cannot be NULL; check spelling because transaction is failing', 11,1)
	RETURN
  END

	BEGIN TRAN 
		INSERT INTO DETAIL (
			DetailTypeID,
			DetailName,
			DetailDesc
		) VALUES (
			@DET_ID,
			@DetailName1,
			@DetailDesc1
		)
	COMMIT TRAN 

END 
GO 

-- (Challenge)
CREATE PROCEDURE InsertChallengeType 
	@ChallengeTypeName1 nvarchar(50),
	@ChallengeTypeDesc1 nvarchar(50)
AS
BEGIN 
	
	BEGIN TRAN 
		INSERT INTO CHALLENGE_TYPE (
			ChallengeTypeName,
			ChallengeTypeDesc
		) VALUES (
			@ChallengeTypeName1,
			@ChallengeTypeDesc1
		)
	COMMIT TRAN 

END 
GO 

CREATE PROCEDURE InsertChallenge 
	@ChallengeTypeName1 nvarchar(50),
	@ChallengeName1 nvarchar(50),
	@ChallengeDesc1 nvarchar(50)
AS
BEGIN 
	DECLARE @CT_ID int 

	EXEC GetChallengeType
	@TypeName = @ChallengeTypeName1,
	@ID = @CT_ID Output 

	-- Error Handling -- 

	IF @CT_ID IS NULL
	BEGIN
	PRINT '@CT_ID IS NULL and that is a problem'
	RAISERROR ('@CT_ID cannot be NULL; check spelling because transaction is failing', 11,1)
	RETURN
  END

	BEGIN TRAN 
		INSERT INTO CHALLENGE (
			ChallengeTypeID,
			ChallengeName,
			ChallengeDesc
		) VALUES (
			@CT_ID,
			@ChallengeName1,
			@ChallengeDesc1
		)
	COMMIT TRAN 

END 
GO 

-- (Severity)
CREATE PROCEDURE InsertSeverity 
	@SeverityName1 nvarchar(50),
	@SeverityDesc1 nvarchar(50)
AS 
BEGIN 

	BEGIN TRAN 
		INSERT INTO SEVERITY(
			SeverityName,
			SeverityDesc
		) VALUES (
			@SeverityName1,
			@SeverityDesc1
		)
	COMMIT TRAN

END 
GO 

-- (City, Organization, Home)
CREATE PROCEDURE InsertCity 
	@CountryName1 nvarchar(50),
	@CityName1 nvarchar(50) 
AS 
BEGIN 
	DECLARE @C_ID int 

	EXEC GetCountry 
	@Name = @CountryName1,
	@ID = @C_ID Output 

	-- Error Handling -- 

	IF @C_ID IS NULL
	BEGIN
	PRINT '@C_ID IS NULL and that is a problem'
	RAISERROR ('@C_ID cannot be NULL; check spelling because transaction is failing', 11,1)
	RETURN
  END

	BEGIN TRAN 
		INSERT INTO CITY(
			CountryID,
			CityName 
		) VALUES (
			@C_ID,
			@CityName1
		)
	COMMIT TRAN 

END 
GO 

CREATE PROCEDURE InsertOrganization 
	@CityName1 nvarchar(50),
	@OTName1 nvarchar(50),
	@OrganizationName1 nvarchar(50)
AS 
BEGIN
	DECLARE @C_ID int, @OT_ID int
	EXEC GetCity 
	@Name = @CityName1,
	@ID = @C_ID Output

	EXEC GetOrgType 
	@TypeName = @OTName1,
	@ID = @OT_ID Output

	-- Error Handling --

	IF @C_ID IS NULL
	BEGIN
	PRINT '@C_ID IS NULL and that is a problem'
	RAISERROR ('@C_ID cannot be NULL; check spelling because transaction is failing', 11,1)
	RETURN
  END

  IF @OT_ID IS NULL
	BEGIN
	PRINT '@OT_ID IS NULL and that is a problem'
	RAISERROR ('@OT_ID cannot be NULL; check spelling because transaction is failing', 11,1)
	RETURN
  END

	BEGIN TRAN 
		INSERT INTO ORGANIZATION(
			CityID,
			OrgTypeID,
			OrgName
		) VALUES (
			@C_ID,
			@OT_ID,
			@OrganizationName1
		)
	COMMIT TRAN 

END 
GO 

CREATE PROCEDURE InsertHome 
	@CityName1 nvarchar(50),
	@HomeName1 nvarchar(50), 
	@HomeDesc1 nvarchar(50)
AS 
BEGIN 
	DECLARE @C_ID int 

	EXEC GetCity 
	@Name = @CityName1,
	@ID = @C_ID Output 

	-- Error Handling -- 

	IF @C_ID IS NULL
	BEGIN
	PRINT '@C_ID IS NULL and that is a problem'
	RAISERROR ('@C_ID cannot be NULL; check spelling because transaction is failing', 11,1)
	RETURN
  END

	BEGIN TRAN 
		INSERT INTO HOME(
			CityID,
			HomeName,
			HomeDesc
		) VALUES (
			@C_ID,
			@HomeName1,
			@HomeDesc1
		)
	COMMIT TRAN 

END 
GO 

CREATE PROCEDURE InsertDonor 
@Fname NVARCHAR(50),
@Lname NVARCHAR(50),
@DOB DATE 
AS 
BEGIN 

-- Business Rule error checking
    IF @DOB > (SELECT DateAdd(year, -12, GetDate()))
    BEGIN
        PRINT 'Donor is younger than 12';
        PRINT 'Business Rule violation has occurred; person under age 16';
        RAISERROR ('No person under age 12 can be a donor', 11,1)
        RETURN
    END

    BEGIN TRAN 
        INSERT INTO DONOR (
            DonorFname,
            DonorLname,
            DonorDOB 
        ) VALUES (
            @Fname,
            @Lname,
            @DOB
        )
END 
GO 

-- (Donation)
CREATE PROCEDURE InsertDonation
	@SupplyName1 nvarchar(50),
	@DonorFname1 nvarchar(50),
	@DonorLname1 nvarchar(50),
	@OrganizationName1 nvarchar(50),
	@DonationDate1 date,
	@Quantity1 int,
	@DollarAmount1 money,
	@DonationTaxBreak1 money 
AS 

-- Business Rule

    IF EXISTS (SELECT *
    FROM DONOR
    WHERE DonorFname = @DonorFname1
    AND DonorLname = @DonorLname1 
    AND DonorDOB > (SELECT DateAdd(year, -16, GetDate())))
    BEGIN
        PRINT 'Donor is under 16'
        PRINT 'Business Rule violation has occurred; person under age 16'
        RAISERROR ('No person under 16 can be a donor', 11,1)
        RETURN
    END

BEGIN 
	DECLARE @S_ID int, @D_ID int, @O_ID int 

	EXEC GetSupply 
	@Name = @SupplyName1,
	@ID = @S_ID Output 

	EXEC GetDonor 
	@Fname = @DonorFname1,
	@Lname = @DonorLname1,
	@ID = @D_ID Output 

	EXEC GetOrganization 
	@Name = @OrganizationName1,
	@ID = @O_ID Output 

	-- Error Handling --

	IF @S_ID IS NULL
	BEGIN
	PRINT '@S_ID IS NULL and that is a problem'
	RAISERROR ('@S_ID cannot be NULL; check spelling because transaction is failing', 11,1)
	RETURN
  END

  IF @O_ID IS NULL
	BEGIN
	PRINT '@O_ID IS NULL and that is a problem'
	RAISERROR ('@O_ID cannot be NULL; check spelling because transaction is failing', 11,1)
	RETURN
  END

  IF @D_ID IS NULL
	BEGIN
	PRINT '@D_ID IS NULL and that is a problem'
	RAISERROR ('@D_ID cannot be NULL; check spelling because transaction is failing', 11,1)
	RETURN
  END

	BEGIN TRAN 
		INSERT INTO DONATION(
			SupplyID,
			DonorID,
			OrgID,
			DonationDate,
			Quantity,
			DollarAmount,
			DonationTaxBreak
		) VALUES (
			@S_ID,
			@D_ID,
			@O_ID,
			@DonationDate1,
			@Quantity1,
			@DollarAmount1,
			@DonationTaxBreak1
		)
	COMMIT TRAN
END 
GO 

-- (Volunteer)
CREATE PROCEDURE InsertVolunteer 
	@OrganizationName1 nvarchar(50),
	@VolunteerFname1 nvarchar(50),
	@VolunteerLname1 nvarchar(50),
	@VolunteerDOB Date
AS 

-- business rule error handling
IF @VolunteerDOB < (SELECT DateAdd(year, -16, GetDate()))
BEGIN
PRINT 'Volunteer is younger than 16';
	PRINT 'Business Rule violation has occurred; person under age 16';
	RAISERROR ('No person under age 16 can be a volunteer', 11,1)
	RETURN

END

BEGIN 
	DECLARE @O_ID int 

	EXEC GetOrganization
	@Name = @OrganizationName1,
	@ID = @O_ID Output 

	-- Error Handling -- 

	IF @O_ID IS NULL
	BEGIN
	PRINT '@O_ID IS NULL and that is a problem'
	RAISERROR ('@O_ID cannot be NULL; check spelling because transaction is failing', 11,1)
	RETURN
  END

	BEGIN TRAN 
		INSERT INTO VOLUNTEER(
			OrgID,
			VolunteerFname,
			VolunteerLname,
			VolunteerDOB
		) VALUES (
			@O_ID,
			@VolunteerFname1,
			@VolunteerLname1,
			@VolunteerDOB
		)
	COMMIT TRAN

END 
GO 

-- (VolunteerEventRole)
CREATE PROCEDURE InsertVolunteerEventRole
	@VolunteerFname1 nvarchar(50),
	@VolunteerLname1 nvarchar(50),
	@RoleName1 nvarchar(50),
	@EventName1 nvarchar(50),
	@EventDate1 date 
AS 
BEGIN 
	DECLARE @V_ID int, @R_ID int, @E_ID int 

	EXEC GetVolunteer 
	@Fname = @VolunteerFname1,
	@Lname = @VolunteerLname1,
	@ID = @V_ID Output 

	EXEC GetRole 
	@Name = @RoleName1,
	@ID = @R_ID Output 

	EXEC GetEvent 
	@Name = @EventName1,
	@Date = @EventDate1,
	@ID = @E_ID Output 

	-- Error Handling -- 

	IF @V_ID IS NULL
	BEGIN
	PRINT '@V_ID IS NULL and that is a problem'
	RAISERROR ('@V_ID cannot be NULL; check spelling because transaction is failing', 11,1)
	RETURN
  END

  IF @R_ID IS NULL
	BEGIN
	PRINT '@R_ID IS NULL and that is a problem'
	RAISERROR ('@R_ID cannot be NULL; check spelling because transaction is failing', 11,1)
	RETURN
  END

  IF @E_ID IS NULL
	BEGIN
	PRINT '@E_ID IS NULL and that is a problem'
	RAISERROR ('@E_ID cannot be NULL; check spelling because transaction is failing', 11,1)
	RETURN
  END

	BEGIN TRAN 
		INSERT INTO VOLUNTEER_EVENT_ROLE(
			VolunteerID,
			RoleID,
			EventID
		) VALUES (
			@V_ID,
			@R_ID,
			@E_ID
		)
	COMMIT TRAN 

END 
GO 

-- (Client)
CREATE PROCEDURE InsertClient 
	@HomeName1 nvarchar(50),
	@ClientFname1 nvarchar(50),
	@ClientLname1 nvarchar(50),
	@ClientDOB1 date
AS 
BEGIN 
	DECLARE @H_ID int 

	EXEC GetHome 
	@Name = @HomeName1,
	@ID = @H_ID Output 

	-- Error Handling 

	IF @H_ID IS NULL
	BEGIN
	PRINT '@H_ID IS NULL and that is a problem'
	RAISERROR ('@H_ID cannot be NULL; check spelling because transaction is failing', 11,1)
	RETURN
  END

	BEGIN TRAN	
		INSERT INTO CLIENT(
			HomeID,
			ClientFname,
			ClientLname,
			ClientDOB
		) VALUES (
			@H_ID,
			@ClientFname1,
			@ClientLname1,
			@ClientDOB1
		)
	COMMIT TRAN 

END 
GO 

CREATE PROCEDURE InsertClientChallenge 
	@ClientFname1 nvarchar(50),
	@ClientLname2 nvarchar(50),
	@ClientDOB1 date,
	@ChallengeName1 nvarchar(50),
	@SeverityName1 nvarchar(50)
AS 
BEGIN 
	DECLARE @C_ID int, @CL_ID int, @S_ID int

	EXEC GetClient 
	@Fname = @ClientFname1,
	@Lname = @ClientLname2,
	@Date = @ClientDOB1,
	@ID = @C_ID Output 

	EXEC GetChallenge 
	@Name = @ChallengeName1,
	@ID = @CL_ID Output 

	EXEC GetSeverity 
	@Name = @SeverityName1,
	@ID = @S_ID Output 

	-- Error Handling --

	IF @CL_ID IS NULL
	BEGIN
	PRINT '@CL_ID IS NULL and that is a problem'
	RAISERROR ('@CL_ID cannot be NULL; check spelling because transaction is failing', 11,1)
	RETURN
  END

  IF @C_ID IS NULL
	BEGIN
	PRINT '@C_ID IS NULL and that is a problem'
	RAISERROR ('@C_ID cannot be NULL; check spelling because transaction is failing', 11,1)
	RETURN
  END

  IF @S_ID IS NULL
	BEGIN
	PRINT '@S_ID IS NULL and that is a problem'
	RAISERROR ('@S_ID cannot be NULL; check spelling because transaction is failing', 11,1)
	RETURN
  END

	BEGIN TRAN 
		INSERT INTO CLIENT_CHALLENGE_SEVERITY(
			ClientID,
			ChallengeID,
			SeverityID
		) VALUES (
			@C_ID,
			@CL_ID,
			@S_ID 
		)
	COMMIT TRAN

END 
GO 

CREATE PROCEDURE InsertClientDetail
	@ClientFname1 nvarchar(50),
	@ClientLname2 nvarchar(50),
	@ClientDOB1 date,
	@DetailName1 nvarchar(50)
AS 
BEGIN 
	DECLARE @C_ID int, @D_ID int

	EXEC GetClient 
	@Fname = @ClientFname1,
	@Lname = @ClientLname2,
	@Date = @ClientDOB1,
	@ID = @C_ID Output 

	EXEC GetDetail
	@Name = @DetailName1,
	@ID = @D_ID Output 

	-- Error Handling --

	IF @C_ID IS NULL
	BEGIN
	PRINT '@C_ID IS NULL and that is a problem'
	RAISERROR ('@C_ID cannot be NULL; check spelling because transaction is failing', 11,1)
	RETURN
  END

  IF @D_ID IS NULL
	BEGIN
	PRINT '@D_ID IS NULL and that is a problem'
	RAISERROR ('@D_ID cannot be NULL; check spelling because transaction is failing', 11,1)
	RETURN
  END

	BEGIN TRAN 
		INSERT INTO CLIENT_DETAIL(
			ClientID,
			DetailID
		) VALUES (
			@C_ID,
			@D_ID
		)
	COMMIT TRAN

END 
GO 

CREATE PROCEDURE InsertClientDemographic
	@ClientFname1 nvarchar(50),
	@ClientLname2 nvarchar(50),
	@ClientDOB1 date,
	@DemoName1 nvarchar(50)
AS 
BEGIN 
	DECLARE @C_ID int, @D_ID int

	EXEC GetClient 
	@Fname = @ClientFname1,
	@Lname = @ClientLname2,
	@Date = @ClientDOB1,
	@ID = @C_ID Output 

	EXEC GetDemographic
	@Name = @DemoName1,
	@ID = @D_ID Output 

	-- Error Handling --

	IF @C_ID IS NULL
	BEGIN
	PRINT '@C_ID IS NULL and that is a problem'
	RAISERROR ('@C_ID cannot be NULL; check spelling because transaction is failing', 11,1)
	RETURN
  END

	IF @D_ID IS NULL
	BEGIN
	PRINT '@D_ID IS NULL and that is a problem'
	RAISERROR ('@D_ID cannot be NULL; check spelling because transaction is failing', 11,1)
	RETURN
  END

	BEGIN TRAN 
		INSERT INTO CLIENT_DEMOGRAPHIC(
			ClientID,
			DemoID
		) VALUES (
			@C_ID,
			@D_ID
		)
	COMMIT TRAN

END 
GO 

---------------------
-- Wrappers for Populating --
---------------------

-- Erika
CREATE TABLE CITYPK(
	City_PK INT IDENTITY(1,1) primary key,
	CityName [nvarchar](100) NULL,
	CountryName [nvarchar](100) NULL
)
GO

CREATE PROCEDURE CITY_CSV_WRAPPER
AS

DECLARE @Run INT = (SELECT COUNT(*) FROM CityPK)
DECLARE @MIN_PK INT, @C_Name nvarchar(50), @Country_Name nvarchar(50)

WHILE @RUN > 0
BEGIN
SET @MIN_PK = (SELECT MIN(City_PK) FROM CityPK)
SET @C_Name = (SELECT CityName FROM CityPK WHERE City_PK = @MIN_PK)
SET @Country_Name = (SELECT CountryName FROM CityPK WHERE City_PK = @MIN_PK)

IF EXISTS(SELECT 1 FROM COUNTRY
          WHERE CountryName = @Country_Name)
    BEGIN
        EXEC InsertCity
		@CountryName1 = @Country_Name,
		@CityName1 = @C_Name
    END

DELETE FROM CityPK WHERE City_PK = @MIN_PK
SET @RUN = @RUN -1

END
GO

EXEC CITY_CSV_WRAPPER
GO

DROP TABLE CITYPK
GO

CREATE TABLE ORGPK(
	Org_PK INT IDENTITY(1,1) primary key,
	OrgName [nvarchar](200) NULL
)
GO

CREATE PROCEDURE ORG_CSV_WRAPPER
AS

DECLARE @Run INT = (SELECT COUNT(*) FROM ORGPK)
DECLARE @MIN_PK INT, @Org_Name nvarchar(50), @City_Name nvarchar(50), @OT_Name nvarchar(50)

WHILE @RUN > 0
BEGIN
SET @MIN_PK = (SELECT MIN(Org_PK) FROM ORGPK)
SET @Org_Name = (SELECT OrgName FROM ORGPK WHERE Org_PK = @MIN_PK)

DECLARE @CCount INT = (SELECT COUNT(*) FROM CITY)
DECLARE @OTCount INT = (SELECT COUNT(*) FROM ORG_TYPE)

DECLARE @CPK INT
DECLARE @OTPK INT
DECLARE @RAND INT

SET @CPK = (SELECT RAND() * @CCount + 1)
SET @City_Name = (SELECT TOP 1 CityName FROM CITY WHERE CityID = @CPK)


SET @OTPK = (SELECT RAND() * @OTCount + 1)
SET @OT_Name = (SELECT OrgTypeName FROM ORG_TYPE WHERE OrgTypeID = @OTPK)

EXEC InsertOrganization
@CityName1 = @City_Name,
@OTName1 = @OT_Name,
@OrganizationName1 = @Org_Name

DELETE FROM ORGPK WHERE Org_PK = @MIN_PK
SET @RUN = @RUN -1

END
GO

EXEC ORG_CSV_WRAPPER
GO

DROP TABLE ORGPK
GO

CREATE TABLE EVENTPK(
	Event_PK INT IDENTITY(1,1) primary key,
	EventName [nvarchar](100) NULL
)
GO

INSERT INTO EVENTPK
(EventName)
VALUES 
('eventname1'),
('eventname2'),
('eventname3'),
('eventname4'),
('eventname5')
GO

-- Anhad
CREATE PROCEDURE EVENT_WRAPPER
AS

DECLARE @Run INT = (SELECT COUNT(*) FROM EVENTPK)
DECLARE @MIN_PK INT, @E_Name nvarchar(50), @ET_Name nvarchar(50), @L_Name nvarchar(50), @E_Date date

WHILE @RUN > 0
BEGIN
SET @MIN_PK = (SELECT MIN(Event_PK) FROM EVENTPK)
SET @E_Name = (SELECT EventName FROM EVENTPK WHERE Event_PK = @MIN_PK)

DECLARE @ETCount INT = (SELECT COUNT(*) FROM EVENT_TYPE)
DECLARE @LCount INT = (SELECT COUNT(*) FROM [LOCATION])

DECLARE @ETPK INT
DECLARE @LPK INT
DECLARE @RAND INT

SET @ETPK = (SELECT RAND() * @ETCount + 1)
SET @ET_Name = (SELECT TOP 1 EventTypeName FROM EVENT_TYPE WHERE EventTypeID = @ETPK)

SET @LPK = (SELECT RAND() * @LCount + 1)
SET @L_Name = (SELECT LocationName FROM [LOCATION] WHERE LocationID = @LPK)

SET @E_Date = (SELECT DATEADD(DAY, -1 * CEILING(RAND()*1000) , GETDATE()))

EXEC InsertEvent
@EventTypeName1 = @ET_Name,
@LocationName1 = @L_Name,
@EventName1 = @E_Name,
@EventDate = @E_Date

DELETE FROM EVENTPK WHERE Event_PK = @MIN_PK
SET @RUN = @RUN -1

END
GO

EXEC EVENT_WRAPPER
GO

DROP TABLE EVENTPK
GO

-- Larry
CREATE PROCEDURE wrapper_DONATION_INSERT 
@Run INT 
AS 

DECLARE 
    @S_Name nvarchar(50), 
    @D_Fname nvarchar(50), 
    @D_Lname nvarchar(50), 
    @O_Name nvarchar(50), 
    @D_Date date,
    @N_Quan int,
    @N_Amo money,
    @N_Tax money 

DECLARE @Supply_Count int = (SELECT COUNT(*) FROM Supply)
DECLARE @Donor_Count int = (SELECT COUNT(*) FROM DONOR)
DECLARE @Org_Count int = (SELECT COUNT(*) FROM ORGANIZATION)
DECLARE @Supply_PK int 
DECLARE @Donor_PK int 
DECLARE @Org_PK int 

WHILE @Run > 0 
BEGIN 

    SET @Supply_PK = (SELECT RAND() * @Supply_Count + 1)
    SET @Donor_PK = (SELECT RAND() * @Donor_Count + 1)
    SET @Org_PK = (SELECT RAND() * @Org_Count + 1)

    SET @S_Name = (SELECT SupplyName FROM SUPPLY WHERE SupplyID = @Supply_PK)
    SET @D_Fname = (SELECT DonorFname FROM DONOR WHERE DonorID = @Donor_PK)
    SET @D_Lname = (SELECT DonorLname FROM DONOR WHERE DonorID = @Donor_PK)
    SET @O_Name = (SELECT OrgName FROM ORGANIZATION WHERE OrgID = @Org_PK)
    SET @D_Date = (SELECT GetDate() - (SELECT RAND() * 1000))
    SET @N_Quan = (SELECT RAND() * 100000)
    SET @N_Amo = (SELECT RAND() * 100000)
    SET @N_Tax = (SELECT RAND() * 10000)

    EXEC InsertDonation 
    @SupplyName1 = @S_Name,
    @DonorFname1 = @D_Fname,
    @DonorLname1 = @D_Lname,
    @OrganizationName1 = @O_Name,
    @DonationDate1 = @D_Date,
    @Quantity1 = @N_Quan,
    @DollarAmount1 = @N_Amo,
    @DonationTaxBreak1 = @N_Tax

    SET @Run = @Run - 1
END 
GO 

EXEC wrapper_DONATION_INSERT 500
GO

-- Erika
CREATE PROCEDURE WRAPPER_INSERT_VOLUNTEER_EVENT_ROLE
@Run INT
AS

DECLARE @FN varchar(50), @LN varchar(50), @RN varchar(50), @EN varchar(100), @ED Date

DECLARE @VCount INT = (SELECT COUNT(*) FROM VOLUNTEER)
DECLARE @RCount INT = (SELECT COUNT(*) FROM [ROLE])
DECLARE @ECount INT = (SELECT COUNT(*) FROM [EVENT])

DECLARE @VPK INT
DECLARE @RPK INT
DECLARE @EPK INT

DECLARE @RAND INT

WHILE @Run > 0
BEGIN
SET @VPK = (SELECT RAND() * @VCount + 1)
SET @FN = (SELECT VolunteerFName FROM VOLUNTEER WHERE VolunteerID = @VPK)
SET @LN = (SELECT VolunteerLName FROM VOLUNTEER WHERE VolunteerID = @VPK)
SET @RPK = (SELECT RAND() * @RCount + 1)
SET @RN = (SELECT RoleName FROM [ROLE] WHERE RoleID = @RPK)
SET @EPK = (SELECT RAND() * @ECount + 1)
SET @EN = (SELECT EventName FROM [EVENT] WHERE EventID = @EPK)
SET @ED = (SELECT EventDate FROM [EVENT] WHERE EventID = @EPK)

EXEC InsertVolunteerEventRole
	@VolunteerFname1 = @FN,
	@VolunteerLname1 = @LN,
	@RoleName1 = @RN,
	@EventName1 = @EN,
	@EventDate1 = @ED 

SET @Run = @Run -1
END
GO

EXEC WRAPPER_INSERT_VOLUNTEER_EVENT_ROLE 500
GO

-- Fran
CREATE PROCEDURE usp_INSERT_COUNTRY_STATUS_WRAPPER
@RUN INT
AS

DECLARE @C_ID INT, @WTO_ID INT, @CName varchar(50), @WTOStat varchar(50)

DECLARE @Country_RC INT = (SELECT COUNT(*) FROM COUNTRY)
DECLARE @WTO_RC INT = (SELECT COUNT(*) FROM WTO_STATUS)

WHILE @RUN > 0
BEGIN
SET @C_ID = (RAND() * @Country_RC + 1)
SET @WTO_ID = (RAND() * @WTO_RC + 1)
SET @CName = (SELECT CountryName FROM COUNTRY WHERE CountryID = @C_ID)
SET @WTOStat = (SELECT WTOStatusName FROM WTO_STATUS WHERE WTOStatusID = @WTO_ID)

EXEC InsertCountryStatus
@CountryName1 = @CName,
@WTOStatusName1 = @WTOStat

SET @Run = @Run - 1
END
GO

EXEC usp_INSERT_COUNTRY_STATUS_WRAPPER 500
GO

---------------------
-- Computed Columns --
---------------------

-- Anhad
CREATE FUNCTION timeSinceEvent(@EventDate DATE)
RETURNS INT
AS
BEGIN
DECLARE @CurrentDate DATE = (SELECT GETDATE())
DECLARE @RET INT = DATEDIFF(day, @EventDate, @CurrentDate)
RETURN @RET
END
GO

ALTER TABLE EVENT
ADD DaysSinceEvent AS dbo.timeSinceEvent(EventDate)
GO

CREATE FUNCTION volunteerAge(@DOB DATE)
RETURNS INT
AS
BEGIN
DECLARE @CurrentDate DATE = (SELECT GETDATE())
DECLARE @RET INT = DATEDIFF(year, @DOB, @CurrentDate)
RETURN @RET
END
GO

ALTER TABLE VOLUNTEER
ADD VolunteerAge AS dbo.volunteerAge(VolunteerDOB)
GO

-- Fran
CREATE FUNCTION numOfDonations(@ID INT)
RETURNS INT
AS
BEGIN
DECLARE @Count INT = (SELECT COUNT(DonorID) FROM DONATION WHERE DonorID = @ID GROUP BY DonorID)
DECLARE @RET INT = 0
IF @Count > 0
BEGIN
SET @RET = @Count
END
RETURN @RET
END
GO

ALTER TABLE DONOR
ADD NumOfDonations AS dbo.numOfDonations(DonorID)
GO

CREATE FUNCTION numOfOrgs(@ID INT)
RETURNS INT
AS
BEGIN
DECLARE @Count INT = (SELECT COUNT(o.OrgID) FROM ORGANIZATION o
JOIN CITY ct ON o.CityID = ct.CityID
JOIN COUNTRY c ON ct.CountryID = c.CountryID  
WHERE c.CountryID = @ID
GROUP BY c.CountryID)
DECLARE @RET INT  = 0
IF @Count > 0
BEGIN
SET @RET  = @Count
END
RETURN @RET
END
GO

ALTER TABLE COUNTRY
ADD numOfOrgs AS dbo.numOfOrgs(CountryID)
GO

-- Erika

CREATE FUNCTION lifetimeDonorAmount(@ID INT)
RETURNS Numeric(8,2)
AS
BEGIN
DECLARE @Amount Numeric(8,2) = (SELECT SUM(D.DollarAmount) FROM DONATION D
WHERE D.DonorID = @ID
GROUP BY D.DonorID)
RETURN @Amount
END
GO

ALTER TABLE DONOR
ADD lifetimeDonorAmount AS dbo.lifetimeDonorAmount(DonorID)
GO

CREATE FUNCTION donationAmountRange(@ID INT)
RETURNS VARCHAR(50)
AS 
BEGIN 
    DECLARE @MAX Numeric(8,2) = 
	(SELECT TOP 1 DollarAmount FROM DONATION 
	WHERE DonationID = @ID ORDER BY DollarAmount DESC)
    DECLARE @MIN Numeric(8,2) = 
	(SELECT TOP 1 DollarAmount FROM DONATION 
	WHERE DonationID = @ID ORDER BY DollarAmount ASC)
	DECLARE @RET varchar(50)
	IF @MAX IS NULL AND @MIN IS NULL 
		RETURN NULL
    SET @RET = (SELECT CONCAT(@MAX, ' - ', @MIN))
    RETURN @RET
END
GO 

ALTER TABLE DONATION
ADD donationAmountRange AS dbo.donationAmountRange(DonationID)
GO

-- Larry

CREATE FUNCTION clientNumChallenges(@ID INT)
RETURNS INT
AS
BEGIN
DECLARE @Num INT = (SELECT COUNT(C.ChallengeID) FROM CLIENT_CHALLENGE_SEVERITY C
WHERE C.ClientID = @ID
GROUP BY C.ClientID)
RETURN @Num
END
GO

ALTER TABLE CLIENT
ADD NumChallenges AS dbo.clientNumChallenges(ClientID)
GO

CREATE FUNCTION avgQuantityDonated(@ID INT)
RETURNS INT
AS
BEGIN
DECLARE @Num INT = (SELECT Avg(D.Quantity) FROM DONATION D
WHERE D.DonorID = @ID
GROUP BY D.DonorID)
RETURN @Num
END
GO

ALTER TABLE DONOR
ADD avgQuantityDonated AS dbo.avgQuantityDonated(DonorID)
GO

---------------------
-- Business Rules --
---------------------

-- Anhad

-- No volunteer below the age of 16 can volunteer as a lead at a conference

CREATE FUNCTION FN_AgeRestrictAtConf()
RETURNS INT
AS
BEGIN
    DECLARE @Ret INT = 0
    IF EXISTS (
        SELECT V.VolunteerID
        FROM Volunteer V 
        JOIN Volunteer_Event_Role VER ON VER.VolunteerID = V.VolunteerID
        JOIN Event E ON E.EventID = VER.EventID
        JOIN Event_Type ET ON ET.EventTypeID = E.EventTypeID
        JOIN Role R ON R.RoleID = VER.RoleID
        WHERE V.VolunteerDOB < (SELECT GetDate() - 365.25 * 16)
        AND R.RoleName = 'Lead'
        AND ET.EventTypeName = 'Conferences'
        GROUP BY V.VolunteerID
    )
BEGIN   
    SET @Ret = 1
    END
RETURN @Ret
END
GO

ALTER TABLE VOLUNTEER
ADD CONSTRAINT AgeRestrictAtConf
CHECK(dbo.FN_AgeRestrictAtConf() = 0)
GO

CREATE FUNCTION FN_DonationToDevelopedNation()
RETURNS INT
AS
BEGIN
    DECLARE @Ret INT = 0
    IF EXISTS (
       SELECT O.OrgName, D.DollarAmount, CO.CountryName
       FROM Donation D
       JOIN Organization O ON O.OrgID = D.OrgID
       JOIN City C ON C.CityID = O.CityID
       JOIN Country CO ON CO.CountryID = C.CountryID
       JOIN Country_Status CS ON CS.CountryID = CO.CountryID
       JOIN WTO_Status WS ON WS.WTOStatusID = CS.WTOStatusID
       WHERE WS.WTOStatusName = 'Developed Nation'
       GROUP BY O.OrgName, D.DollarAmount, CO.CountryName
       HAVING D.DollarAmount > 500000
    )
BEGIN   
    SET @Ret = 1
    END
RETURN @Ret
END
GO

ALTER TABLE DONATION
ADD CONSTRAINT DonationToDevelopedNation
CHECK(dbo.FN_DonationToDevelopedNation() = 0)
GO

-- Erika

CREATE FUNCTION FN_DonationAmount()
RETURNS INT
AS BEGIN
DECLARE @RET INT = 0
IF EXISTS(
SELECT *
    FROM DONATION D
	WHERE D.DollarAmount < 1
)
BEGIN
	SET @RET = 1
	END
RETURN @RET
END
GO

ALTER TABLE DONATION
ADD CONSTRAINT DonationAmount
CHECK(dbo.FN_DonationAmount() = 0)
GO

CREATE FUNCTION FN_SchoolsHostEventsAtSchools()
RETURNS INT
AS
BEGIN
    DECLARE @Ret INT = 0
    IF EXISTS (
        SELECT O.OrgName
        FROM Organization O
        JOIN Volunteer V ON V.OrgID = O.OrgID
        JOIN Volunteer_Event_Role VER ON VER.VolunteerID = V.VolunteerID
        JOIN Event E ON E.EventID = VER.EventID
        JOIN Location L ON L.LocationID = E.LocationID
        JOIN Location_Type LT ON LT.LocationTypeID = L.LocationTypeID
        JOIN Org_Type OT ON OT.OrgTypeID = O.OrgTypeID
        WHERE OT.OrgTypeName = 'School'
        AND LT.LocationTypeName = 'School'
        AND O.OrgName = L.LocationName
        GROUP BY O.OrgName
    )
BEGIN   
    SET @Ret = 1
    END
RETURN @Ret
END
GO

ALTER TABLE [EVENT]
ADD CONSTRAINT SchoolsHostEventsAtSchools
CHECK(dbo.FN_SchoolsHostEventsAtSchools() = 0)
GO
-- Larry

--- Clients facing a challenge of housing, employment or resources will have a critical severity status

CREATE FUNCTION FN_CriticalSeverityStatus()
RETURNS INT
AS
BEGIN
    DECLARE @Ret INT = 0
    IF EXISTS (
       SELECT C.ClientFName, C.ClientLName, CT.ChallengeTypeName, S.SeverityName 
       FROM Client C
       JOIN Client_Challenge_Severity CC ON CC.ClientID = C.ClientID
       JOIN Challenge CH ON CH.ChallengeID = CC.ChallengeID
       JOIN Challenge_Type CT ON CT.ChallengeTypeID = CH.ChallengeTypeID
       JOIN Severity S ON S.SeverityID = CC.SeverityID
       WHERE S.SeverityName = 'Critical'
       AND (CT.ChallengeTypeName = 'Housing' 
       OR CT.ChallengeTypeName = 'Employment' 
       OR CT.ChallengeTypeName = 'Resources')
       GROUP BY C.ClientFName, C.ClientLName, CT.ChallengeTypeName, S.SeverityName
    )
BEGIN   
    SET @Ret = 1
    END
RETURN @Ret
END
GO

ALTER TABLE SEVERITY
ADD CONSTRAINT CriticalSeverityStatus
CHECK(dbo.FN_CriticalSeverityStatus() = 0)
GO

--- Organizations from regions outside North America are International Organizations

CREATE FUNCTION FN_InternationalOrganizationType()
RETURNS INT
AS
BEGIN
    DECLARE @Ret INT = 0
    IF EXISTS (
       SELECT O.OrgName, R.RegionName, OT.OrgTypeName
       FROM Organization O
       JOIN City C ON C.CityID = O.CityID
       JOIN Country CO ON CO.CountryID = C.CountryID
       JOIN Region R ON R.RegionID = CO.RegionID
       JOIN Org_Type OT ON OT.OrgTypeID = O.OrgTypeID
       WHERE OT.OrgTypeName = 'International'
       AND (R.RegionName = 'Europe'
       OR R.RegionName = 'Middle East'
       OR R.RegionName = 'Asia & Pacific'
       OR R.RegionName = 'Africa'
       OR R.RegionName = 'South America'
       OR R.RegionName = 'Australia'
       OR R.RegionName = 'The Caribbean')
       GROUP BY O.OrgName, R.RegionName, OT.OrgTypeName
    )
BEGIN   
    SET @Ret = 1
    END
RETURN @Ret
END
GO

ALTER TABLE ORGANIZATION
ADD CONSTRAINT InternationalOrganizationType
CHECK(dbo.FN_InternationalOrganizationType() = 0)
GO

-- Fran

CREATE FUNCTION FN_DonationQuantity()
RETURNS INT
AS BEGIN
DECLARE @RET INT = 0
IF EXISTS(
SELECT *
    FROM DONATION D
	WHERE D.Quantity < 0
)
BEGIN
	SET @RET = 1
	END
RETURN @RET
END
GO

ALTER TABLE DONATION
ADD CONSTRAINT DonationQuantity
CHECK(dbo.FN_DonationQuantity() = 0)
GO

CREATE FUNCTION FN_SupplyRestrictionAtIntlOrg()
RETURNS INT
AS
BEGIN
    DECLARE @Ret INT = 0
    IF EXISTS (
        SELECT O.OrgName
        FROM Organization O
        JOIN Donation D ON D.OrgID = O.OrgID
        JOIN Supply S ON S.SupplyID = D.SupplyID
        JOIN Supply_Type ST ON ST.SupplyTypeID = S.SupplyTypeID
        JOIN Org_Type OT ON OT.OrgTypeID = O.OrgTypeID
        WHERE OT.OrgTypeName = 'International'
        AND ST.SupplyTypeName = 'Food' OR ST.SupplyTypeName = 'Drink'
        GROUP BY O.OrgName 
    )
BEGIN   
    SET @Ret = 1
    END
RETURN @Ret
END
GO

ALTER TABLE SUPPLY
ADD CONSTRAINT SupplyRestrictionAtIntlOrg
CHECK(dbo.FN_SupplyRestrictionAtIntlOrg() = 0)
GO

---------------------
-- Views --
---------------------

-- Erika
CREATE VIEW vwCOUNTRY_ORG
AS
SELECT f.CountryName, f.Num_Org
FROM (
	SELECT C.CountryName, COUNT(O.OrgName) AS Num_Org
	FROM COUNTRY C
	JOIN CITY CI
	On C.CountryID = CI.CountryID
	JOIN ORGANIZATION O
	On CI.CityID = O.CityID
	GROUP BY C.CountryName) as f
WHERE Num_Org > 1
GO

CREATE VIEW vwSUPPLY_DONATION_DONOR
AS
SELECT f.SupplyName, DO.DonorFname + ' ' + DO.DonorLname AS Donor_Name, f.Num_Supplies_Donor
FROM (
	SELECT S.SupplyName, DO.DonorID, COUNT(S.SupplyID) AS Num_Supplies_Donor
	FROM SUPPLY S
	JOIN DONATION D
	ON S.SupplyID = D.SupplyID
	JOIN DONOR DO
	ON D.DonorID = DO.DonorID
	GROUP BY S.SupplyName, DO.DonorID) as f
JOIN DONOR DO
ON f.DonorID = DO.DonorID
GO

-- Anhad
-- How many volunteers volunteered at Conferences in Schools categorized by Organization

CREATE VIEW vw_NUM_VOLUNTEERS_ORGANIZATION_SCHOOL_CONFERENCES
AS (
    SELECT COUNT(V.VolunteerID) AS NUM_VOLUNTEERS, O.OrgName
    FROM Volunteer V
    JOIN Organization O ON O.OrgID = V.OrgID
    JOIN Volunteer_Event_Role VER ON VER.VolunteerID = V.VolunteerID
    JOIN Event E ON E.EventID = VER.EventID
    JOIN Event_Type ET ON ET.EventTypeID = E.EventID
    JOIN Location L ON L.LocationID = E.LocationID
    JOIN Location_Type LT ON LT.LocationTypeID = L.LocationTypeID
    WHERE ET.EventTypeName = 'Conferences'
    AND LT.LocationTypeName = 'School'
    GROUP BY O.OrgName
)
GO

-- How many donations were made of food from donors born in 1986 from developed nations, categorized by Organization

CREATE VIEW vw_NUM_DONATIONS_OF_FOOD_1986
AS (
    SELECT COUNT(D.DonationID) AS NUM_DONATIONS, O.OrgName
    FROM Donation D
    JOIN Organization O ON O.OrgID = D.OrgID
    JOIN City C ON C.CityID = O.CityID
    JOIN Country CO ON CO.CountryID = C.CountryID
    JOIN Country_Status CS ON CS.CountryID = CO.CountryID
    JOIN WTO_Status WS ON WS.WTOStatusID = CS.WTOStatusID
    JOIN Donor DO ON DO.DonorID = D.DonorID
    JOIN Supply S ON S.SupplyID = D.SupplyID
    JOIN Supply_Type ST ON ST.SupplyTypeID = S.SupplyTypeID
    WHERE ST.SupplyTypeName = 'Food'
    AND DO.DonorDOB LIKE '1986'
    AND WS.WTOStatusName = 'Developed Nation'
    GROUP BY O.OrgName
)
GO

-- Larry

CREATE VIEW vwDIS_DATE
AS
SELECT f.[Year], f.Num_Per_Year
FROM (
	SELECT YEAR(C.ClientDisplaceDate) as [Year], COUNT(C.ClientID) AS Num_Per_Year
	FROM CLIENT C
	WHERE YEAR(C.ClientDOB) BETWEEN 1940 AND 1965
	GROUP BY YEAR(C.ClientDisplaceDate)) as f
WHERE f.[Year] BETWEEN 1950 AND 1960 AND Num_Per_Year > 6200
GO

CREATE VIEW vwEvent_Location
AS 
SELECT ET.EventTypeName, E.EventName, E.EventDate, L.LocationName, LT.LocationTypeName 
FROM [EVENT] E 
JOIN EVENT_TYPE ET ON E.EventTypeID = ET.EventTypeID
JOIN [LOCATION] L ON L.LocationID = E.LocationID 
JOIN LOCATION_TYPE LT ON L.LocationTypeID = LT.LocationTypeID
GO 

CREATE VIEW vwClient_Challenge_Country_Severity
AS 
SELECT CL.ClientFname, CL.ClientLname, C.CountryName, CHT.ChallengeTypeName, CH.ChallengeName, S.SeverityName 
FROM CHALLENGE CH 
JOIN CHALLENGE_TYPE CHT ON CH.ChallengeTypeID = CHT.ChallengeTypeID
JOIN CLIENT_CHALLENGE_SEVERITY CCS ON CCS.ChallengeID = CH.ChallengeID 
JOIN SEVERITY S ON S.SeverityID = CCS.SeverityID
JOIN CLIENT CL ON CCS.ClientID = CL.ClientID 
JOIN HOME H ON H.HomeID = CL.HomeID
JOIN CITY CT ON CT.CityID = H.HomeID
JOIN COUNTRY C ON CT.CountryID = C.CountryID
GO

-- Fran

CREATE VIEW vwTOP_5_ORG_DONOR
AS
SELECT TOP 5 * FROM
(SELECT o.OrgName, COUNT(dnr.DonorID) AS DonorCount
FROM ORGANIZATION o JOIN DONATION d ON o.OrgID = d.OrgID
JOIN DONOR dnr ON d.DonorID = dnr.DonorID GROUP BY o.OrgName) AS f
ORDER BY f.DonorCount DESC
GO

CREATE VIEW vwROLES_OVER_200
AS
SELECT * FROM (SELECT r.RoleName, COUNT(v.VolunteerID) AS VolunteerCount
FROM [ROLE] r JOIN VOLUNTEER_EVENT_ROLE ver ON r.RoleID = ver.RoleID
JOIN VOLUNTEER v ON ver.VolunteerID = v.VolunteerID GROUP BY r.RoleName) AS f WHERE VolunteerCount > 200
GO

-- BACKUP DATABASE Proj_INFO_430_A6 TO DISK = 'c:\sql\Proj_INFO_430_A6.bak' WITH DIFFERENTIAL