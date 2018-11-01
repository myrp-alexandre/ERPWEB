CREATE TABLE [dbo].[ct_anio_fiscal_x_cuenta_utilidad] (
    [IdEmpresa]              INT          NOT NULL,
    [IdanioFiscal]           INT          NOT NULL,
    [IdCtaCble]              VARCHAR (20) NULL,
    [observacion]            VARCHAR (50) NULL,
    [IdEmpresa_cbte_cierre]  INT          NULL,
    [IdTipoCbte_cbte_cierre] INT          NULL,
    [IdCbteCble_cbte_cierre] NUMERIC (18) NULL,
    CONSTRAINT [PK_ct_anio_fiscal_x_cuenta_utilidad_1] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdanioFiscal] ASC),
    CONSTRAINT [FK_ct_anio_fiscal_x_cuenta_utilidad_ct_anio_fiscal] FOREIGN KEY ([IdanioFiscal]) REFERENCES [dbo].[ct_anio_fiscal] ([IdanioFiscal]),
    CONSTRAINT [FK_ct_anio_fiscal_x_cuenta_utilidad_ct_cbtecble] FOREIGN KEY ([IdEmpresa_cbte_cierre], [IdTipoCbte_cbte_cierre], [IdCbteCble_cbte_cierre]) REFERENCES [dbo].[ct_cbtecble] ([IdEmpresa], [IdTipoCbte], [IdCbteCble]),
    CONSTRAINT [FK_ct_anio_fiscal_x_cuenta_utilidad_ct_plancta] FOREIGN KEY ([IdEmpresa], [IdCtaCble]) REFERENCES [dbo].[ct_plancta] ([IdEmpresa], [IdCtaCble])
);

