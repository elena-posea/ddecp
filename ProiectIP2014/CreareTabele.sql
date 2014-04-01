CREATE TABLE [dbo].[aspnet_Applications] (
    [ApplicationName]        NVARCHAR (256)   NOT NULL,
    [LoweredApplicationName] NVARCHAR (256)   NOT NULL,
    [ApplicationId]          UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [Description]            NVARCHAR (256)   NULL,
    PRIMARY KEY NONCLUSTERED ([ApplicationId] ASC),
    UNIQUE NONCLUSTERED ([LoweredApplicationName] ASC),
    UNIQUE NONCLUSTERED ([ApplicationName] ASC)
);


GO
CREATE CLUSTERED INDEX [aspnet_Applications_Index]
    ON [dbo].[aspnet_Applications]([LoweredApplicationName] ASC);

CREATE TABLE [dbo].[aspnet_Membership] (
    [ApplicationId]                          UNIQUEIDENTIFIER NOT NULL,
    [UserId]                                 UNIQUEIDENTIFIER NOT NULL,
    [Password]                               NVARCHAR (128)   NOT NULL,
    [PasswordFormat]                         INT              DEFAULT ((0)) NOT NULL,
    [PasswordSalt]                           NVARCHAR (128)   NOT NULL,
    [MobilePIN]                              NVARCHAR (16)    NULL,
    [Email]                                  NVARCHAR (256)   NULL,
    [LoweredEmail]                           NVARCHAR (256)   NULL,
    [PasswordQuestion]                       NVARCHAR (256)   NULL,
    [PasswordAnswer]                         NVARCHAR (128)   NULL,
    [IsApproved]                             BIT              NOT NULL,
    [IsLockedOut]                            BIT              NOT NULL,
    [CreateDate]                             DATETIME         NOT NULL,
    [LastLoginDate]                          DATETIME         NOT NULL,
    [LastPasswordChangedDate]                DATETIME         NOT NULL,
    [LastLockoutDate]                        DATETIME         NOT NULL,
    [FailedPasswordAttemptCount]             INT              NOT NULL,
    [FailedPasswordAttemptWindowStart]       DATETIME         NOT NULL,
    [FailedPasswordAnswerAttemptCount]       INT              NOT NULL,
    [FailedPasswordAnswerAttemptWindowStart] DATETIME         NOT NULL,
    [Comment]                                NTEXT            NULL,
    PRIMARY KEY NONCLUSTERED ([UserId] ASC),
    FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[aspnet_Applications] ([ApplicationId]),
    FOREIGN KEY ([UserId]) REFERENCES [dbo].[aspnet_Users] ([UserId])
);
CREATE TABLE [dbo].[aspnet_Paths] (
    [ApplicationId] UNIQUEIDENTIFIER NOT NULL,
    [PathId]        UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [Path]          NVARCHAR (256)   NOT NULL,
    [LoweredPath]   NVARCHAR (256)   NOT NULL,
    PRIMARY KEY NONCLUSTERED ([PathId] ASC),
    FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
);


GO
CREATE UNIQUE CLUSTERED INDEX [aspnet_Paths_index]
    ON [dbo].[aspnet_Paths]([ApplicationId] ASC, [LoweredPath] ASC);


CREATE TABLE [dbo].[aspnet_PersonalizationAllUsers] (
    [PathId]          UNIQUEIDENTIFIER NOT NULL,
    [PageSettings]    IMAGE            NOT NULL,
    [LastUpdatedDate] DATETIME         NOT NULL,
    PRIMARY KEY CLUSTERED ([PathId] ASC),
    FOREIGN KEY ([PathId]) REFERENCES [dbo].[aspnet_Paths] ([PathId])
);


GO
EXECUTE sp_tableoption @TableNamePattern = N'[dbo].[aspnet_PersonalizationAllUsers]', @OptionName = N'text in row', @OptionValue = N'6000';

CREATE TABLE [dbo].[aspnet_PersonalizationPerUser] (
    [Id]              UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [PathId]          UNIQUEIDENTIFIER NULL,
    [UserId]          UNIQUEIDENTIFIER NULL,
    [PageSettings]    IMAGE            NOT NULL,
    [LastUpdatedDate] DATETIME         NOT NULL,
    PRIMARY KEY NONCLUSTERED ([Id] ASC),
    FOREIGN KEY ([PathId]) REFERENCES [dbo].[aspnet_Paths] ([PathId]),
    FOREIGN KEY ([UserId]) REFERENCES [dbo].[aspnet_Users] ([UserId])
);


GO
EXECUTE sp_tableoption @TableNamePattern = N'[dbo].[aspnet_PersonalizationPerUser]', @OptionName = N'text in row', @OptionValue = N'6000';


