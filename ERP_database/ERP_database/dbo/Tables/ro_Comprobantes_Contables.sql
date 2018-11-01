CREATE TABLE [dbo].[ro_Comprobantes_Contables] (
    [IdEmpresa]      INT           NOT NULL,
    [IdTipoCbte]     INT           NOT NULL,
    [IdCbteCble]     NUMERIC (18)  NOT NULL,
    [CodCtbteCble]   VARCHAR (20)  NOT NULL,
    [IdPeriodo]      INT           NOT NULL,
    [cb_Observacion] VARCHAR (MAX) NULL,
    [IdNomina]       INT           NULL,
    [IdNominaTipo]   INT           NULL,
    CONSTRAINT [PK_ro_Comprobantes_Contables] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdTipoCbte] ASC, [IdCbteCble] ASC, [CodCtbteCble] ASC, [IdPeriodo] ASC)
);

