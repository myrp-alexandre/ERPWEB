CREATE TABLE [dbo].[in_responsable] (
    [IdEmpresa]       INT           NOT NULL,
    [IdResponsable]   NUMERIC (18)  NOT NULL,
    [Nom_responsable] VARCHAR (50)  NOT NULL,
    [Estado]          BIT           NOT NULL,
    [IdPersona]       NUMERIC (18)  NULL,
    [IdUsuario]       VARCHAR (20)  NULL,
    [Fecha_Transac]   DATETIME      NULL,
    [IdUsuarioUltMod] VARCHAR (20)  NULL,
    [Fecha_UltMod]    DATETIME      NULL,
    [IdUsuarioUltAnu] VARCHAR (20)  NULL,
    [Fecha_UltAnu]    DATETIME      NULL,
    [MotiAnula]       VARCHAR (100) NULL,
    CONSTRAINT [PK_in_responsable] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdResponsable] ASC)
);

