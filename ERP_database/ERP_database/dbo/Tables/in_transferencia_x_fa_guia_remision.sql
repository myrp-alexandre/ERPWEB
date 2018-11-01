CREATE TABLE [dbo].[in_transferencia_x_fa_guia_remision] (
    [IdEmpresa]        INT          NOT NULL,
    [IdSucursalOrigen] INT          NOT NULL,
    [IdBodegaOrigen]   INT          NOT NULL,
    [IdTransferencia]  NUMERIC (18) NOT NULL,
    [IdEmpresa_Guia]   INT          NOT NULL,
    [IdSucursal_Guia]  INT          NOT NULL,
    [IdBodega_Guia]    INT          NOT NULL,
    [IdGuiaRemision]   NUMERIC (18) NOT NULL,
    [Obser]            NCHAR (10)   NULL,
    CONSTRAINT [PK_in_transferencia_x_fa_guia_remision_1] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursalOrigen] ASC, [IdBodegaOrigen] ASC, [IdTransferencia] ASC, [IdEmpresa_Guia] ASC, [IdSucursal_Guia] ASC, [IdBodega_Guia] ASC, [IdGuiaRemision] ASC),
    CONSTRAINT [FK_in_transferencia_x_fa_guia_remision_fa_guia_remision] FOREIGN KEY ([IdEmpresa_Guia], [IdSucursal_Guia], [IdBodega_Guia], [IdGuiaRemision]) REFERENCES [dbo].[fa_guia_remision] ([IdEmpresa], [IdSucursal], [IdBodega], [IdGuiaRemision]),
    CONSTRAINT [FK_in_transferencia_x_fa_guia_remision_in_transferencia] FOREIGN KEY ([IdEmpresa], [IdSucursalOrigen], [IdBodegaOrigen], [IdTransferencia]) REFERENCES [dbo].[in_transferencia] ([IdEmpresa], [IdSucursalOrigen], [IdBodegaOrigen], [IdTransferencia])
);

