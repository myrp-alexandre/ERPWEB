CREATE TABLE [dbo].[in_spSys_inv_correccion_producto_oc_ing_apro_det_oc] (
    [IdEmpresa]     INT          NOT NULL,
    [IdSucursal]    INT          NOT NULL,
    [IdOrdenCompra] NUMERIC (18) NOT NULL,
    [Secuencia]     INT          NOT NULL,
    CONSTRAINT [PK_in_spSys_inv_correccion_producto_oc_ing_apro_det_oc] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdOrdenCompra] ASC, [Secuencia] ASC)
);

