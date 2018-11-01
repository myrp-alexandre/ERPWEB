CREATE TABLE [Fj_servindustrias].[fa_tarifario_facturacion_x_cliente_det] (
    [IdEmpresa]     INT          NOT NULL,
    [IdTarifario]   NUMERIC (18) NOT NULL,
    [Secuencia]     INT          NOT NULL,
    [cantidad]      INT          NOT NULL,
    [IdCategoriaAF] INT          NOT NULL,
    CONSTRAINT [PK_fa_contrato_facturacion_x_cliente_det] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdTarifario] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_fa_tarifario_facturacion_x_cliente_det_fa_tarifario_facturacion_x_cliente] FOREIGN KEY ([IdEmpresa], [IdTarifario]) REFERENCES [Fj_servindustrias].[fa_tarifario_facturacion_x_cliente] ([IdEmpresa], [IdTarifario])
);

