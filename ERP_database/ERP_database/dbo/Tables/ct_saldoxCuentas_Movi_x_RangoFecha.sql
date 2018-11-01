CREATE TABLE [dbo].[ct_saldoxCuentas_Movi_x_RangoFecha] (
    [IdUsuario]         VARCHAR (50) NOT NULL,
    [IdEmpresa]         INT          NOT NULL,
    [IdCtaCble]         VARCHAR (20) NOT NULL,
    [IdCtaCblePadre]    VARCHAR (20) NOT NULL,
    [sc_saldo_anterior] FLOAT (53)   NOT NULL,
    [sc_debito_mes]     FLOAT (53)   NOT NULL,
    [sc_credito_mes]    FLOAT (53)   NOT NULL,
    [sc_debito_acum]    FLOAT (53)   NOT NULL,
    [sc_credito_acum]   FLOAT (53)   NOT NULL,
    [sc_saldo_mes]      FLOAT (53)   NOT NULL,
    [sc_saldo_acum]     FLOAT (53)   NOT NULL,
    [FechaIni]          DATETIME     NOT NULL,
    [FechaFin]          DATETIME     NOT NULL,
    CONSTRAINT [PK_ct_saldoxCuentas_Movi_x_RangoFecha] PRIMARY KEY CLUSTERED ([IdUsuario] ASC, [IdEmpresa] ASC, [IdCtaCble] ASC)
);

