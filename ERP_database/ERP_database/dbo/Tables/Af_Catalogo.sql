CREATE TABLE [dbo].[Af_Catalogo] (
    [IdCatalogo]      VARCHAR (35)  NOT NULL,
    [IdTipoCatalogo]  VARCHAR (25)  NOT NULL,
    [Descripcion]     VARCHAR (250) NOT NULL,
    [Estado]          VARCHAR (1)   NOT NULL,
    [IdUsuario]       VARCHAR (20)  NULL,
    [nom_pc]          VARCHAR (50)  NULL,
    [ip]              VARCHAR (25)  NULL,
    [IdUsuarioUltMod] VARCHAR (20)  NULL,
    [FechaUltMod]     DATE          NULL,
    [IdUsuarioUltAnu] VARCHAR (25)  NULL,
    [Fecha_UltAnu]    DATE          NULL,
    [MotiAnula]       VARCHAR (100) NULL,
    CONSTRAINT [PK_af_Catalogo] PRIMARY KEY CLUSTERED ([IdCatalogo] ASC),
    CONSTRAINT [FK_Af_Catalogo_Af_CatalogoTipo] FOREIGN KEY ([IdTipoCatalogo]) REFERENCES [dbo].[Af_CatalogoTipo] ([IdTipoCatalogo])
);

