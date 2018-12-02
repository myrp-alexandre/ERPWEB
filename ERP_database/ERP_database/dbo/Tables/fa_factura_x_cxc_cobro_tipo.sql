CREATE TABLE [dbo].[fa_factura_x_cxc_cobro_tipo] (
    [IdEmpresa_fa]   INT          NOT NULL,
    [IdSucursal_fa]  INT          NOT NULL,
    [IdBodega_fa]    INT          NOT NULL,
    [IdCbteVta_fa]   NUMERIC (18) NOT NULL,
    [Secuencia]      INT          NOT NULL,
    [IdCobro_tipo]   VARCHAR (20) NOT NULL,
    [IdEmpresa_cxc]  INT          NOT NULL,
    [IdSucursal_cxc] INT          NOT NULL,
    [IdCobro_cxc]    NUMERIC (18) NOT NULL,
    CONSTRAINT [PK_fa_factura_x_cxc_cobro_tipo] PRIMARY KEY CLUSTERED ([IdEmpresa_fa] ASC, [IdSucursal_fa] ASC, [IdBodega_fa] ASC, [IdCbteVta_fa] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_fa_factura_x_cxc_cobro_tipo_cxc_cobro] FOREIGN KEY ([IdEmpresa_cxc], [IdSucursal_cxc], [IdCobro_cxc]) REFERENCES [dbo].[cxc_cobro] ([IdEmpresa], [IdSucursal], [IdCobro]),
    CONSTRAINT [FK_fa_factura_x_cxc_cobro_tipo_cxc_cobro_tipo] FOREIGN KEY ([IdCobro_tipo]) REFERENCES [dbo].[cxc_cobro_tipo] ([IdCobro_tipo]),
    CONSTRAINT [FK_fa_factura_x_cxc_cobro_tipo_fa_factura] FOREIGN KEY ([IdEmpresa_fa], [IdSucursal_fa], [IdBodega_fa], [IdCbteVta_fa]) REFERENCES [dbo].[fa_factura] ([IdEmpresa], [IdSucursal], [IdBodega], [IdCbteVta])
);

