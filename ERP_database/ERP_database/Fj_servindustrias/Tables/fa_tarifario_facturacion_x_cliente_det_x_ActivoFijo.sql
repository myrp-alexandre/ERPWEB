CREATE TABLE [Fj_servindustrias].[fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo] (
    [IdEmpresa]                      INT          NOT NULL,
    [IdTarifario]                    NUMERIC (18) NOT NULL,
    [IdActivoFijo]                   INT          NOT NULL,
    [IdCentroCosto]                  VARCHAR (20) NOT NULL,
    [IdCentroCosto_sub_centro_costo] VARCHAR (20) NOT NULL,
    CONSTRAINT [PK_fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdTarifario] ASC, [IdActivoFijo] ASC),
    CONSTRAINT [FK_fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo_ct_centro_costo_sub_centro_costo] FOREIGN KEY ([IdEmpresa], [IdCentroCosto], [IdCentroCosto_sub_centro_costo]) REFERENCES [dbo].[ct_centro_costo_sub_centro_costo] ([IdEmpresa], [IdCentroCosto], [IdCentroCosto_sub_centro_costo]),
    CONSTRAINT [FK_fa_tarifario_facturacion_x_cliente_det_x_ActivoFijo_fa_tarifario_facturacion_x_cliente] FOREIGN KEY ([IdEmpresa], [IdTarifario]) REFERENCES [Fj_servindustrias].[fa_tarifario_facturacion_x_cliente] ([IdEmpresa], [IdTarifario])
);

