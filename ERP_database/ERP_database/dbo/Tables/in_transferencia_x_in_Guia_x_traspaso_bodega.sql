CREATE TABLE [dbo].[in_transferencia_x_in_Guia_x_traspaso_bodega] (
    [IdEmpresa]       INT           NOT NULL,
    [IdSucursalOrgen] INT           NOT NULL,
    [IdBodegaOrigen]  INT           NOT NULL,
    [IdTransferencia] NUMERIC (18)  NOT NULL,
    [IdEmpresa_Guia]  INT           NOT NULL,
    [IdGuia]          NUMERIC (18)  NOT NULL,
    [Observacion]     VARCHAR (500) NOT NULL,
    CONSTRAINT [PK_in_transferencia_x_in_Guia_x_traspaso_bodega_1] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursalOrgen] ASC, [IdBodegaOrigen] ASC, [IdTransferencia] ASC, [IdEmpresa_Guia] ASC, [IdGuia] ASC),
    CONSTRAINT [FK_in_transferencia_x_in_Guia_x_traspaso_bodega_in_Guia_x_traspaso_bodega] FOREIGN KEY ([IdEmpresa_Guia], [IdGuia]) REFERENCES [dbo].[in_Guia_x_traspaso_bodega] ([IdEmpresa], [IdGuia]),
    CONSTRAINT [FK_in_transferencia_x_in_Guia_x_traspaso_bodega_in_transferencia] FOREIGN KEY ([IdEmpresa], [IdSucursalOrgen], [IdBodegaOrigen], [IdTransferencia]) REFERENCES [dbo].[in_transferencia] ([IdEmpresa], [IdSucursalOrigen], [IdBodegaOrigen], [IdTransferencia])
);