GO
CREATE UNIQUE CLUSTERED INDEX [aspnet_PersonalizationPerUser_index1]
    ON [dbo].[aspnet_PersonalizationPerUser]([PathId] ASC, [UserId] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [aspnet_PersonalizationPerUser_ncindex2]
    ON [dbo].[aspnet_PersonalizationPerUser]([UserId] ASC, [PathId] ASC);


CREATE TABLE [dbo].[aspnet_Profile] (
    [UserId]               UNIQUEIDENTIFIER NOT NULL,
    [PropertyNames]        NTEXT            NOT NULL,
    [PropertyValuesString] NTEXT            NOT NULL,
    [PropertyValuesBinary] IMAGE            NOT NULL,
    [LastUpdatedDate]      DATETIME         NOT NULL,
    PRIMARY KEY CLUSTERED ([UserId] ASC),
    FOREIGN KEY ([UserId]) REFERENCES [dbo].[aspnet_Users] ([UserId])
);


GO
EXECUTE sp_tableoption @TableNamePattern = N'[dbo].[aspnet_Profile]', @OptionName = N'text in row', @OptionValue = N'6000';

CREATE TABLE [dbo].[aspnet_Roles] (
    [ApplicationId]   UNIQUEIDENTIFIER NOT NULL,
    [RoleId]          UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [RoleName]        NVARCHAR (256)   NOT NULL,
    [LoweredRoleName] NVARCHAR (256)   NOT NULL,
    [Description]     NVARCHAR (256)   NULL,
    PRIMARY KEY NONCLUSTERED ([RoleId] ASC),
    FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
);


GO
CREATE UNIQUE CLUSTERED INDEX [aspnet_Roles_index1]
    ON [dbo].[aspnet_Roles]([ApplicationId] ASC, [LoweredRoleName] ASC);


CREATE TABLE [dbo].[aspnet_SchemaVersions] (
    [Feature]                 NVARCHAR (128) NOT NULL,
    [CompatibleSchemaVersion] NVARCHAR (128) NOT NULL,
    [IsCurrentVersion]        BIT            NOT NULL,
    PRIMARY KEY CLUSTERED ([Feature] ASC, [CompatibleSchemaVersion] ASC)
);

CREATE TABLE [dbo].[aspnet_Users] (
    [ApplicationId]    UNIQUEIDENTIFIER NOT NULL,
    [UserId]           UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [UserName]         NVARCHAR (256)   NOT NULL,
    [LoweredUserName]  NVARCHAR (256)   NOT NULL,
    [MobileAlias]      NVARCHAR (16)    DEFAULT (NULL) NULL,
    [IsAnonymous]      BIT              DEFAULT ((0)) NOT NULL,
    [LastActivityDate] DATETIME         NOT NULL,
    PRIMARY KEY NONCLUSTERED ([UserId] ASC),
    FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
);


GO
CREATE UNIQUE CLUSTERED INDEX [aspnet_Users_Index]
    ON [dbo].[aspnet_Users]([ApplicationId] ASC, [LoweredUserName] ASC);


GO
CREATE NONCLUSTERED INDEX [aspnet_Users_Index2]
    ON [dbo].[aspnet_Users]([ApplicationId] ASC, [LastActivityDate] ASC);

CREATE TABLE [dbo].[aspnet_UsersInRoles] (
    [UserId] UNIQUEIDENTIFIER NOT NULL,
    [RoleId] UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY CLUSTERED ([UserId] ASC, [RoleId] ASC),
    FOREIGN KEY ([UserId]) REFERENCES [dbo].[aspnet_Users] ([UserId]),
    FOREIGN KEY ([RoleId]) REFERENCES [dbo].[aspnet_Roles] ([RoleId])
);


GO
CREATE NONCLUSTERED INDEX [aspnet_UsersInRoles_index]
    ON [dbo].[aspnet_UsersInRoles]([RoleId] ASC);

CREATE TABLE [dbo].[aspnet_WebEvent_Events] (
    [EventId]                CHAR (32)       NOT NULL,
    [EventTimeUtc]           DATETIME        NOT NULL,
    [EventTime]              DATETIME        NOT NULL,
    [EventType]              NVARCHAR (256)  NOT NULL,
    [EventSequence]          DECIMAL (19)    NOT NULL,
    [EventOccurrence]        DECIMAL (19)    NOT NULL,
    [EventCode]              INT             NOT NULL,
    [EventDetailCode]        INT             NOT NULL,
    [Message]                NVARCHAR (1024) NULL,
    [ApplicationPath]        NVARCHAR (256)  NULL,
    [ApplicationVirtualPath] NVARCHAR (256)  NULL,
    [MachineName]            NVARCHAR (256)  NOT NULL,
    [RequestUrl]             NVARCHAR (1024) NULL,
    [ExceptionType]          NVARCHAR (256)  NULL,
    [Details]                NTEXT           NULL,
    PRIMARY KEY CLUSTERED ([EventId] ASC)
);


CREATE TABLE [dbo].[Comentarii_Proiect] (
    [id_comentariu] UNIQUEIDENTIFIER NOT NULL,
    [cod_user]      UNIQUEIDENTIFIER NOT NULL,
    [cod_proiect]   UNIQUEIDENTIFIER NOT NULL,
    [continut]      NVARCHAR (MAX)   NOT NULL,
    [data]          DATE             NOT NULL,
    PRIMARY KEY CLUSTERED ([id_comentariu] ASC),
    FOREIGN KEY ([cod_user]) REFERENCES [dbo].[aspnet_Users] ([UserId]),
    FOREIGN KEY ([cod_proiect]) REFERENCES [dbo].[Proiecte] ([id_proiect])
);

CREATE TABLE [dbo].[Comentarii_Stire] (
    [id_comentariu] UNIQUEIDENTIFIER NOT NULL,
    [cod_user]      UNIQUEIDENTIFIER NOT NULL,
    [cod_stire]     UNIQUEIDENTIFIER NOT NULL,
    [continut]      NVARCHAR (MAX)   NOT NULL,
    [data]          DATE             NOT NULL,
    PRIMARY KEY CLUSTERED ([id_comentariu] ASC),
    FOREIGN KEY ([cod_user]) REFERENCES [dbo].[aspnet_Users] ([UserId]),
    FOREIGN KEY ([cod_stire]) REFERENCES [dbo].[Stiri] ([id_stire])
);

CREATE TABLE [dbo].[ComentariiProiect] (
    [id_comentariu] UNIQUEIDENTIFIER NOT NULL,
    [cod_user]      UNIQUEIDENTIFIER NOT NULL,
    [cod_proiect]   UNIQUEIDENTIFIER NOT NULL,
    [continut]      NVARCHAR (MAX)   NOT NULL,
    [data]          DATE             NOT NULL,
    PRIMARY KEY CLUSTERED ([id_comentariu] ASC),
    FOREIGN KEY ([cod_user]) REFERENCES [dbo].[aspnet_Users] ([UserId]),
    FOREIGN KEY ([cod_proiect]) REFERENCES [dbo].[Proiecte] ([id_proiect])
);

CREATE TABLE [dbo].[Fisiere_Atasate] (
    [id_fisier]   UNIQUEIDENTIFIER NOT NULL,
    [cod_user]    UNIQUEIDENTIFIER NOT NULL,
    [cod_proiect] UNIQUEIDENTIFIER NOT NULL,
    [link]        NVARCHAR (3000)  NOT NULL,
    PRIMARY KEY CLUSTERED ([id_fisier] ASC),
    FOREIGN KEY ([cod_user]) REFERENCES [dbo].[aspnet_Users] ([UserId]),
    FOREIGN KEY ([cod_proiect]) REFERENCES [dbo].[Proiecte] ([id_proiect])
);

CREATE TABLE [dbo].[Proiecte] (
    [id_proiect]   UNIQUEIDENTIFIER NOT NULL,
    [cod_user]     UNIQUEIDENTIFIER NOT NULL,
    [data_inceput] DATE             NOT NULL,
    [data_sfarsit] DATE             NOT NULL,
    [nume]         NVARCHAR (50)    NOT NULL,
    [descriere]    NVARCHAR (MAX)   NOT NULL,
    [domeniu]      NVARCHAR (50)    NOT NULL,
    PRIMARY KEY CLUSTERED ([id_proiect] ASC),
    FOREIGN KEY ([cod_user]) REFERENCES [dbo].[aspnet_Users] ([UserId])
);

CREATE TABLE [dbo].[Stiri] (
    [id_stire] UNIQUEIDENTIFIER NOT NULL,
    [cod_user] UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY CLUSTERED ([id_stire] ASC),
    FOREIGN KEY ([cod_user]) REFERENCES [dbo].[aspnet_Users] ([UserId])
);

CREATE TABLE [dbo].[User_are_Colaboratori] (
    [cod_user]    UNIQUEIDENTIFIER NOT NULL,
    [cod_proiect] UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY CLUSTERED ([cod_user] ASC, [cod_proiect] ASC),
    FOREIGN KEY ([cod_user]) REFERENCES [dbo].[aspnet_Users] ([UserId]),
    FOREIGN KEY ([cod_proiect]) REFERENCES [dbo].[Proiecte] ([id_proiect])
);

