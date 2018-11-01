CREATE TABLE [dbo].[fa_devol_venta_det] (
    [IdEmpresa]      INT          NOT NULL,
    [IdSucursal]     INT          NOT NULL,
    [IdBodega]       INT          NOT NULL,
    [IdDevolucion]   NUMERIC (18) NOT NULL,
    [Secuencia]      INT          NOT NULL,
    [IdProducto]     NUMERIC (18) NOT NULL,
    [dv_cantidad]    FLOAT (53)   NOT NULL,
    [dv_valor]       FLOAT (53)   NOT NULL,
    [dv_PorDescUni]  FLOAT (53)   NULL,
    [dv_descUni]     FLOAT (53)   NOT NULL,
    [dv_PrecioFinal] FLOAT (53)   NOT NULL,
    [dv_subtotal]    FLOAT (53)   NOT NULL,
    [dv_iva]         FLOAT (53)   NOT NULL,
    [dv_total]       FLOAT (53)   NOT NULL,
    [dv_costo]       FLOAT (53)   NOT NULL,
    CONSTRAINT [PK_fa_devol_venta_detalle] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdBodega] ASC, [IdDevolucion] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_fa_devol_venta_det_fa_devol_venta] FOREIGN KEY ([IdEmpresa], [IdSucursal], [IdBodega], [IdDevolucion]) REFERENCES [dbo].[fa_devol_venta] ([IdEmpresa], [IdSucursal], [IdBodega], [IdDevolucion]),
    CONSTRAINT [FK_fa_devol_venta_det_in_Producto] FOREIGN KEY ([IdEmpresa], [IdProducto]) REFERENCES [dbo].[in_Producto] ([IdEmpresa], [IdProducto])
);

