CREATE TABLE [dbo].[ct_saldoxCuentas_TMP] (
    [IdEmpresa]         INT          NOT NULL,
    [IdAnioF]           INT          NOT NULL,
    [IdPeriodo]         INT          NOT NULL,
    [IdCtaCble]         VARCHAR (20) NOT NULL,
    [IdNivel]           TINYINT      NOT NULL,
    [sc_saldo_anterior] FLOAT (53)   NOT NULL,
    [sc_debito_mes]     FLOAT (53)   NOT NULL,
    [sc_credito_mes]    FLOAT (53)   NOT NULL,
    [sc_saldo_mes]      FLOAT (53)   NOT NULL,
    [sc_saldo_acum]     FLOAT (53)   NOT NULL,
    [IdCentroCosto]     VARCHAR (50) NULL,
    CONSTRAINT [PK_ct_saldoxCuentas_TMP] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdAnioF] ASC, [IdPeriodo] ASC, [IdCtaCble] ASC)
);

