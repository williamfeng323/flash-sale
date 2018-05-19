DROP TABLE Couple;

CREATE TABLE coupleTemp (
  CoupleId BIGINT NOT NULL IDENTITY, 
  EventTypeId INT NOT NULL, 
  EventDate DATETIME, 
  City NVARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS, 
  State VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS, 
  Zip NVARCHAR(20) COLLATE SQL_Latin1_General_CP1_CI_AS, 
  Registrant1FirstName NVARCHAR(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
  Registrant1LastName NVARCHAR(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, 
  Registrant1Email NVARCHAR(128) COLLATE SQL_Latin1_General_CP1_CI_AS, 
  Registrant2FirstName NVARCHAR(50) COLLATE SQL_Latin1_General_CP1_CI_AS, 
  Registrant2LastName NVARCHAR(50) COLLATE SQL_Latin1_General_CP1_CI_AS, 
  Registrant2Email NVARCHAR(128) COLLATE SQL_Latin1_General_CP1_CI_AS, 
  IsDeleted BIT DEFAULT 0 NOT NULL, 
  CreatedDate DATETIME DEFAULT getdate() NOT NULL, 
  CreatedBy NVARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS, 
  ModifiedDate DATETIME, ModifiedBy NVARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS, 
  Country NVARCHAR(50) COLLATE SQL_Latin1_General_CP1_CI_AS, 
  IsPrivate BIT DEFAULT 0 NOT NULL, 
  IsHiddenSearchEngines BIT DEFAULT 0 NOT NULL, 
  IsActive BIT DEFAULT 1 NOT NULL, 
  MergedCoupleId BIGINT, 
  IsManualOverrided BIT DEFAULT 1 NOT NULL, 
  IsHiddenProducts BIT DEFAULT 0 NOT NULL, 
  IsHiddenProductsInWebsite BIT DEFAULT 1 NOT NULL, 
  IsHiddenRegistriesInWebsite BIT DEFAULT 1 NOT NULL, 
  CoupleUUID UNIQUEIDENTIFIER DEFAULT newid() NOT NULL, 
  MemberId UNIQUEIDENTIFIER, 
  StripeAccountStatus NVARCHAR(50) COLLATE SQL_Latin1_General_CP1_CI_AS, 
  ShortUrl NVARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS, 
  MergedCoupleUUID UNIQUEIDENTIFIER, SourceCoupleUUID UNIQUEIDENTIFIER, 
  SourceCoupleId BIGINT, 
  CONSTRAINT PK_CoupleTemp PRIMARY KEY (CoupleId), 
  CONSTRAINT FK_COUPLE_TEMP_REFERENCE_EVENTTYP FOREIGN KEY (EventTypeId) REFERENCES "EventType" ("EventTypeId"));

SET IDENTITY_INSERT coupleTemp ON;

INSERT INTO coupleTemp 
  (CoupleId, EventTypeId, EventDate, City, State, Zip, 
  Registrant1FirstName, Registrant1LastName, Registrant1Email, 
  Registrant2FirstName, Registrant2LastName, Registrant2Email, 
  IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy, 
  Country, IsPrivate, IsHiddenSearchEngines, IsActive, 
  MergedCoupleId, IsManualOverrided, IsHiddenProducts, 
  IsHiddenProductsInWebsite, IsHiddenRegistriesInWebsite, 
  CoupleUUID, MemberId, StripeAccountStatus, ShortUrl, 
  MergedCoupleUUID, SourceCoupleUUID, SourceCoupleId) 
select CoupleId, EventTypeId, EventDate, City, State, Zip, 
  Registrant1FirstName, Registrant1LastName, Registrant1Email, 
  Registrant2FirstName, Registrant2LastName, Registrant2Email, 
  IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy, 
  Country, IsPrivate, IsHiddenSearchEngines, IsActive, 
  MergedCoupleId, IsManualOverrided, IsHiddenProducts, 
  IsHiddenProductsInWebsite, IsHiddenRegistriesInWebsite, 
  CoupleUUID, MemberId, StripeAccountStatus, ShortUrl, 
  MergedCoupleUUID, SourceCoupleUUID, SourceCoupleId 
from Couple (nolock);

SET IDENTITY_INSERT coupleTemp OFF;


CREATE NONCLUSTERED INDEX [IDX_CoupleTemp_AutoClaim_05] ON [dbo].[CoupleTemp]
(
	[CoupleId] ASC
)
INCLUDE ( 	[EventTypeId]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO

CREATE NONCLUSTERED INDEX [IDX_CoupleTemp_AutoLink_01] ON [dbo].[CoupleTemp]
(
	[IsDeleted] ASC,
	[EventTypeId] ASC,
	[Registrant1FirstName] ASC,
	[Registrant1LastName] ASC,
	[Registrant2FirstName] ASC,
	[Registrant2LastName] ASC,
	[Registrant1Email] ASC
)
INCLUDE ( 	[CoupleId],
	[EventDate],
	[Registrant2Email],
	[CreatedDate],
	[IsActive]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO

CREATE NONCLUSTERED INDEX [IDX_CoupleTemp_AutoLink_02] ON [dbo].[CoupleTemp]
(
	[Registrant1FirstName] ASC,
	[IsDeleted] ASC,
	[EventTypeId] ASC,
	[Registrant1LastName] ASC,
	[Registrant2FirstName] ASC,
	[Registrant2LastName] ASC,
	[Registrant1Email] ASC
)
INCLUDE ( 	[CoupleId],
	[EventDate],
	[Registrant2Email],
	[CreatedDate],
	[IsActive]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO

CREATE NONCLUSTERED INDEX [IDX_CoupleTemp_AutoLink_03] ON [dbo].[CoupleTemp]
(
	[Registrant2LastName] ASC,
	[IsDeleted] ASC,
	[EventTypeId] ASC,
	[Registrant1FirstName] ASC,
	[Registrant1LastName] ASC,
	[Registrant2FirstName] ASC,
	[Registrant1Email] ASC
)
INCLUDE ( 	[CoupleId],
	[EventDate],
	[Registrant2Email],
	[CreatedDate],
	[IsActive]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO

CREATE NONCLUSTERED INDEX [IDX_CoupleTemp_AutoLink_04] ON [dbo].[CoupleTemp]
(
	[Registrant2Email] ASC,
	[IsDeleted] ASC,
	[EventTypeId] ASC,
	[Registrant1FirstName] ASC,
	[Registrant1LastName] ASC,
	[Registrant2FirstName] ASC,
	[Registrant2LastName] ASC
)
INCLUDE ( 	[CoupleId],
	[EventDate],
	[Registrant1Email],
	[CreatedDate],
	[IsActive]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO

CREATE NONCLUSTERED INDEX [IDX_CoupleTemp_AutoLink_05] ON [dbo].[CoupleTemp]
(
	[Registrant1Email] ASC,
	[Registrant2Email] ASC,
	[Registrant1LastName] ASC,
	[Registrant2LastName] ASC,
	[Registrant1FirstName] ASC,
	[IsDeleted] ASC,
	[EventTypeId] ASC
)
INCLUDE ( 	[CoupleId],
	[EventDate],
	[Registrant2FirstName],
	[CreatedDate],
	[IsActive]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO

CREATE NONCLUSTERED INDEX [IDX_CoupleTemp_CoupleSearch_01] ON [dbo].[CoupleTemp]
(
	[IsDeleted] ASC,
	[CoupleId] ASC
)
INCLUDE ( 	[EventTypeId],
	[EventDate],
	[State],
	[Registrant1FirstName],
	[Registrant1LastName],
	[Registrant1Email],
	[Registrant2FirstName],
	[Registrant2LastName],
	[Registrant2Email],
	[ModifiedDate],
	[Country],
	[IsPrivate],
	[IsHiddenSearchEngines],
	[IsActive]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

CREATE UNIQUE NONCLUSTERED INDEX [IDX_Couple_MemberId_EventTypeId_Unique] ON [dbo].[CoupleTemp]
(
	[MemberId] ASC,
	[EventTypeId] ASC,
	[IsDeleted] ASC
)
WHERE ([MemberId] IS NOT NULL AND [IsDeleted]=(0))
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_CoupleTemp_MergedId] ON [dbo].[CoupleTemp]
(
	[MergedCoupleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_CoupleTemp_ModifiedDate] ON [dbo].[CoupleTemp]
(
	[ModifiedDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_CoupleTemp_SourceId] ON [dbo].[CoupleTemp]
(
	[SourceCoupleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_CoupleTemp_SourceUUID] ON [dbo].[CoupleTemp]
(
	[SourceCoupleUUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_CoupleTemp_UUID_01] ON [dbo].[CoupleTemp]
(
	[CoupleUUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO