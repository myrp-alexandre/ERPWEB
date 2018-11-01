CREATE TABLE [dbo].[fa_factura_det_x_fa_descuento] (
    [IdEmpresa_fa]  INT          NOT NULL,
    [IdSucursal]    INT          NOT NULL,
    [IdBodega]      INT          NOT NULL,
    [IdCbteVta]     NUMERIC (18) NOT NULL,
    [Secuencia]     INT          NOT NULL,
    [IdEmpresa_de]  INT          NOT NULL,
    [IdDescuento]   NUMERIC (18) NOT NULL,
    [Secuencia_reg] INT          NOT NULL,
    [de_valor]      FLOAT (53)   NOT NULL,
    CONSTRAINT [PK_fa_factura_det_x_fa_descuento] PRIMARY KEY CLUSTERED ([IdEmpresa_fa] ASC, [IdSucursal] ASC, [IdBodega] ASC, [IdCbteVta] ASC, [Secuencia] ASC, [IdEmpresa_de] ASC, [IdDescuento] ASC, [Secuencia_reg] ASC),
    CONSTRAINT [FK_fa_factura_det_x_fa_descuento_fa_descuento] FOREIGN KEY ([IdEmpresa_de], [IdDescuento]) REFERENCES [dbo].[fa_descuento] ([IdEmpresa], [IdDescuento]),
    CONSTRAINT [FK_fa_factura_det_x_fa_descuento_fa_factura_det] FOREIGN KEY ([IdEmpresa_fa], [IdSucursal], [IdBodega], [IdCbteVta], [Secuencia]) REFERENCES [dbo].[fa_factura_det] ([IdEmpresa], [IdSucursal], [IdBodega], [IdCbteVta], [Secuencia])
);

