CREATE TABLE [dbo].[in_transferencia_det_x_in_Guia_x_traspaso_bodega_det] (
    [IdEmpresa_trans]        INT          NOT NULL,
    [IdSucursalOrigen_trans] INT          NOT NULL,
    [IdBodegaOrigen_trans]   INT          NOT NULL,
    [IdTransferencia_trans]  NUMERIC (18) NOT NULL,
    [Secuencia_trans]        INT          NOT NULL,
    [IdEmpresa_guia]         INT          NOT NULL,
    [IdGuia_guia]            NUMERIC (18) NOT NULL,
    [Secuencia_guia]         INT          NOT NULL,
    [Observacion]            VARCHAR (20) NULL,
    CONSTRAINT [PK_in_transferencia_det_x_in_Guia_x_traspaso_bodega_det] PRIMARY KEY CLUSTERED ([IdEmpresa_trans] ASC, [IdSucursalOrigen_trans] ASC, [IdBodegaOrigen_trans] ASC, [IdTransferencia_trans] ASC, [IdEmpresa_guia] ASC, [IdGuia_guia] ASC, [Secuencia_guia] ASC, [Secuencia_trans] ASC),
    CONSTRAINT [FK_in_transferencia_det_x_in_Guia_x_traspaso_bodega_det_in_Guia_x_traspaso_bodega_det] FOREIGN KEY ([IdEmpresa_guia], [IdGuia_guia], [Secuencia_guia]) REFERENCES [dbo].[in_Guia_x_traspaso_bodega_det] ([IdEmpresa], [IdGuia], [secuencia]),
    CONSTRAINT [FK_in_transferencia_det_x_in_Guia_x_traspaso_bodega_det_in_transferencia_det] FOREIGN KEY ([IdEmpresa_trans], [IdSucursalOrigen_trans], [IdBodegaOrigen_trans], [IdTransferencia_trans], [Secuencia_trans]) REFERENCES [dbo].[in_transferencia_det] ([IdEmpresa], [IdSucursalOrigen], [IdBodegaOrigen], [IdTransferencia], [dt_secuencia])
);

