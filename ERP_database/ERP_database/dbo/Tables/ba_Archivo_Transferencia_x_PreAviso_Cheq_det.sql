CREATE TABLE [dbo].[ba_Archivo_Transferencia_x_PreAviso_Cheq_det] (
    [IdEmpresa]               INT           NOT NULL,
    [IdArchivo_preaviso_cheq] NUMERIC (18)  NOT NULL,
    [secuencia]               INT           NOT NULL,
    [observacion_det]         VARCHAR (950) NOT NULL,
    [IdEmpresa_mvba]          INT           NOT NULL,
    [IdCbteCble_mvba]         NUMERIC (18)  NOT NULL,
    [IdTipocbte_mvba]         INT           NOT NULL,
    CONSTRAINT [PK_ba_Archivo_Transferencia_x_PreAviso_Cheq_det] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdArchivo_preaviso_cheq] ASC, [secuencia] ASC),
    CONSTRAINT [FK_ba_Archivo_Transferencia_x_PreAviso_Cheq_det_ba_Archivo_Transferencia_x_PreAviso_Cheq] FOREIGN KEY ([IdEmpresa], [IdArchivo_preaviso_cheq]) REFERENCES [dbo].[ba_Archivo_Transferencia_x_PreAviso_Cheq] ([IdEmpresa], [IdArchivo_preaviso_cheq]),
    CONSTRAINT [FK_ba_Archivo_Transferencia_x_PreAviso_Cheq_det_ba_Cbte_Ban] FOREIGN KEY ([IdEmpresa_mvba], [IdCbteCble_mvba], [IdTipocbte_mvba]) REFERENCES [dbo].[ba_Cbte_Ban] ([IdEmpresa], [IdCbteCble], [IdTipocbte])
);

