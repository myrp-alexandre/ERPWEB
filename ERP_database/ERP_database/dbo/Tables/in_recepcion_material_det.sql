CREATE TABLE [dbo].[in_recepcion_material_det] (
    [IdEmpresa]           INT          NOT NULL,
    [IdSucursal]          INT          NOT NULL,
    [IdRecepcionMaterial] NUMERIC (18) NOT NULL,
    [IdOrdenCompra]       NUMERIC (18) NOT NULL,
    [Secuencia]           INT          NOT NULL,
    [IdProducto]          NUMERIC (18) NOT NULL,
    [do_Cantidad]         FLOAT (53)   NOT NULL,
    [re_CantRecibida]     FLOAT (53)   NOT NULL,
    [re_Saldo]            FLOAT (53)   NOT NULL,
    CONSTRAINT [PK_in_recepcion_material_det] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdRecepcionMaterial] ASC, [IdOrdenCompra] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_in_recepcion_material_det_in_Producto] FOREIGN KEY ([IdEmpresa], [IdProducto]) REFERENCES [dbo].[in_Producto] ([IdEmpresa], [IdProducto]),
    CONSTRAINT [FK_in_recepcion_material_det_in_recepcion_material_cab] FOREIGN KEY ([IdEmpresa], [IdSucursal], [IdRecepcionMaterial], [IdOrdenCompra]) REFERENCES [dbo].[in_recepcion_material_cab] ([IdEmpresa], [IdSucursal], [IdRecepcionMaterial], [IdOrdenCompra])
);

