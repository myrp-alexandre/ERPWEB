CREATE TABLE [dbo].[Af_Tipo_Depreciacion] (
    [IdTipoDepreciacion]    INT           NOT NULL,
    [cod_tipo_depreciacion] VARCHAR (20)  NULL,
    [nom_tipo_depreciacion] VARCHAR (150) NULL,
    [estado]                CHAR (1)      NULL,
    [IdUsuario]             VARCHAR (20)  NULL,
    [Fecha_Transac]         DATETIME      NULL,
    [IdUsuarioUltMod]       VARCHAR (20)  NULL,
    [Fecha_UltMod]          DATETIME      NULL,
    [IdUsuarioUltAnu]       VARCHAR (20)  NULL,
    [Fecha_UltAnu]          DATETIME      NULL,
    [nom_pc]                VARCHAR (50)  NULL,
    [ip]                    VARCHAR (25)  NULL,
    [MotiAnula]             VARCHAR (100) NULL,
    CONSTRAINT [PK_Af_Tipo_Depreciacion] PRIMARY KEY CLUSTERED ([IdTipoDepreciacion] ASC)
);

