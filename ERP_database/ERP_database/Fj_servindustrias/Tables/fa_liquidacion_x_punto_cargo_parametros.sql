CREATE TABLE [Fj_servindustrias].[fa_liquidacion_x_punto_cargo_parametros] (
    [IdEmpresa]     INT          NOT NULL,
    [lo_IdProducto] DECIMAL (18) NULL,
    [eg_IdProducto] DECIMAL (18) NULL,
    [in_IdProducto] DECIMAL (18) NULL,
    CONSTRAINT [PK_fa_liquidacion_x_punto_cargo_parametros] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC)
);

