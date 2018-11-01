CREATE TABLE [dbo].[ct_rpt_SaldoxCta] (
    [IdEmpresa]       INT        NOT NULL,
    [IdCtaCble]       CHAR (20)  NOT NULL,
    [sa_SaldoInicial] FLOAT (53) NOT NULL,
    [sa_Debitos]      FLOAT (53) NOT NULL,
    [sa_Creditos]     FLOAT (53) NOT NULL,
    [sa_SaldoFinal]   FLOAT (53) NOT NULL,
    CONSTRAINT [PK_ct_rpt_SaldoxCta] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdCtaCble] ASC)
);

