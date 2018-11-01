CREATE TABLE [dbo].[fa_factura_x_formaPago] (
    [IdEmpresa]   INT          NOT NULL,
    [IdSucursal]  INT          NOT NULL,
    [IdBodega]    INT          NOT NULL,
    [IdCbteVta]   NUMERIC (18) NOT NULL,
    [IdFormaPago] VARCHAR (2)  NOT NULL,
    [observacion] VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_fa_factura_x_formaPago] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdBodega] ASC, [IdCbteVta] ASC, [IdFormaPago] ASC),
    CONSTRAINT [FK_fa_factura_x_formaPago_fa_factura] FOREIGN KEY ([IdEmpresa], [IdSucursal], [IdBodega], [IdCbteVta]) REFERENCES [dbo].[fa_factura] ([IdEmpresa], [IdSucursal], [IdBodega], [IdCbteVta]),
    CONSTRAINT [FK_fa_factura_x_formaPago_fa_formaPago] FOREIGN KEY ([IdFormaPago]) REFERENCES [dbo].[fa_formaPago] ([IdFormaPago])
);

