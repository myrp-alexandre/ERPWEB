CREATE TABLE [Fj_servindustrias].[fa_grupo_x_sub_centro_costo_det] (
    [IdEmpresa]                      INT          NOT NULL,
    [IdGrupo]                        NUMERIC (18) NOT NULL,
    [Secuencia]                      INT          NOT NULL,
    [IdCentroCosto_sub_centro_costo] VARCHAR (20) NOT NULL,
    [IdCentroCosto]                  VARCHAR (20) NOT NULL,
    CONSTRAINT [PK_fa_grupo_x_sub_centro_costo_det] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdGrupo] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_fa_grupo_x_sub_centro_costo_det_ct_centro_costo_sub_centro_costo] FOREIGN KEY ([IdEmpresa], [IdCentroCosto], [IdCentroCosto_sub_centro_costo]) REFERENCES [dbo].[ct_centro_costo_sub_centro_costo] ([IdEmpresa], [IdCentroCosto], [IdCentroCosto_sub_centro_costo]),
    CONSTRAINT [FK_fa_grupo_x_sub_centro_costo_det_fa_grupo_x_sub_centro_costo] FOREIGN KEY ([IdEmpresa], [IdGrupo]) REFERENCES [Fj_servindustrias].[fa_grupo_x_sub_centro_costo] ([IdEmpresa], [IdGrupo]),
    CONSTRAINT [FK_fa_grupo_x_sub_centro_costo_det_tb_empresa] FOREIGN KEY ([IdEmpresa]) REFERENCES [dbo].[tb_empresa] ([IdEmpresa])
);

