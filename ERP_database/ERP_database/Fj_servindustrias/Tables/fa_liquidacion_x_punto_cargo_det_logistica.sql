CREATE TABLE [Fj_servindustrias].[fa_liquidacion_x_punto_cargo_det_logistica] (
    [IdEmpresa]               INT          NOT NULL,
    [IdSucursal]              INT          NOT NULL,
    [IdCentroCosto]           VARCHAR (20) NOT NULL,
    [IdLiquidacion]           NUMERIC (18) NOT NULL,
    [lo_secuencia]            INT          NOT NULL,
    [IdRuta]                  NUMERIC (18) NOT NULL,
    [lo_cantidad]             FLOAT (53)   NOT NULL,
    [lo_kilometros]           FLOAT (53)   NOT NULL,
    [lo_precio_uni_kilometro] FLOAT (53)   NOT NULL,
    [lo_por_ganancia]         FLOAT (53)   NOT NULL,
    [lo_valor_ganancia]       FLOAT (53)   NOT NULL,
    [lo_precio_total]         FLOAT (53)   NOT NULL,
    CONSTRAINT [PK_fa_liquidacion_x_punto_cargo_det_logistica] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdCentroCosto] ASC, [IdLiquidacion] ASC, [lo_secuencia] ASC),
    CONSTRAINT [FK_fa_liquidacion_x_punto_cargo_det_logistica_Af_ruta] FOREIGN KEY ([IdEmpresa], [IdRuta]) REFERENCES [dbo].[Af_ruta] ([IdEmpresa], [IdRuta]),
    CONSTRAINT [FK_fa_liquidacion_x_punto_cargo_det_logistica_fa_liquidacion_x_punto_cargo] FOREIGN KEY ([IdEmpresa], [IdSucursal], [IdCentroCosto], [IdLiquidacion]) REFERENCES [Fj_servindustrias].[fa_liquidacion_x_punto_cargo] ([IdEmpresa], [IdSucursal], [IdCentroCosto], [IdLiquidacion])
);

