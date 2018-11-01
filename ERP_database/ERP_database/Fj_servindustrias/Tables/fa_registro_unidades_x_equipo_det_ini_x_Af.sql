CREATE TABLE [Fj_servindustrias].[fa_registro_unidades_x_equipo_det_ini_x_Af] (
    [IdEmpresa]           INT          NOT NULL,
    [IdRegistro]          NUMERIC (18) NOT NULL,
    [IdActivoFijo]        INT          NOT NULL,
    [IdUnidadFact_cat]    VARCHAR (50) NULL,
    [Af_ValorUnidad_Actu] FLOAT (53)   NULL,
    [IdEmpresa_hn]        INT          NULL,
    [IdSucursal_hn]       INT          NULL,
    [IdBodega_hn]         INT          NULL,
    [IdCbteVta_hn]        NUMERIC (18) NULL,
    [IdEmpresa_he]        INT          NULL,
    [IdSucursal_he]       INT          NULL,
    [IdBodega_he]         INT          NULL,
    [IdCbteVta_he]        NUMERIC (18) NULL,
    CONSTRAINT [PK_fa_registro_unidades_x_equipo_det_ini_x_Af_1] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdRegistro] ASC, [IdActivoFijo] ASC),
    CONSTRAINT [FK_fa_registro_unidades_x_equipo_det_ini_x_Af_fa_factura] FOREIGN KEY ([IdEmpresa_hn], [IdSucursal_hn], [IdBodega_hn], [IdCbteVta_hn]) REFERENCES [dbo].[fa_factura] ([IdEmpresa], [IdSucursal], [IdBodega], [IdCbteVta]),
    CONSTRAINT [FK_fa_registro_unidades_x_equipo_det_ini_x_Af_fa_registro_unidades_x_equipo] FOREIGN KEY ([IdEmpresa], [IdRegistro]) REFERENCES [Fj_servindustrias].[fa_registro_unidades_x_equipo] ([IdEmpresa], [IdRegistro])
);

