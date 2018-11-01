CREATE TABLE [dbo].[in_subgrupo_x_CentroCosto_x_SubCentroCosto_x_CtaCble] (
    [IdEmpresa]          INT          NOT NULL,
    [IdCategoria]        VARCHAR (25) NOT NULL,
    [IdLinea]            INT          NOT NULL,
    [IdGrupo]            INT          NOT NULL,
    [IdSubgrupo]         INT          NOT NULL,
    [IdCentroCosto]      VARCHAR (20) NOT NULL,
    [IdSub_centro_costo] VARCHAR (20) NOT NULL,
    [IdCtaCble]          VARCHAR (20) NULL,
    CONSTRAINT [PK_in_subgrupo_x_CentroCosto_x_SubCentroCosto_x_CtaCble] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdCategoria] ASC, [IdLinea] ASC, [IdGrupo] ASC, [IdSubgrupo] ASC, [IdCentroCosto] ASC, [IdSub_centro_costo] ASC),
    CONSTRAINT [FK_in_subgrupo_x_CentroCosto_x_SubCentroCosto_x_CtaCble_ct_centro_costo_sub_centro_costo] FOREIGN KEY ([IdEmpresa], [IdCentroCosto], [IdSub_centro_costo]) REFERENCES [dbo].[ct_centro_costo_sub_centro_costo] ([IdEmpresa], [IdCentroCosto], [IdCentroCosto_sub_centro_costo]),
    CONSTRAINT [FK_in_subgrupo_x_CentroCosto_x_SubCentroCosto_x_CtaCble_ct_plancta] FOREIGN KEY ([IdEmpresa], [IdCtaCble]) REFERENCES [dbo].[ct_plancta] ([IdEmpresa], [IdCtaCble]),
    CONSTRAINT [FK_in_subgrupo_x_CentroCosto_x_SubCentroCosto_x_CtaCble_in_subgrupo] FOREIGN KEY ([IdEmpresa], [IdCategoria], [IdLinea], [IdGrupo], [IdSubgrupo]) REFERENCES [dbo].[in_subgrupo] ([IdEmpresa], [IdCategoria], [IdLinea], [IdGrupo], [IdSubgrupo])
);

