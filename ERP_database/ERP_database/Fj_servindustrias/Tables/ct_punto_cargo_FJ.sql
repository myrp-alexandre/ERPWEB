CREATE TABLE [Fj_servindustrias].[ct_punto_cargo_FJ] (
    [IdEmpresa]                      INT          NOT NULL,
    [IdPunto_cargo]                  INT          NOT NULL,
    [IdCentroCosto]                  VARCHAR (20) NULL,
    [IdCentroCosto_sub_centro_costo] VARCHAR (20) NULL,
    CONSTRAINT [PK_ct_punto_cargo_FJ] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdPunto_cargo] ASC),
    CONSTRAINT [FK_ct_punto_cargo_FJ_ct_centro_costo] FOREIGN KEY ([IdEmpresa], [IdCentroCosto]) REFERENCES [dbo].[ct_centro_costo] ([IdEmpresa], [IdCentroCosto]),
    CONSTRAINT [FK_ct_punto_cargo_FJ_ct_centro_costo_sub_centro_costo] FOREIGN KEY ([IdEmpresa], [IdCentroCosto], [IdCentroCosto_sub_centro_costo]) REFERENCES [dbo].[ct_centro_costo_sub_centro_costo] ([IdEmpresa], [IdCentroCosto], [IdCentroCosto_sub_centro_costo]),
    CONSTRAINT [FK_ct_punto_cargo_FJ_ct_punto_cargo] FOREIGN KEY ([IdEmpresa], [IdPunto_cargo]) REFERENCES [dbo].[ct_punto_cargo] ([IdEmpresa], [IdPunto_cargo])
);

