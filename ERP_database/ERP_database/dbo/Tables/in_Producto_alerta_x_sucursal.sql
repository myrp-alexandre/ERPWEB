CREATE TABLE [dbo].[in_Producto_alerta_x_sucursal] (
    [IdEmpresa]                INT          NOT NULL,
    [IdSucursal]               INT          NOT NULL,
    [IdProducto]               NUMERIC (18) NOT NULL,
    [se_controla_stock_minimo] BIT          NOT NULL,
    [pr_stock_minimo]          FLOAT (53)   NOT NULL,
    [observacion]              VARCHAR (20) NULL,
    CONSTRAINT [PK_in_Producto_alerta_x_sucursal] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdProducto] ASC),
    CONSTRAINT [FK_in_Producto_alerta_x_sucursal_in_Producto] FOREIGN KEY ([IdEmpresa], [IdProducto]) REFERENCES [dbo].[in_Producto] ([IdEmpresa], [IdProducto]),
    CONSTRAINT [FK_in_Producto_alerta_x_sucursal_tb_sucursal] FOREIGN KEY ([IdEmpresa], [IdSucursal]) REFERENCES [dbo].[tb_sucursal] ([IdEmpresa], [IdSucursal])
);

