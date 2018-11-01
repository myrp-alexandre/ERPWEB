CREATE TABLE [Fj_servindustrias].[fa_liquidacion_x_punto_cargo_det_mano_obra] (
    [IdEmpresa]         INT          NOT NULL,
    [IdSucursal]        INT          NOT NULL,
    [IdCentroCosto]     VARCHAR (20) NOT NULL,
    [IdLiquidacion]     NUMERIC (18) NOT NULL,
    [mo_secuencia]      INT          NOT NULL,
    [mo_horas]          FLOAT (53)   NOT NULL,
    [mo_precio_uni]     FLOAT (53)   NOT NULL,
    [mo_por_ganancia]   FLOAT (53)   NOT NULL,
    [mo_valor_ganancia] FLOAT (53)   NOT NULL,
    [mo_precio_total]   FLOAT (53)   NOT NULL,
    [IdProducto]        NUMERIC (18) NOT NULL,
    [IdActividad]       NUMERIC (18) NOT NULL,
    [IdTecnico]         NUMERIC (18) NOT NULL,
    CONSTRAINT [PK_fa_liquidacion_x_punto_cargo_det_mano_obra] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdCentroCosto] ASC, [IdLiquidacion] ASC, [mo_secuencia] ASC),
    CONSTRAINT [FK_fa_liquidacion_x_punto_cargo_det_mano_obra_fa_liquidacion_x_punto_cargo] FOREIGN KEY ([IdEmpresa], [IdSucursal], [IdCentroCosto], [IdLiquidacion]) REFERENCES [Fj_servindustrias].[fa_liquidacion_x_punto_cargo] ([IdEmpresa], [IdSucursal], [IdCentroCosto], [IdLiquidacion]),
    CONSTRAINT [FK_fa_liquidacion_x_punto_cargo_det_mano_obra_in_Producto] FOREIGN KEY ([IdEmpresa], [IdProducto]) REFERENCES [dbo].[in_Producto] ([IdEmpresa], [IdProducto]),
    CONSTRAINT [FK_fa_liquidacion_x_punto_cargo_det_mano_obra_man_actividad] FOREIGN KEY ([IdEmpresa], [IdActividad]) REFERENCES [dbo].[man_actividad] ([IdEmpresa], [IdActividad]),
    CONSTRAINT [FK_fa_liquidacion_x_punto_cargo_det_mano_obra_man_tecnico] FOREIGN KEY ([IdEmpresa], [IdTecnico]) REFERENCES [dbo].[man_tecnico] ([IdEmpresa], [IdTecnico])
);

