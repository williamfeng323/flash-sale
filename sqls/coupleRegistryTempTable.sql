CREATE TABLE [dbo].[CoupleRegistryTemp](
	[CoupleRegistryId] [bigint] IDENTITY(1,1) NOT NULL,
	[CoupleId] [bigint] NOT NULL,
	[RetailerId] [int] NULL,
	[RetailerRegistryCode] [nvarchar](70) NULL,
	[ManualRegistryName] [nvarchar](100) NULL,
	[ManualRegistryUrl] [nvarchar](900) NULL,
	[IsHiddenCoupleSearch] [bit] NOT NULL,
	[IsHiddenWebsite] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](100) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](100) NULL,
	[AltRetailerRegistryCode] [nvarchar](70) NULL,
	[RegistryType] [int] NOT NULL,
	[RegistryUUID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_CoupleRegistry] PRIMARY KEY CLUSTERED 
(
	[CoupleRegistryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE NONCLUSTERED INDEX [IDX_CoupleRegistryTemp_02] ON [dbo].[CoupleRegistryTemp]
(
	[CoupleId] ASC,
	[IsDeleted] ASC
)
INCLUDE ( 	[RetailerId],
	[RetailerRegistryCode]) 
GO
 
CREATE UNIQUE NONCLUSTERED INDEX [IDX_CoupleRegistryTemp_CashRegistry_Unique] ON [dbo].[CoupleRegistryTemp]
(
	[CoupleId] ASC,
	[RetailerId] ASC
)
WHERE ([RetailerId]=(19999) AND [IsDeleted]=(0))
GO


CREATE NONCLUSTERED INDEX [IDX_CoupleRegistryTemp_CheckExisting_02] ON [dbo].[CoupleRegistryTemp]
(
	[RetailerId] ASC,
	[IsDeleted] ASC,
	[RetailerRegistryCode] ASC,
	[AltRetailerRegistryCode] ASC
)
GO

CREATE NONCLUSTERED INDEX [IDX_CoupleRegistryTemp_LoadCouple_01] ON [dbo].[CoupleRegistryTemp]
(
	[IsDeleted] ASC,
	[CoupleId] ASC
)
INCLUDE ( 	[CoupleRegistryId],
	[RetailerId],
	[RetailerRegistryCode],
	[ManualRegistryName],
	[ManualRegistryUrl],
	[IsHiddenCoupleSearch],
	[IsHiddenWebsite],
	[CreatedDate],
	[CreatedBy],
	[ModifiedDate],
	[ModifiedBy])
GO

CREATE NONCLUSTERED INDEX [IDX_CoupleRegistryTemp_LoadCouple_02] ON [dbo].[CoupleRegistryTemp]
(
	[IsDeleted] ASC,
	[CoupleId] ASC,
	[RetailerId] ASC
)
GO

CREATE NONCLUSTERED INDEX [IDX_CoupleRegistryTemp_ModifiedDate] ON [dbo].[CoupleRegistryTemp]
(
	[ModifiedDate] ASC
)
GO

CREATE NONCLUSTERED INDEX [IDX_CoupleRegistryTemp_Populator_01] ON [dbo].[CoupleRegistryTemp]
(
	[IsDeleted] ASC,
	[CoupleId] ASC,
	[CoupleRegistryId] ASC,
	[RetailerId] ASC
)
INCLUDE ( 	[RetailerRegistryCode],
	[IsHiddenCoupleSearch]) 
GO

CREATE UNIQUE NONCLUSTERED INDEX [IDX_CoupleRegistryTemp_RegistryCode_Unique_01] ON [dbo].[CoupleRegistryTemp]
(
	[RetailerId] ASC,
	[RetailerRegistryCode] ASC
)
WHERE ([ManualRegistryName] IS NULL)

CREATE NONCLUSTERED INDEX [IDX_CoupleRegistryTemp_UUID] ON [dbo].[CoupleRegistryTemp]
(
	[RegistryUUID] ASC
)
ALTER TABLE [dbo].[CoupleRegistryTemp] ADD  DEFAULT ((0)) FOR [IsHiddenCoupleSearch]
GO
ALTER TABLE [dbo].[CoupleRegistryTemp] ADD  DEFAULT ((0)) FOR [IsHiddenWebsite]
GO
ALTER TABLE [dbo].[CoupleRegistryTemp] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[CoupleRegistryTemp] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[CoupleRegistryTemp] ADD  DEFAULT ((1)) FOR [RegistryType]
GO
ALTER TABLE [dbo].[CoupleRegistryTemp] ADD  DEFAULT (newid()) FOR [RegistryUUID]
GO