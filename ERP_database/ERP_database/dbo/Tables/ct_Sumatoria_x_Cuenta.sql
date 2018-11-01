CREATE TABLE [dbo].[ct_Sumatoria_x_Cuenta] (
    [IdEmpresa]              INT          NOT NULL,
    [IdCtaCble]              VARCHAR (20) NOT NULL,
    [idusuario]              VARCHAR (50) NOT NULL,
    [IdCtaCblePadre]         VARCHAR (20) NULL,
    [Saldo_Inicial]          FLOAT (53)   NOT NULL,
    [dc_Saldo_deudor]        FLOAT (53)   NOT NULL,
    [dc_Saldo_Acreedor]      FLOAT (53)   NOT NULL,
    [dc_Saldo]               FLOAT (53)   NOT NULL,
    [pc]                     VARCHAR (50) NULL,
    [es_movimento]           CHAR (1)     NULL,
    [Saldo_Inicial_deudor]   FLOAT (53)   NULL,
    [Saldo_Inicial_acreedor] FLOAT (53)   NULL,
    [Saldo_fin_deudor]       FLOAT (53)   NULL,
    [Saldo_fin_acreedor]     FLOAT (53)   NULL,
    CONSTRAINT [PK_ct_Sumatoria_x_Cuenta] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdCtaCble] ASC, [idusuario] ASC),
    CONSTRAINT [FK_ct_Sumatoria_x_Cuenta_ct_plancta] FOREIGN KEY ([IdEmpresa], [IdCtaCble]) REFERENCES [dbo].[ct_plancta] ([IdEmpresa], [IdCtaCble])
);


GO
CREATE NONCLUSTERED INDEX [IX_ct_Sumatoria_x_Cuenta]
    ON [dbo].[ct_Sumatoria_x_Cuenta]([IdEmpresa] ASC, [IdCtaCble] ASC, [idusuario] ASC);

