CREATE TABLE [dbo].[fa_VendedorxSucursal] (
    [IdEmpresa]  INT NOT NULL,
    [IdVendedor] INT NOT NULL,
    [IdSucursal] INT NOT NULL,
    CONSTRAINT [PK_fa_VendedorxSucursal] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdVendedor] ASC, [IdSucursal] ASC),
    CONSTRAINT [FK_fa_VendedorxSucursal_fa_Vendedor] FOREIGN KEY ([IdEmpresa], [IdVendedor]) REFERENCES [dbo].[fa_Vendedor] ([IdEmpresa], [IdVendedor]),
    CONSTRAINT [FK_fa_VendedorxSucursal_tb_sucursal] FOREIGN KEY ([IdEmpresa], [IdSucursal]) REFERENCES [dbo].[tb_sucursal] ([IdEmpresa], [IdSucursal])
);

