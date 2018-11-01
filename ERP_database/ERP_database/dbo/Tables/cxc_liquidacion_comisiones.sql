CREATE TABLE [dbo].[cxc_liquidacion_comisiones] (
    [IdEmpresa]       INT            NOT NULL,
    [IdLiquidacion]   NUMERIC (18)   NOT NULL,
    [Fecha]           DATETIME       NOT NULL,
    [Observacion]     VARCHAR (1000) NULL,
    [IdVendedor]      INT            NULL,
    [Estado]          BIT            NOT NULL,
    [IdUsuario]       VARCHAR (20)   NULL,
    [FechaTransac]    DATETIME       NULL,
    [IdUsuarioUltMod] VARCHAR (20)   NULL,
    [FechaUltMod]     DATETIME       NULL,
    [IdUsuarioUltAnu] VARCHAR (20)   NULL,
    [FechaUltAnu]     DATETIME       NULL,
    [MotivoAnulacion] VARCHAR (1000) NULL,
    CONSTRAINT [PK_cxc_liquidacion_comisiones] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdLiquidacion] ASC),
    CONSTRAINT [FK_cxc_liquidacion_comisiones_fa_Vendedor] FOREIGN KEY ([IdEmpresa], [IdVendedor]) REFERENCES [dbo].[fa_Vendedor] ([IdEmpresa], [IdVendedor])
);

