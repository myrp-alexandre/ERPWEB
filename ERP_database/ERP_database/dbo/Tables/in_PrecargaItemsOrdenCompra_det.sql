CREATE TABLE [dbo].[in_PrecargaItemsOrdenCompra_det] (
    [IdEmpresa]               INT           NOT NULL,
    [IdSucursal]              INT           NOT NULL,
    [IdPrecarga]              NUMERIC (18)  NOT NULL,
    [Secuencia]               INT           NOT NULL,
    [IdProducto]              NUMERIC (18)  NOT NULL,
    [dpr_Cantidad]            FLOAT (53)    NOT NULL,
    [dpr_costo]               FLOAT (53)    NOT NULL,
    [dpr_porc_des]            FLOAT (53)    NOT NULL,
    [dpr_descuento]           FLOAT (53)    NOT NULL,
    [dpr_subtotal]            FLOAT (53)    NOT NULL,
    [dpr_iva]                 FLOAT (53)    NOT NULL,
    [dpr_total]               FLOAT (53)    NOT NULL,
    [dpr_ManejaIva]           CHAR (1)      NOT NULL,
    [dpr_Costeado]            CHAR (1)      NOT NULL,
    [dpr_costo_promedio_hist] FLOAT (53)    NOT NULL,
    [dpr_peso]                FLOAT (53)    NOT NULL,
    [dpr_observacion]         VARCHAR (200) NOT NULL,
    [EstadoProcesado]         CHAR (1)      NOT NULL,
    CONSTRAINT [PK_in_PrecargaItemsOrdenCompra_det] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdPrecarga] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_in_PrecargaItemsOrdenCompra_det_in_PrecargaItemsOrdenCompra] FOREIGN KEY ([IdEmpresa], [IdSucursal], [IdPrecarga]) REFERENCES [dbo].[in_PrecargaItemsOrdenCompra] ([IdEmpresa], [IdSucursal], [IdPrecarga]),
    CONSTRAINT [FK_in_PrecargaItemsOrdenCompra_det_in_Producto] FOREIGN KEY ([IdEmpresa], [IdProducto]) REFERENCES [dbo].[in_Producto] ([IdEmpresa], [IdProducto])
);

