CREATE TABLE [dbo].[in_spSys_inv_correccion_producto_oc_ing_apro_det_ing_egr] (
    [IdEmpresa]         INT          NOT NULL,
    [IdSucursal]        INT          NOT NULL,
    [IdMovi_inven_tipo] INT          NOT NULL,
    [IdNumMovi]         NUMERIC (18) NOT NULL,
    [Secuencia]         INT          NOT NULL,
    CONSTRAINT [PK_in_spSys_inv_correccion_producto_oc_ing_apro_det_ing_egr] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdMovi_inven_tipo] ASC, [IdNumMovi] ASC, [Secuencia] ASC)
);

