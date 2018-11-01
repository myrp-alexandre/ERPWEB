CREATE TABLE [dbo].[cxc_Parametros_x_cheqProtesto] (
    [IdEmpresa]                            INT          NOT NULL,
    [secuencia]                            INT          NOT NULL,
    [pa_IdSucursal_x_default_x_cheqProtes] INT          NULL,
    [pa_IdBodega_x_default_x_cheqProtes]   INT          NULL,
    [pa_IdProducto_x_ND_x_CheqProtes]      NUMERIC (18) NULL,
    [pa_IdProducto_x_NC_x_Cobro]           NUMERIC (18) NULL,
    CONSTRAINT [PK_cxc_Parametros_x_cheqProtesto] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [secuencia] ASC),
    CONSTRAINT [FK_cxc_Parametros_x_cheqProtesto_in_Producto] FOREIGN KEY ([IdEmpresa], [pa_IdProducto_x_ND_x_CheqProtes]) REFERENCES [dbo].[in_Producto] ([IdEmpresa], [IdProducto]),
    CONSTRAINT [FK_cxc_Parametros_x_cheqProtesto_in_Producto1] FOREIGN KEY ([IdEmpresa], [pa_IdProducto_x_NC_x_Cobro]) REFERENCES [dbo].[in_Producto] ([IdEmpresa], [IdProducto]),
    CONSTRAINT [FK_cxc_Parametros_x_cheqProtesto_tb_bodega] FOREIGN KEY ([IdEmpresa], [pa_IdSucursal_x_default_x_cheqProtes], [pa_IdBodega_x_default_x_cheqProtes]) REFERENCES [dbo].[tb_bodega] ([IdEmpresa], [IdSucursal], [IdBodega]),
    CONSTRAINT [FK_cxc_Parametros_x_cheqProtesto_tb_empresa] FOREIGN KEY ([IdEmpresa]) REFERENCES [dbo].[tb_empresa] ([IdEmpresa])
);

