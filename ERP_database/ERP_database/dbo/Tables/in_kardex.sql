CREATE TABLE [dbo].[in_kardex] (
    [IdEmpresa]           INT          NOT NULL,
    [IdSucursal]          INT          NOT NULL,
    [IdBodega]            INT          NOT NULL,
    [IdProducto]          NUMERIC (18) NOT NULL,
    [kr_saldoInicial]     FLOAT (53)   NOT NULL,
    [kr_saldoFinal]       FLOAT (53)   NOT NULL,
    [kr_TotalIngresos]    FLOAT (53)   NOT NULL,
    [kr_TotalEgresos]     FLOAT (53)   NOT NULL,
    [kr_TotalMovimientos] FLOAT (53)   NOT NULL,
    [kr_costoInicial]     FLOAT (53)   NOT NULL,
    [kr_costoFinal]       FLOAT (53)   NOT NULL,
    [kr_stockActual]      FLOAT (53)   NOT NULL,
    CONSTRAINT [PK_in_Producto_Saldo_kardex] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdBodega] ASC, [IdProducto] ASC),
    CONSTRAINT [FK_in_kardex_tb_bodega] FOREIGN KEY ([IdEmpresa], [IdSucursal], [IdBodega]) REFERENCES [dbo].[tb_bodega] ([IdEmpresa], [IdSucursal], [IdBodega])
);

