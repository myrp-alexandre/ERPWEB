CREATE TABLE [Fj_servindustrias].[fa_liquidacion_x_punto_cargo_x_fa_factura] (
    [IdEmpresa]      INT          NOT NULL,
    [IdSucursal]     INT          NOT NULL,
    [IdCentroCosto]  VARCHAR (20) NOT NULL,
    [IdLiquidacion]  NUMERIC (18) NOT NULL,
    [IdEmpresa_vta]  INT          NOT NULL,
    [IdSucursal_vta] INT          NOT NULL,
    [IdBodega_vta]   INT          NOT NULL,
    [IdCbteVta]      NUMERIC (18) NOT NULL,
    [vta_subtotal]   FLOAT (53)   NOT NULL,
    [vta_iva]        FLOAT (53)   NOT NULL,
    [vta_total]      FLOAT (53)   NOT NULL,
    CONSTRAINT [PK_fa_liquidacion_x_punto_cargo_x_fa_factura] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdCentroCosto] ASC, [IdLiquidacion] ASC, [IdEmpresa_vta] ASC, [IdSucursal_vta] ASC, [IdBodega_vta] ASC, [IdCbteVta] ASC),
    CONSTRAINT [FK_fa_liquidacion_x_punto_cargo_x_fa_factura_fa_factura] FOREIGN KEY ([IdEmpresa_vta], [IdSucursal_vta], [IdBodega_vta], [IdCbteVta]) REFERENCES [dbo].[fa_factura] ([IdEmpresa], [IdSucursal], [IdBodega], [IdCbteVta]),
    CONSTRAINT [FK_fa_liquidacion_x_punto_cargo_x_fa_factura_fa_liquidacion_x_punto_cargo] FOREIGN KEY ([IdEmpresa], [IdSucursal], [IdCentroCosto], [IdLiquidacion]) REFERENCES [Fj_servindustrias].[fa_liquidacion_x_punto_cargo] ([IdEmpresa], [IdSucursal], [IdCentroCosto], [IdLiquidacion])
);


GO
CREATE NONCLUSTERED INDEX [IX_fa_liquidacion_x_punto_cargo_x_fa_factura_2]
    ON [Fj_servindustrias].[fa_liquidacion_x_punto_cargo_x_fa_factura]([vta_total] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_fa_liquidacion_x_punto_cargo_x_fa_factura_1]
    ON [Fj_servindustrias].[fa_liquidacion_x_punto_cargo_x_fa_factura]([vta_iva] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_fa_liquidacion_x_punto_cargo_x_fa_factura]
    ON [Fj_servindustrias].[fa_liquidacion_x_punto_cargo_x_fa_factura]([vta_subtotal] ASC);

