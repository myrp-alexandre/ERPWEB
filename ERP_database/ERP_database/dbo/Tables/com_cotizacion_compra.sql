CREATE TABLE [dbo].[com_cotizacion_compra] (
    [IdEmpresa]       INT           NOT NULL,
    [IdCotizacion]    NUMERIC (18)  NOT NULL,
    [IdProveedor]     NUMERIC (18)  NULL,
    [Fecha]           DATETIME      NOT NULL,
    [IdSucursal]      INT           NOT NULL,
    [Observacion]     VARCHAR (250) NOT NULL,
    [Estado]          CHAR (1)      NOT NULL,
    [Fecha_Transac]   DATETIME      NULL,
    [Fecha_UltMod]    DATETIME      NULL,
    [IdUsuarioUltMod] CHAR (20)     NULL,
    [FechaHoraAnul]   DATETIME      NULL,
    [IdUsuarioUltAnu] CHAR (20)     NULL,
    [MotivoAnulacion] VARCHAR (500) NULL,
    CONSTRAINT [PK_com_cotizacion_compra] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdCotizacion] ASC),
    CONSTRAINT [FK_com_cotizacion_compra_cp_proveedor] FOREIGN KEY ([IdEmpresa], [IdProveedor]) REFERENCES [dbo].[cp_proveedor] ([IdEmpresa], [IdProveedor]),
    CONSTRAINT [FK_com_cotizacion_compra_tb_sucursal] FOREIGN KEY ([IdEmpresa], [IdSucursal]) REFERENCES [dbo].[tb_sucursal] ([IdEmpresa], [IdSucursal])
);

