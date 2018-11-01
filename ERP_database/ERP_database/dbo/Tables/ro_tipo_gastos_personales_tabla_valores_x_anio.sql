CREATE TABLE [dbo].[ro_tipo_gastos_personales_tabla_valores_x_anio] (
    [IdGasto]         INT           NOT NULL,
    [IdTipoGasto]     VARCHAR (10)  NOT NULL,
    [AnioFiscal]      INT           NOT NULL,
    [Monto_max]       FLOAT (53)    NOT NULL,
    [observacion]     VARCHAR (50)  NOT NULL,
    [estado]          CHAR (1)      NOT NULL,
    [IdUsuario]       VARCHAR (20)  NULL,
    [Fecha_Transac]   DATETIME      NULL,
    [IdUsuarioUltMod] VARCHAR (20)  NULL,
    [Fecha_UltMod]    DATETIME      NULL,
    [IdUsuarioUltAnu] VARCHAR (20)  NULL,
    [Fecha_UltAnu]    DATETIME      NULL,
    [nom_pc]          VARCHAR (50)  NULL,
    [ip]              VARCHAR (25)  NULL,
    [MotiAnula]       VARCHAR (200) NULL,
    CONSTRAINT [PK_ro_tipo_gastos_personales_tabla_valores_x_anio] PRIMARY KEY CLUSTERED ([IdGasto] ASC, [IdTipoGasto] ASC, [AnioFiscal] ASC),
    CONSTRAINT [FK_ro_tipo_gastos_personales_tabla_valores_x_anio_ro_tipo_gastos_personales] FOREIGN KEY ([IdTipoGasto]) REFERENCES [dbo].[ro_tipo_gastos_personales] ([IdTipoGasto])
);

