CREATE TABLE [dbo].[fa_factura_det_otros_campos] (
    [IdEmpresa]     INT          NOT NULL,
    [IdSucursal]    INT          NOT NULL,
    [IdBodega]      INT          NOT NULL,
    [IdCbteVta]     NUMERIC (18) NOT NULL,
    [Secuencia]     INT          NOT NULL,
    [IdPunto_Cargo] INT          NULL,
    [Precio_Iva]    FLOAT (53)   NULL,
    CONSTRAINT [PK_fa_factura_det_otros_campos] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdBodega] ASC, [IdCbteVta] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_fa_factura_det_otros_campos_ct_punto_cargo] FOREIGN KEY ([IdEmpresa], [IdPunto_Cargo]) REFERENCES [dbo].[ct_punto_cargo] ([IdEmpresa], [IdPunto_cargo]),
    CONSTRAINT [FK_fa_factura_det_otros_campos_fa_factura] FOREIGN KEY ([IdEmpresa], [IdSucursal], [IdBodega], [IdCbteVta]) REFERENCES [dbo].[fa_factura] ([IdEmpresa], [IdSucursal], [IdBodega], [IdCbteVta])
);

