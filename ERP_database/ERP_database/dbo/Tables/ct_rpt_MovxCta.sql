CREATE TABLE [dbo].[ct_rpt_MovxCta] (
    [IdEmpresa]     INT           NOT NULL,
    [IdPeriodo]     INT           NOT NULL,
    [IdCtaCble]     CHAR (20)     NOT NULL,
    [IdCbteCble]    NUMERIC (18)  NOT NULL,
    [IdCentroCosto] CHAR (20)     NULL,
    [IdTipoCbte]    TINYINT       NOT NULL,
    [FechaCbte]     DATE          NULL,
    [CodCbteCble]   NVARCHAR (20) NOT NULL,
    [sTipoCbte]     CHAR (50)     NOT NULL,
    [Observacion]   CHAR (200)    NOT NULL,
    [Debito]        FLOAT (53)    NOT NULL,
    [Credito]       FLOAT (53)    NOT NULL,
    [Saldo]         FLOAT (53)    NOT NULL,
    [IdUsuario]     VARCHAR (20)  NULL,
    [Nom_Pc]        VARCHAR (20)  NULL,
    CONSTRAINT [PK_ct_rpt_MovxCta] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdPeriodo] ASC, [IdCtaCble] ASC, [IdCbteCble] ASC, [IdTipoCbte] ASC)
);

