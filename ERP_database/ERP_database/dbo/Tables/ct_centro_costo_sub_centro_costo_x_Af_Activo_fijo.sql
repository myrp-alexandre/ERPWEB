CREATE TABLE [dbo].[ct_centro_costo_sub_centro_costo_x_Af_Activo_fijo] (
    [IdEmpresa_scc]                      INT          NOT NULL,
    [IdCentroCosto_scc]                  VARCHAR (20) NOT NULL,
    [IdCentroCosto_sub_centro_costo_scc] VARCHAR (20) NOT NULL,
    [IdEmpresa_af]                       INT          NOT NULL,
    [IdActivoFijo_af]                    INT          NOT NULL,
    CONSTRAINT [PK_ct_centro_costo_sub_centro_costo_x_Af_ActivoFijo] PRIMARY KEY CLUSTERED ([IdEmpresa_scc] ASC, [IdCentroCosto_scc] ASC, [IdCentroCosto_sub_centro_costo_scc] ASC, [IdEmpresa_af] ASC, [IdActivoFijo_af] ASC)
);

