CREATE TABLE [dbo].[ct_saldoxCuentas_Movi_tmp] (
    [IdEmpresa]         INT          NOT NULL,
    [IdAnioF]           INT          NOT NULL,
    [IdPeriodo]         INT          NOT NULL,
    [IdCtaCble]         VARCHAR (20) NOT NULL,
    [IdCtaCblePadre]    VARCHAR (20) NOT NULL,
    [sc_saldo_anterior] FLOAT (53)   NOT NULL,
    [sc_debito_mes]     FLOAT (53)   NOT NULL,
    [sc_credito_mes]    FLOAT (53)   NOT NULL,
    [sc_debito_acum]    FLOAT (53)   NOT NULL,
    [sc_credito_acum]   FLOAT (53)   NOT NULL,
    [sc_saldo_acum]     FLOAT (53)   NOT NULL,
    CONSTRAINT [PK_ct_saldoxCuentas_Movi_tmp] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdAnioF] ASC, [IdPeriodo] ASC, [IdCtaCble] ASC)
);

