CREATE TABLE [dbo].[Caj_Talonario_Recibo] (
    [IdEmpresa]             INT           NOT NULL,
    [IdRecibo]              NUMERIC (18)  NOT NULL,
    [IdSucursal]            INT           NOT NULL,
    [IdPuntoVta]            INT           NOT NULL,
    [IdTipo_Docu_cat]       VARCHAR (25)  NOT NULL,
    [Num_Recibo]            VARCHAR (50)  NOT NULL,
    [Usado]                 BIT           NOT NULL,
    [Estado]                BIT           NOT NULL,
    [IdUsuario]             VARCHAR (50)  NULL,
    [Fecha_Transac]         DATETIME      NULL,
    [IdUsuarioUltMod]       VARCHAR (50)  NULL,
    [Fecha_UltMod]          DATETIME      NULL,
    [nom_pc]                VARCHAR (50)  NULL,
    [ip]                    VARCHAR (50)  NULL,
    [IdUsuario_Responsable] VARCHAR (50)  NULL,
    [IdUsuarioUltAnu]       VARCHAR (50)  NULL,
    [Fecha_UltAnu]          DATETIME      NULL,
    [MotivoAnu]             VARCHAR (300) NULL,
    CONSTRAINT [PK_Caj_Talonario_Recibo] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdRecibo] ASC),
    CONSTRAINT [IX_Caj_Talonario_Recibo] UNIQUE NONCLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdPuntoVta] ASC, [Num_Recibo] ASC, [IdTipo_Docu_cat] ASC)
);

