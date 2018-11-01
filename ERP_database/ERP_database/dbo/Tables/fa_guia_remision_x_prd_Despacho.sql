CREATE TABLE [dbo].[fa_guia_remision_x_prd_Despacho] (
    [IdEmpresa_guia]      INT          NOT NULL,
    [IdSucursal_guia]     INT          NOT NULL,
    [IdBodega_guia]       INT          NOT NULL,
    [IdGuiaRemision_guia] NUMERIC (18) NOT NULL,
    [IdEmpresa_des]       INT          NOT NULL,
    [IdSucursal_des]      INT          NOT NULL,
    [IdCentroCosto_des]   VARCHAR (20) NOT NULL,
    [IdDespacho_des]      NUMERIC (18) NOT NULL
);

