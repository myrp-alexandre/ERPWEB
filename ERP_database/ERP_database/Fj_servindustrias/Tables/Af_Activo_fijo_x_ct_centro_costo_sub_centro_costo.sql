CREATE TABLE [Fj_servindustrias].[Af_Activo_fijo_x_ct_centro_costo_sub_centro_costo] (
    [IdEmpresa_AF]                       INT          NOT NULL,
    [IdActivoFijo_AF]                    INT          NOT NULL,
    [IdEmpresa_Scc]                      INT          NOT NULL,
    [IdCentroCosto_Scc]                  VARCHAR (20) NOT NULL,
    [IdCentroCosto_sub_centro_costo_Scc] VARCHAR (20) NOT NULL,
    [Estado]                             BIT          NOT NULL,
    CONSTRAINT [PK_Af_Activo_fijo_x_ct_centro_costo_sub_centro_costo] PRIMARY KEY CLUSTERED ([IdEmpresa_AF] ASC, [IdActivoFijo_AF] ASC, [IdEmpresa_Scc] ASC, [IdCentroCosto_Scc] ASC, [IdCentroCosto_sub_centro_costo_Scc] ASC)
);

