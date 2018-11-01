CREATE TABLE [Fj_servindustrias].[fa_pre_facturacion_det_otros] (
    [IdEmpresa]                      INT           NOT NULL,
    [IdPreFacturacion]               NUMERIC (18)  NOT NULL,
    [Secuencia]                      INT           NOT NULL,
    [IdCentroCosto_sub_centro_costo] VARCHAR (20)  NOT NULL,
    [IdCentroCosto]                  VARCHAR (20)  NOT NULL,
    [IdActivoFijo]                   INT           NULL,
    [observacion]                    VARCHAR (500) NOT NULL,
    [valor]                          FLOAT (53)    NOT NULL,
    CONSTRAINT [PK_fa_pre_facturacion_det_otros] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdPreFacturacion] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_fa_pre_facturacion_det_otros_Af_Activo_fijo] FOREIGN KEY ([IdEmpresa], [IdActivoFijo]) REFERENCES [dbo].[Af_Activo_fijo] ([IdEmpresa], [IdActivoFijo]),
    CONSTRAINT [FK_fa_pre_facturacion_det_otros_ct_centro_costo_sub_centro_costo] FOREIGN KEY ([IdEmpresa], [IdCentroCosto], [IdCentroCosto_sub_centro_costo]) REFERENCES [dbo].[ct_centro_costo_sub_centro_costo] ([IdEmpresa], [IdCentroCosto], [IdCentroCosto_sub_centro_costo]),
    CONSTRAINT [FK_fa_pre_facturacion_det_otros_fa_pre_facturacion] FOREIGN KEY ([IdEmpresa], [IdPreFacturacion]) REFERENCES [Fj_servindustrias].[fa_pre_facturacion] ([IdEmpresa], [IdPreFacturacion])
);

