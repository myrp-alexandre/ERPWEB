CREATE TABLE [Fj_servindustrias].[fa_pre_facturacion_activos] (
    [IdEmpresa]                      INT          NOT NULL,
    [IdPreFacturacion]               NUMERIC (18) NOT NULL,
    [Secuencia]                      INT          NOT NULL,
    [IdActivoFijo]                   INT          NOT NULL,
    [por_ganancia]                   FLOAT (53)   NOT NULL,
    [IdCentroCosto]                  VARCHAR (20) NOT NULL,
    [IdCentroCosto_sub_centro_costo] VARCHAR (20) NOT NULL,
    [IdPeriodo_ini]                  INT          NOT NULL,
    [IdPeriodo_fin]                  INT          NOT NULL,
    [cant_act_x_scc]                 INT          NOT NULL,
    [IdGrupo]                        NUMERIC (18) NOT NULL,
    [valor_depr_x_scc]               FLOAT (53)   NULL,
    [valor_movilizacion]             FLOAT (53)   NULL,
    CONSTRAINT [PK_fa_pre_facturacion_activos] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdPreFacturacion] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_fa_pre_facturacion_activos_Af_Activo_fijo] FOREIGN KEY ([IdEmpresa], [IdActivoFijo]) REFERENCES [dbo].[Af_Activo_fijo] ([IdEmpresa], [IdActivoFijo]),
    CONSTRAINT [FK_fa_pre_facturacion_activos_ct_centro_costo_sub_centro_costo] FOREIGN KEY ([IdEmpresa], [IdCentroCosto], [IdCentroCosto_sub_centro_costo]) REFERENCES [dbo].[ct_centro_costo_sub_centro_costo] ([IdEmpresa], [IdCentroCosto], [IdCentroCosto_sub_centro_costo]),
    CONSTRAINT [FK_fa_pre_facturacion_activos_fa_grupo_x_sub_centro_costo] FOREIGN KEY ([IdEmpresa], [IdGrupo]) REFERENCES [Fj_servindustrias].[fa_grupo_x_sub_centro_costo] ([IdEmpresa], [IdGrupo]),
    CONSTRAINT [FK_fa_pre_facturacion_activos_fa_pre_facturacion] FOREIGN KEY ([IdEmpresa], [IdPreFacturacion]) REFERENCES [Fj_servindustrias].[fa_pre_facturacion] ([IdEmpresa], [IdPreFacturacion])
);

