CREATE TABLE [dbo].[com_ListadoMateriales_Det_x_com_GenerOCompra_Det] (
    [go_IdEmpresa]           INT          NOT NULL,
    [go_IdTransaccion]       NUMERIC (18) NOT NULL,
    [go_IdDetTrans]          INT          NOT NULL,
    [lm_IdEmpresa]           INT          NOT NULL,
    [lm_IdListadoMateriales] NUMERIC (18) NOT NULL,
    [lm_IdDetalle]           INT          NOT NULL,
    [observacion]            VARCHAR (50) NULL,
    CONSTRAINT [PK_com_ListadoMateriales_Det_x_com_GenerOCompra_Det] PRIMARY KEY CLUSTERED ([go_IdEmpresa] ASC, [go_IdTransaccion] ASC, [go_IdDetTrans] ASC, [lm_IdEmpresa] ASC, [lm_IdListadoMateriales] ASC, [lm_IdDetalle] ASC)
);

