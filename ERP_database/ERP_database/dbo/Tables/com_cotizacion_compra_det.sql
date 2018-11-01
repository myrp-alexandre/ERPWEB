CREATE TABLE [dbo].[com_cotizacion_compra_det] (
    [IdEmpresa]              INT           NOT NULL,
    [IdCotizacion]           NUMERIC (18)  NOT NULL,
    [Secuencia]              INT           NOT NULL,
    [Idproducto]             NUMERIC (18)  NULL,
    [Cant_soli]              FLOAT (53)    NULL,
    [Cant_a_cotizar]         FLOAT (53)    NULL,
    [Observacion]            VARCHAR (250) NULL,
    [IdEmpresa_lq]           INT           NULL,
    [IdListadoMateriales_lq] NUMERIC (18)  NULL,
    [IdDetalle_lq]           INT           NULL,
    [IdUsuario]              VARCHAR (20)  NULL,
    [Fecha_Transac]          DATETIME      NULL,
    [IdUsuarioUltMod]        VARCHAR (20)  NULL,
    [Fecha_UltMod]           DATETIME      NULL,
    [IdUsuarioUltAnu]        VARCHAR (20)  NULL,
    [Fecha_UltAnu]           DATETIME      NULL,
    [MotiAnula]              VARCHAR (100) NULL,
    CONSTRAINT [PK_com_cotizacion_compra_det] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdCotizacion] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_com_cotizacion_compra_det_com_cotizacion_compra] FOREIGN KEY ([IdEmpresa], [IdCotizacion]) REFERENCES [dbo].[com_cotizacion_compra] ([IdEmpresa], [IdCotizacion]),
    CONSTRAINT [FK_com_cotizacion_compra_det_com_ListadoMateriales_Det] FOREIGN KEY ([IdEmpresa_lq], [IdListadoMateriales_lq], [IdDetalle_lq]) REFERENCES [dbo].[com_ListadoMateriales_Det] ([IdEmpresa], [IdListadoMateriales], [IdDetalle]),
    CONSTRAINT [FK_com_cotizacion_compra_det_in_Producto] FOREIGN KEY ([IdEmpresa], [Idproducto]) REFERENCES [dbo].[in_Producto] ([IdEmpresa], [IdProducto])
);

