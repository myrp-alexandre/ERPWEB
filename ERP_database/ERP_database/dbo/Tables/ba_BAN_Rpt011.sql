CREATE TABLE [dbo].[ba_BAN_Rpt011] (
    [IdEmpresa]      INT          NOT NULL,
    [IdConciliacion] NUMERIC (18) NOT NULL,
    [IdTipoCbte]     INT          NOT NULL,
    [IdCbteCble]     NUMERIC (18) NOT NULL,
    [secuencia]      INT          NOT NULL,
    CONSTRAINT [PK_ba_BAN_Rpt011] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdConciliacion] ASC, [IdTipoCbte] ASC, [IdCbteCble] ASC, [secuencia] ASC)
);

