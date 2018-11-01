CREATE TABLE [Fj_servindustrias].[fa_liquidacion_x_punto_cargo_det_mano_obra_det] (
    [IdEmpresa]     INT          NOT NULL,
    [IdSucursal]    INT          NOT NULL,
    [IdCentroCosto] VARCHAR (20) NOT NULL,
    [IdLiquidacion] NUMERIC (18) NOT NULL,
    [mo_secuencia]  INT          NOT NULL,
    [IdActividad]   NUMERIC (18) NOT NULL,
    [observacion]   VARCHAR (2)  NULL,
    CONSTRAINT [PK_fa_liquidacion_x_punto_cargo_det_mano_obra_det_1] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdCentroCosto] ASC, [IdLiquidacion] ASC, [mo_secuencia] ASC, [IdActividad] ASC),
    CONSTRAINT [FK_fa_liquidacion_x_punto_cargo_det_mano_obra_det_fa_liquidacion_x_punto_cargo_det_mano_obra] FOREIGN KEY ([IdEmpresa], [IdSucursal], [IdCentroCosto], [IdLiquidacion], [mo_secuencia]) REFERENCES [Fj_servindustrias].[fa_liquidacion_x_punto_cargo_det_mano_obra] ([IdEmpresa], [IdSucursal], [IdCentroCosto], [IdLiquidacion], [mo_secuencia]),
    CONSTRAINT [FK_fa_liquidacion_x_punto_cargo_det_mano_obra_det_man_actividad] FOREIGN KEY ([IdEmpresa], [IdActividad]) REFERENCES [dbo].[man_actividad] ([IdEmpresa], [IdActividad])
);

