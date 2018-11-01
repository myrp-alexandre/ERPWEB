CREATE TABLE [dbo].[Af_Activo_fijo_Categoria] (
    [IdEmpresa]        INT           NOT NULL,
    [IdCategoriaAF]    INT           NOT NULL,
    [IdActivoFijoTipo] INT           NOT NULL,
    [cod_tipo]         VARCHAR (20)  NULL,
    [CodCategoriaAF]   VARCHAR (50)  NULL,
    [Descripcion]      VARCHAR (500) NOT NULL,
    [IdUsuario]        VARCHAR (20)  NULL,
    [Fecha_Transac]    DATETIME      NULL,
    [IdUsuarioUltMod]  VARCHAR (20)  NULL,
    [Fecha_UltMod]     DATETIME      NULL,
    [IdUsuarioUltAnu]  VARCHAR (20)  NULL,
    [Fecha_UltAnu]     DATETIME      NULL,
    [nom_pc]           VARCHAR (50)  NULL,
    [ip]               VARCHAR (25)  NULL,
    [MotiAnula]        VARCHAR (100) NULL,
    [Estado]           CHAR (1)      NOT NULL,
    CONSTRAINT [PK_Af_Activo_fijo_Categoria] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdCategoriaAF] ASC),
    CONSTRAINT [FK_Af_Activo_fijo_Categoria_Af_Activo_fijo_tipo] FOREIGN KEY ([IdEmpresa], [IdActivoFijoTipo]) REFERENCES [dbo].[Af_Activo_fijo_tipo] ([IdEmpresa], [IdActivoFijoTipo])
);

