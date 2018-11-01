CREATE TABLE [dbo].[ct_saldoxCuentas] (
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
    CONSTRAINT [PK_ct_SaldoxCuentas] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdAnioF] ASC, [IdPeriodo] ASC, [IdCtaCble] ASC),
    CONSTRAINT [FK_ct_saldoxCuentas_ct_anio_fiscal] FOREIGN KEY ([IdAnioF]) REFERENCES [dbo].[ct_anio_fiscal] ([IdanioFiscal]),
    CONSTRAINT [FK_ct_saldoxCuentas_ct_periodo] FOREIGN KEY ([IdEmpresa], [IdPeriodo]) REFERENCES [dbo].[ct_periodo] ([IdEmpresa], [IdPeriodo]),
    CONSTRAINT [FK_ct_saldoxCuentas_ct_plancta] FOREIGN KEY ([IdEmpresa], [IdCtaCble]) REFERENCES [dbo].[ct_plancta] ([IdEmpresa], [IdCtaCble])
);

