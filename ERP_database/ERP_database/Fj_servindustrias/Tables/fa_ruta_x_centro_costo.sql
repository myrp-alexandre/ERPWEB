CREATE TABLE [Fj_servindustrias].[fa_ruta_x_centro_costo] (
    [IdEmpresa]     INT          NOT NULL,
    [IdRuta]        NUMERIC (18) NOT NULL,
    [IdCentroCosto] VARCHAR (20) NOT NULL,
    [ru_costo_x_km] FLOAT (53)   NOT NULL,
    CONSTRAINT [PK_fa_ruta_x_centro_costo] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdRuta] ASC, [IdCentroCosto] ASC),
    CONSTRAINT [FK_fa_ruta_x_centro_costo_Af_ruta] FOREIGN KEY ([IdEmpresa], [IdRuta]) REFERENCES [dbo].[Af_ruta] ([IdEmpresa], [IdRuta]),
    CONSTRAINT [FK_fa_ruta_x_centro_costo_ct_centro_costo] FOREIGN KEY ([IdEmpresa], [IdCentroCosto]) REFERENCES [dbo].[ct_centro_costo] ([IdEmpresa], [IdCentroCosto])
);

