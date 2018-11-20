CREATE TABLE [dbo].[ro_EmpleadoNovedadCargaMasiva] (
    [IdEmpresa]       INT           NOT NULL,
    [IdCarga]         NUMERIC (18)  NOT NULL,
    [FechaCarga]      DATETIME      NOT NULL,
    [Observacion]     VARCHAR (MAX) NULL,
    [IdRubro]         VARCHAR (50)  NOT NULL,
    [IdUsuario]       VARCHAR (20)  NULL,
    [Estado]          BIT           NOT NULL,
    [Fecha_Transac]   DATETIME      NOT NULL,
    [IdUsuarioUltAnu] VARCHAR (20)  NULL,
    [Fecha_UltAnu]    DATETIME      NULL,
    [MotiAnula]       VARCHAR (200) NULL,
    CONSTRAINT [PK_ro_EmpleadoNovedadCargaMasiva] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdCarga] ASC),
    CONSTRAINT [FK_ro_EmpleadoNovedadCargaMasiva_tb_empresa] FOREIGN KEY ([IdEmpresa]) REFERENCES [dbo].[tb_empresa] ([IdEmpresa])
);

