CREATE TABLE [dbo].[ba_Cbte_Ban_Datos_Entrega_cheq] (
    [IdEmpresa]           INT            NOT NULL,
    [IdCbteCble]          NUMERIC (18)   NOT NULL,
    [IdTipocbte]          INT            NOT NULL,
    [fecha_hora_entrega]  DATETIME       NOT NULL,
    [IdEstado_cheque_cat] VARCHAR (50)   NOT NULL,
    [IdPersona_Entrega]   NUMERIC (18)   NOT NULL,
    [Nota_entrega]        VARCHAR (1500) NOT NULL,
    [fecha_trans]         DATETIME       NOT NULL,
    [usuario]             VARCHAR (50)   NOT NULL,
    CONSTRAINT [PK_ba_Cbte_Ban_Datos_Entrega_cheq] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdCbteCble] ASC, [IdTipocbte] ASC)
);

