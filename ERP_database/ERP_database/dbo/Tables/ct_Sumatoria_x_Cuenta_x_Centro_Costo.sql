CREATE TABLE [dbo].[ct_Sumatoria_x_Cuenta_x_Centro_Costo] (
    [IdEmpresa]              INT          NOT NULL,
    [IdCtaCble]              VARCHAR (20) NOT NULL,
    [IdCtaCblePadre]         VARCHAR (20) NULL,
    [Saldo_Inicial]          FLOAT (53)   NOT NULL,
    [dc_Saldo_deudor]        FLOAT (53)   NOT NULL,
    [dc_Saldo_Acreedor]      FLOAT (53)   NOT NULL,
    [dc_Saldo]               FLOAT (53)   NOT NULL,
    [idusuario]              VARCHAR (50) NULL,
    [pc]                     VARCHAR (50) NULL,
    [es_movimento]           CHAR (1)     NULL,
    [IdCentroCosto]          VARCHAR (20) NULL,
    [Saldo_Inicial_deudor]   FLOAT (53)   NULL,
    [Saldo_Inicial_acreedor] FLOAT (53)   NULL,
    [Saldo_fin_deudor]       FLOAT (53)   NULL,
    [Saldo_fin_acreedor]     FLOAT (53)   NULL
);

