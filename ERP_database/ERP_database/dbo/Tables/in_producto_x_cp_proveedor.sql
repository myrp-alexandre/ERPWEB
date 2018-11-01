CREATE TABLE [dbo].[in_producto_x_cp_proveedor] (
    [IdEmpresa_prod]           INT           NOT NULL,
    [IdProducto]               NUMERIC (18)  NOT NULL,
    [IdEmpresa_prov]           INT           NOT NULL,
    [IdProveedor]              NUMERIC (18)  NOT NULL,
    [NomProducto_en_Proveedor] VARCHAR (200) NOT NULL,
    CONSTRAINT [PK_in_producto_x_cp_proveedor] PRIMARY KEY CLUSTERED ([IdEmpresa_prod] ASC, [IdProducto] ASC, [IdEmpresa_prov] ASC, [IdProveedor] ASC),
    CONSTRAINT [FK_in_producto_x_cp_proveedor_cp_proveedor] FOREIGN KEY ([IdEmpresa_prov], [IdProveedor]) REFERENCES [dbo].[cp_proveedor] ([IdEmpresa], [IdProveedor]),
    CONSTRAINT [FK_in_producto_x_cp_proveedor_in_Producto] FOREIGN KEY ([IdEmpresa_prod], [IdProducto]) REFERENCES [dbo].[in_Producto] ([IdEmpresa], [IdProducto])
);

