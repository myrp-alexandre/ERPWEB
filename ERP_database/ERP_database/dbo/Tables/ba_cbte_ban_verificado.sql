CREATE TABLE [dbo].[ba_cbte_ban_verificado] (
    [IdEmpresa]         INT          NOT NULL,
    [IdPeriodo]         INT          NOT NULL,
    [Secuencia]         INT          NOT NULL,
    [tipo_IngEgr]       CHAR (1)     NOT NULL,
    [IdCbteCble]        NUMERIC (18) NOT NULL,
    [IdTipocbte]        INT          NOT NULL,
    [SecuenciaCbteCble] INT          NOT NULL,
    [observacion]       VARCHAR (50) NULL,
    CONSTRAINT [PK_ba_cbte_ban_verificado] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdPeriodo] ASC, [Secuencia] ASC, [tipo_IngEgr] ASC, [IdCbteCble] ASC, [IdTipocbte] ASC, [SecuenciaCbteCble] ASC)
);

